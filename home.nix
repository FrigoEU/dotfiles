{ config, pkgs, lib, ... }:
let
#  pragmatapro = import ./pragmatapro.nix {runCommand = pkgs.runCommand;
#                                          requireFile = pkgs.requireFile;
#                                          unzip = pkgs.unzip;
#                                         };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "simon";
    homeDirectory = "/home/simon";
    sessionVariables = {
      EDITOR = "neovim";
    };
    stateVersion = "22.05";
    packages = with pkgs; [
      xclip # For neovim clipboard integration
    ];
    shellAliases = {
      nv = "neovide --frame None";
    };
  };

  xresources = {
    path = ./tokyo-xresources;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.lazygit = {
    enable = true;
  };

  programs.gitui = {
    enable = true;
    keyConfig = ./gituikeyconfig.ron;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = [];
    extraConfig = builtins.concatStringsSep "\n" [
      # (lib.strings.fileContents ./base.vim)
      # (lib.strings.fileContents ./plugins.vim)
      # (lib.strings.fileContents ./lsp.vim)
      #(lib.strings.fileContents ./coc.vim)
      ''
        lua << EOF
        ${lib.strings.fileContents ./init.lua}
        EOF
      ''
    ];

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim

      which-key-nvim
      tokyonight-nvim
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

      project-nvim

      telescope-fzf-native-nvim
      bufdelete-nvim

      surround-nvim

      kommentary
      nvim-autopairs
      neoformat
      impatient-nvim
      nvim-tree-lua

      toggleterm-nvim

      vim-nix
      neogit

      # telescope-ui-select-nvim
      # nvim-lspconfig


    ];

  };
}
