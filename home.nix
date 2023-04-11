{ config, pkgs, lib, ... }:
let
#  pragmatapro = import ./pragmatapro.nix {runCommand = pkgs.runCommand;
#                                          requireFile = pkgs.requireFile;
#                                          unzip = pkgs.unzip;
#                                         };

  yanky-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "yanky-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "gbprod";
      repo = "yanky.nvim";
      rev = "c4c794afd762a00ca543972e5b9e34ce9aa14a87";
      sha256 = "EcdC9HTWB/r6W6U6Ad808aaZPwzRnxfGQ/fSrsy11gI=";
    };
  };

  # sessions-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
  #   name = "sessions-nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "natecraddock";
  #     repo = "sessions.nvim";
  #     rev = "65a93344a85b226b7e29efc6ae231c4e5614804e";
  #     sha256 = "K3lbjQ7Ks9zlYMJWB31Gj2uL6st6fYGSx7qtnIGjst8=";
  #   };
  # };

  # workspaces-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
  #   name = "workspaces-nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "natecraddock";
  #     repo = "workspaces.nvim";
  #     rev = "dd9574c8a6fbd4910bf298fcd1175a0222e9a09d";
  #     sha256 = "ZQsIhzeSYCdQCVBn8ACJ3nlS9Ukz4AJLbkn2yOqTllM=";
  #   };
  # };

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
      luajitPackages.lua-lsp
    ];
    shellAliases = {
      # nv = "neovide --frame None";
    };
    # file.sumneko-lua-language-server = {
    #   source = pkgs.sumneko-lua-language-server;
    #   target = ".local/share/sumneko-lua-language-server";
    # };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # https://github.com/notusknot/dotfiles-nix/tree/main/modules/nvim
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      which-key-nvim
      tokyonight-nvim
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

      bufdelete-nvim

      surround-nvim

      kommentary
      nvim-autopairs
      neoformat
      impatient-nvim
      nvim-tree-lua

      # toggleterm-nvim
      neoterm

      vim-nix

      # telescope-ui-select-nvim
      # nvim-lspconfig

      coc-nvim
      coc-tsserver

      # hop-nvim -- later
      project-nvim
      # workspaces-nvim
      # sessions-nvim

      nvim-web-devicons
      lualine-nvim

      yanky-nvim

      # neogit

      vim-fugitive
      vim-flog # https://github.com/rbong/vim-flog/blob/master/EXAMPLES.md

      coq_nvim
     ];

  };
}
