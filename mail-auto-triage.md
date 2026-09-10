Look at ~/.emacs.d/config/config-email.el. It contains some emacs functions for ad-hoc email triage. It works well, but I'd like to port it to TypeScript as much as possible and want it to run automatically, probably inside the PI coding agent eventually with a choice of models of Claude, Gemini & Codex, but I currently only have a Claude company account - see ~/.emacs.d/config/config-ai.el so just use Claude Code.

I want 3 typescript scripts in a new project folder at ~/projects/email-triage-school

1. Download all my gmail emails. I guess this is to be done with (isync mu msmtp)? The current setup in emacs works well so ideally reuse/copy it.

2. Start a simple "workflow" for all 
  * unread emails to "*@classy.school"
  * unread emails with a label "EmailTriage" (to-email irrelevant)

Order from new to old. Chunk per 4 emails, don't start the next chunk until the full agent flow is done for all 4 (so to avoid starting 50 agents and them all immediately stopping because tokens are gone).

First check that this email isn't handled yet: Look at ~/email-triage-school (name = <threadid+lastemailstamp>.json). If the file exists there, skip completely.

Start a pi agent process with cwd="~/projects/school" with the following prompt (make sure it's easy for me to finetune this later):
<prompt>
The following is a support email for my SaaS for music schools.
Read the full email and situate it in the codebase.
Summarize the email.
If code changes are needed, make a new worktree (name = summary of topic) and do the changes there (starting from master).

```
%s
```

After code changes are done (or if no code changes are needed), write a JSON file to "~/projects/email-triage-school/emails" (name = <threadid+lastemailstamp>.json) with the following schema:

{
  "subject": string,                 // 1 line subject line
  "gmail_link": string,              // URL of email thread on gmail
  "summary": string,                 // multi line summary: What's the problem/bug/feature/question reported by the user
  "proposed_solution": string,       // plan: just an email reply, bug fix, build feature, ...
  "worktree": string | null,         // if any code changes are made, provide the name of the worktree
  "email_draft": string              // draft of the reply. Conciseness above all. No full sentences
}
</prompt>

If the agent fails because of account limits, don't report anything, don't write any files, just skip this and all next emails.

Questions:
- I use claude code now and don't have much experience with pi. I'd like to be able to easily adjust which harness + model I want to use. 
- Should the agent invocation process just be a child_process or are there typescript libraries that would give a better result?

3. Make a small typescript server script that reads ~/projects/email-triage-school/emails and shows a row for each JSON file. Make it look modern, use a premade style kit.
Use trader.ts and the architecture I use in ~/projects/school.

Actions on these rows: 
- Navigate to gmail URL
- Show all details
- Copy email_draft to clipboard
- Open worktree as a seperate project and seperate workspace in Emacs
- Delete JSON file

Questions:
- Which style/css kit would work well for this?
- Can I open the worktree as a proj + workspace with a single button click?

Then I want to schedule, in configuration-shared.nix, at 2 AM and at 7 AM, to first run the email download script, then the email triage script
