{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # themes
        # BeardedBear.beardedicons
        # jussiemion.darcula-solid

        # web dev
        formulahendry.auto-rename-tag
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        svelte.svelte-vscode
        bradlc.vscode-tailwindcss

        # rust
        tamasfe.even-better-toml
        rust-lang.rust-analyzer

        # misc syntax highlighting
        # beaglefoot.awk-ide-vscode
        skellock.just
        # bbenoist.Nix
        # jnoortheen.nix-ide # need to fix some issue with the formatter before enabling this
        # TheNuProjectContributors.vscode-nushell-lang
        ziglang.vscode-zig

        # misc
        aaron-bond.better-comments
        # LeonardSSH.vscord
        usernamehw.errorlens
        wakatime.vscode-wakatime
      ];

      userSettings = {
        "workbench.iconTheme" = "bearded-icons";
        "workbench.colorTheme" = "Darcula Solid";
        "editor.fontFamily" = "'ComicShannsMono Nerd Font Mono', 'monospace', monospace";
        "workbench.secondarySideBar.defaultVisibility" = "hidden";

        "security.workspace.trust.untrustedFiles" = "open";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "window.commandCenter" = false;
        "explorer.fileNesting.patterns" = {
          "*.ts" = "$\{capture}.js";
          "*.js" = "$\{capture}.js.map, $\{capture}.min.js, $\{capture}.d.ts";
          "*.jsx" = "$\{capture}.js";
          "*.tsx" = "$\{capture}.ts";
          "tsconfig.json" = "tsconfig.*.json";
          "package.json" = "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb, bun.lock";
          "Cargo.toml" = "Cargo.lock";
          "*.sqlite" = "$\{capture}.$\{extname}-*";
          "*.db" = "$\{capture}.$\{extname}-*";
          "*.sqlite3" = "$\{capture}.$\{extname}-*";
          "*.db3" = "$\{capture}.$\{extname}-*";
          "*.sdb" = "$\{capture}.$\{extname}-*";
          "*.s3db" = "$\{capture}.$\{extname}-*";
        };
        "terminal.integrated.enableImages" = true;

        "editor.insertSpaces" = false;
        "editor.unicodeHighlight.invisibleCharacters" = false;

        "files.autoSave" = "onFocusChange";
        "editor.formatOnSave" = true;

        "vscord.app.name" = "VSCodium";
        "vscord.behaviour.debug" = true;
        "vscord.behaviour.prioritizeLanguagesOverExtensions" = true;
        "vscord.status.idle.check" = false;
        "vscord.status.idle.enabled" = false;
        "vscord.status.state.idle.enabled" = false;
        "vscord.status.problems.enabled" = false;
        "vscord.status.state.text.editing" = "slopifying {line_count} lines of {file_name}{file_extension}";
        # need to do this because for some reason discord hates when i put an actual url and it crashes people
        "vscord.status.image.large.debugging.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.large.editing.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.large.idle.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.large.notInFile.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.large.viewing.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.small.debugging.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.small.editing.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.small.idle.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.small.notInFile.key" = "bad url so discord defaults to vscodium icon";
        "vscord.status.image.small.viewing.key" = "bad url so discord defaults to vscodium icon";

        "git.autofetch" = true;
        "git.confirmSync" = false;

        "svelte.enable-ts-plugin" = true;

        "zig.zls.enabled" = "on";

        "[json,jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[rs]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
      };
    };
  };
}
