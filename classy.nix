# Classy (~/projects/school) background jobs: email triage + sales automation.
# Overview + diagrams: ~/projects/school/docs/SALES.md.
# Imported from configuration-shared.nix.

{ pkgs, lib, ... }:

let
  # Outreach switches, see ~/projects/school/typescript/sales/sequence.ts.
  # Start with both "0" (dry run: report mails only), flip after checking.
  outreachEnv = [
    "OUTREACH_LIVE=0" # 1 = really send mails
    "OUTREACH_DEMOS=0" # 1 = /demo-setup demo per new first contact (prod tenants!)
  ];

  # A oneshot job in ~/projects/school, as simon, with the prod db tunnel.
  classyJob = { description, command, timeout }: {
    inherit description;
    requires = [ "pg-tunnel.service" ];
    after = [ "pg-tunnel.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "simon";
      WorkingDirectory = "/home/simon/projects/school";
      TimeoutStartSec = timeout;
      Environment = outreachEnv;
      ExecStart = pkgs.writeShellScript "classy-job" ''
        set -eu
        export PATH="$PATH:/run/wrappers/bin:/etc/profiles/per-user/simon/bin:/run/current-system/sw/bin"
        cd /home/simon/projects/school
        # wait for the tunnel to actually accept connections
        for _ in $(seq 30); do ${pkgs.netcat}/bin/nc -z localhost 4000 && break; sleep 1; done
        exec ${pkgs.systemd}/bin/systemd-inhibit --what=sleep --who=classy-job --why=${lib.escapeShellArg description} \
          ${pkgs.nix}/bin/nix develop --command ${command}
      '';
    };
  };
in
{
  # Let simon's background jobs (no login session) hold a sleep inhibitor,
  # so Plasma's idle auto-suspend doesn't kill them halfway.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.login1.inhibit-block-sleep"
          && subject.user == "simon") {
        return polkit.Result.YES;
      }
    });
  '';

  # ~/projects/email-triage-school: download mail, then triage unread
  # classy.school / EmailTriage-labeled threads with a Claude Code agent per
  # thread. `nix develop` picks up that project's own flake.nix for
  # node/tsx; mbsync/mu/msmtp/claude-code are in systemPackages
  # (configuration-shared.nix). Test manually with `systemctl start email-triage`, watch with
  # `journalctl -u email-triage -f`.
  systemd.services.email-triage = {
    description = "Download mail, then run classy.school email-triage agents";
    serviceConfig = {
      Type = "oneshot";
      User = "simon";
      WorkingDirectory = "/home/simon/projects/email-triage-school";
      ExecStart = pkgs.writeShellScript "email-triage-run" ''
        set -e
        cd /home/simon/projects/email-triage-school
        ${pkgs.systemd}/bin/systemd-inhibit --what=sleep --who=email-triage --why="triaging mail" \
          ${pkgs.nix}/bin/nix develop --command sh -c "npx tsx download.ts; npx tsx triage.ts"
      '';
    };
  };

  systemd.timers.email-triage = {
    description = "Run email-triage at 2am and 7am";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = [ "02:00" "07:00" "18:00" "22:00" ];
      Persistent = true;
    };
  };

  # ~/projects/school sales automation. Overview + diagrams:
  # ~/projects/school/docs/SALES.md ("Schedule").
  #
  #   00:00  sales-nightly (wakes the PC from suspend)
  #            email-triage → outreach-prepare → prospect-verify
  #            → suspend again, only if this timer woke the PC and nobody uses it
  #   09:00  outreach-send (Persistent: runs as soon as the PC is on)
  #
  # All jobs that touch the prod db use pg-tunnel. Watch any of them with
  # `journalctl -u <name> -f`, run by hand with `systemctl start <name>`.

  # Prod landingpage db on localhost:4000 (= `make tunnel_pg`, which is no
  # longer needed while this runs). Needs an ssh key usable without the agent.
  systemd.services.pg-tunnel = {
    description = "ssh tunnel to classyprod postgres on localhost:4000";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      User = "simon";
      ExecStart = "${pkgs.openssh}/bin/ssh -N -o BatchMode=yes -o ExitOnForwardFailure=yes -o ServerAliveInterval=15 -o ServerAliveCountMax=3 -L 4000:localhost:5432 root@classyprod";
      # also reconnects after suspend/resume (ServerAlive notices the dead link)
      Restart = "always";
      RestartSec = 5;
    };
  };

  systemd.services.outreach-prepare = classyJob {
    description = "Outreach: stage bookkeeping + queue due mails (+ demos on Wednesday)";
    command = "npm run sales -- --prepare";
    timeout = "6h";
  };

  systemd.services.outreach-send = classyJob {
    description = "Outreach: recheck and send queued mails";
    command = "npm run sales -- --send";
    timeout = "5h";
  };

  systemd.timers.outreach-send = {
    description = "Send queued outreach mails from 09:00";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = [ "09:00" ];
      Persistent = true;
    };
  };

  # Temporary: re-verify prospects until the Claude usage limit (or 08:00,
  # STOP_AT_HOUR in typescript/scripts/sales/verify_prospects.ts).
  # Remove from sales-nightly once all prospects are verified.
  systemd.services.prospect-verify = classyJob {
    description = "Verify classy.school prospects with Claude Code agents";
    command = "npm run sales -- --verify-prospects";
    timeout = "10h";
  };

  systemd.services.sales-nightly = {
    description = "Nightly batch: triage, outreach prepare, prospect verify, sleep";
    serviceConfig = {
      Type = "oneshot";
      TimeoutStartSec = "12h";
      ExecStart = pkgs.writeShellScript "sales-nightly-run" ''
        set -u
        # did this timer wake the PC? (resume in the last 10 minutes)
        woke=0
        if ${pkgs.systemd}/bin/journalctl -q -b -u systemd-suspend.service --since "-10min" \
             | ${pkgs.gnugrep}/bin/grep -qEi "returned from sleep|resumed"; then
          woke=1
        fi

        # each job failing on its own is fine, the others still run
        ${pkgs.systemd}/bin/systemctl start email-triage.service || echo "email-triage failed"
        ${pkgs.systemd}/bin/systemctl start outreach-prepare.service || echo "outreach-prepare failed"
        ${pkgs.systemd}/bin/systemctl start prospect-verify.service || echo "prospect-verify failed"

        if [ "$woke" != 1 ]; then
          echo "PC was already awake at midnight, not suspending"
          exit 0
        fi
        # someone came back to the PC in the meantime?
        for s in $(${pkgs.systemd}/bin/loginctl list-sessions --no-legend | ${pkgs.gawk}/bin/awk '{print $1}'); do
          if [ "$(${pkgs.systemd}/bin/loginctl show-session "$s" -p IdleHint --value)" = "no" ] \
             && [ "$(${pkgs.systemd}/bin/loginctl show-session "$s" -p Active --value)" = "yes" ]; then
            echo "session $s is in use, not suspending"
            exit 0
          fi
        done
        # inhibitors (video playing, ...) still block this
        ${pkgs.systemd}/bin/systemctl suspend || echo "suspend refused (inhibitor?)"
      '';
    };
  };

  systemd.timers.sales-nightly = {
    description = "Wake the PC at midnight for the nightly sales batch";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = [ "00:00" ];
      WakeSystem = true;
    };
  };
}
