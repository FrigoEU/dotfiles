{ config, pkgs, ... }:
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

  home.file.".config/nvim/init.lua".source = ./init.lua;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = [
      pkgs.ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      # which-key-nvim
      # project-nvim
      {
        plugin = telescope-nvim;
        config = "lua require('telescope').setup()";
      }
      # telescope-fzf-native-nvim
      # telescope-project-nvim
      # tokyonight-nvim
      # toggleterm-nvim
      # surround-nvim
      # nvim-lspconfig

      # telescope-ui-select-nvim
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
    ];

  };
}
