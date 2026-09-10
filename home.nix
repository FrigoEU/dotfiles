{ config, pkgs, lib, plasma-manager, ... }:

let
  # Symlink straight to the file in this repo instead of copying it into the
  # Nix store: matches the current `ln -s $PWD/x ~/.x` workflow (edits apply
  # without a rebuild, original file permissions are preserved).
  mkLink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [ plasma-manager.homeModules.plasma-manager ];

  home.username = "simon";
  home.homeDirectory = "/home/simon";
  home.stateVersion = "26.05";

  home.file = {
    ".bashrc".source = mkLink ./.bashrc;
    ".spacemacs".source = mkLink ./.spacemacs;
    ".alacritty.yml".source = mkLink ./.alacritty.yml;
    ".mbsyncrc".source = mkLink ./.mbsyncrc;
    ".msmtprc".source = mkLink ./.msmtprc;

    ".claude/settings.json".source = mkLink ./claude-settings.json;
    ".claude/agents".source = mkLink ./claude-agents;
    ".claude/keybindings.json".source = mkLink ./claude-keybindings.json;

    ".claude-company/settings.json".source = mkLink ./claude-settings.json;
    ".claude-company/agents".source = mkLink ./claude-agents;
    ".claude-company/keybindings.json".source = mkLink ./claude-keybindings.json;

    ".pi/agent/settings.json".source = mkLink ./pi-settings.json;
    ".pi/agent/extensions/deny-files.ts".source = mkLink ./pi-deny-files.ts;
  };

  xdg.configFile = {
    "direnv/direnv.toml".source = mkLink ./direnv.toml;

    "nvim/init.lua".source = mkLink ./init.lua;
    "nvim/coc-settings.json".source = mkLink ./coc-settings.json;
    "nvim/lua".source = mkLink ./lua;

    "fuzzel/fuzzel.ini".source = mkLink ./fuzzel.ini;

    "doom/init.el".source = mkLink ./doom/init.el;
    "doom/packages.el".source = mkLink ./doom/packages.el;
    "doom/config.el".source = mkLink ./doom/config.el;
  };

  # KDE Plasma config, migrated from configuration-shared.nix's
  # environment.etc plasma-workspace login scripts (kwriteconfig6 calls).
  programs.plasma = {
    enable = true;

    # Auto-lock is friction with auto-login already on; keep both idle-lock
    # and lock-on-suspend/resume off.
    kscreenlocker = {
      autoLock = false;
      lockOnResume = false;
    };

    # Don't restart emacs every login (vterm breaks otherwise): always start
    # with an empty session instead of restoring the previous one.
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    configFile = {
      # Baloo spins the fan for no benefit; excludePackages doesn't work
      # since baloorunner ships inside plasma-workspace itself.
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;

      # Bind the Windows/Meta key to launch fuzzel. kwinrc's old
      # ModifierOnlyShortcuts group was removed in Plasma 6.1 - modifier-only
      # global shortcuts now go through the per-service "_launch" action in
      # kglobalshortcutsrc instead.
      kglobalshortcutsrc."services][fuzzel.desktop"._launch = "Meta";
    };
  };
}
