// Global pi extension: make specific files/paths off-limits to all tools.
//
// Deny-list semantics (the inverse of pi-file-permissions' allow-list): everything
// stays accessible except the paths listed in DENY below. Loaded globally from
// ~/.pi/agent/extensions/, so it applies to every project.
//
// Matching is on the resolved absolute path. Entries may be:
//   - an absolute path            "/home/simon/.secrets"
//   - a "~"-relative path         "~/.ssh/id_ed25519"
//   - a project-relative path     ".env"            (resolved against pi's cwd)
//   - a glob                      "**/*.pem", "secrets/**"
// A bare directory also blocks everything inside it.

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";
import { homedir } from "node:os";
import { isAbsolute, resolve, sep } from "node:path";

const DENY: string[] = [
  "~/.secrets",
  "~/projects/school/typescript/classyts/secrets.ts",
  ".env",
  ".env.*",
  "**/*.pem",
  "**/id_rsa",
  "**/id_ed25519",
];

// File tools whose `path` argument points at the file being touched.
const PATH_TOOLS = new Set(["read", "edit", "write", "grep", "ls"]);

function expand(p: string): string {
  if (p === "~") return homedir();
  if (p.startsWith("~/")) return resolve(homedir(), p.slice(2));
  return p;
}

function toAbs(p: string): string {
  const e = expand(p);
  return isAbsolute(e) ? resolve(e) : resolve(process.cwd(), e);
}

function isGlob(p: string): boolean {
  return /[*?[\]]/.test(p);
}

// Minimal glob -> RegExp: supports **, *, ? on an absolute path string.
function globToRegExp(glob: string): RegExp {
  let re = "";
  for (let i = 0; i < glob.length; i++) {
    const c = glob[i];
    if (c === "*") {
      if (glob[i + 1] === "*") {
        re += ".*"; // ** matches across separators
        i++;
        if (glob[i + 1] === "/") i++; // collapse **/ so it can also match zero dirs
      } else {
        re += "[^/]*";
      }
    } else if (c === "?") {
      re += "[^/]";
    } else {
      re += c.replace(/[.+^${}()|\\]/g, "\\$&");
    }
  }
  return new RegExp(`^${re}$`);
}

function matchesDeny(candidate: string): string | null {
  const abs = toAbs(candidate);
  for (const entry of DENY) {
    if (isGlob(entry)) {
      // Glob-match against both the expanded pattern and an absolutized form,
      // so "**/*.pem" works without the user writing an absolute pattern.
      const expanded = expand(entry);
      if (globToRegExp(expanded).test(abs)) return entry;
      if (!isAbsolute(expanded) && globToRegExp(toAbs(entry)).test(abs)) return entry;
    } else {
      const target = toAbs(entry);
      if (abs === target || abs.startsWith(target + sep)) return entry;
    }
  }
  return null;
}

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event) => {
    // File tools: block when the target path is off-limits.
    if (PATH_TOOLS.has(event.toolName)) {
      const path = (event.input as { path?: string }).path;
      if (typeof path === "string") {
        const hit = matchesDeny(path);
        if (hit) {
          return { block: true, reason: `Path is off-limits (matched deny rule "${hit}")` };
        }
      }
    }

    // bash: best-effort. A shell command can reach a file in countless ways
    // (cat/less/sed/cp, $VARS, globs), so this only catches the literal path or
    // basename appearing in the command. It is a backstop, not a guarantee.
    if (isToolCallEventType("bash", event)) {
      const cmd = event.input.command ?? "";
      for (const entry of DENY) {
        if (isGlob(entry)) continue;
        const base = entry.replace(/^~\//, "").split("/").pop();
        if (base && cmd.includes(base)) {
          return { block: true, reason: `Command references off-limits path "${base}"` };
        }
      }
    }
  });
}
