;; -*- 
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; protobuf
     lua
     yaml
     python
     ;; ocaml
     ;; (rust :variables rust-backend 'lsp)
     ;; (haskell :variables haskell-completion-backend 'lsp)
     ;; csv
     sml
     ;; graphviz
     ;; ruby
     ;; purescript
     ;; ruby
     ;; sml
     ;; ocaml
     ;; ruby
     ;; vimscript
     ;; markdown
     tree-sitter
     theming
     (java :variables java-backend 'lsp)
     ;; (java :variables java-backend 'meghanada)
     ;; (fsharp :variables fsharp-backend 'lsp)
     sql
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     helm
     ;; (compleseus :variables
     ;;             compleseus-engine 'selectrum)

     auto-completion
     ;; better-defaults
     (csharp :variables
             ;; csharp-backend 'lsp
             csharp-backend 'omnisharp
             )
     ;; emacs-lisp
     javascript
     (typescript :variables
                 typescript-backend 'tide
                 ;; typescript-fmt-tool 'prettier
                 ;; typescript-fmt-on-save t
                 )
     html
     ;; lsp
     ;; dap
     ;; haskell
     ;; purescript
     git
     (lsp :variables lsp-headerline-breadcrumb-segments nil)
     ;; spotify
     ;; clojure
     ;; idris
     ;; markdown
     ;; org
     (shell :variables
            shell-default-height 30
            shell-default-shell 'eshell
            shell-default-position 'bottom)
     ;; spell-checking
     syntax-checking
     (treemacs :variables
               treemacs-collapse-dirs 0
               treemacs-use-follow-mode nil)
     ;; treemacs
     ;; themes-megapack
     ;; version-control
     ;; (exwm :variables
     ;;       exwm-enable-systray t
     ;;       ;; exwm-install-logind-lock-handler t
     ;;       )
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '((nix-mode)
                                      (direnv)
                                      (dirvish)
                                      ;; (exec-path-from-shell)
                                      (doom-themes)
                                      ;; (eshell-vterm) ;; Run "visual" commands like htop and psql in vterm instead of term
                                      (apheleia) ;; async formatting
                                      ;; (edbi)
                                      ;; (company-edbi :location (recipe :fetcher github :repo "dvzubarev/company-edbi"))
                                      ;; (fsharp-mode)
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '(
                                ;; (recents . 5)
                                ;; (projects . 7)
                                )

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-one
                         spacemacs-dark
                         doom-gruvbox-light
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '(
                               ;; "PragmataPro Mono Liga"
                               "Victor Mono"
                               :size 16
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup t

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling f

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
)

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
)


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
)


(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (setq js2-basic-offset 2)
  (setq js-indent-level 2)
  (setq typescript-indent-level 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-level 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-quoting nil)
  (setq css-indent-offset 2)
  (setq json-indent-offset 2)
  ;; (setq helm-external-commands-list ...)


  (setq theming-modifications
        '((doom-one
           ;; Give comments a different look
           (font-lock-comment-face :slant italic
                                   :weight bold
                                   ;; :foreground "#ff0095"
                                   )
           ;; Give docs a different look
           (font-lock-doc-face :slant italic
                               :weight bold
                               )
           ))
        )

  (setq system-uses-terminfo nil)
  (setq-default spacemacs-show-trailing-whitespace nil)
  (setq mac-right-option-modifier 'nil)
  (setq scroll-margin 8)
  (setq vc-follow-symlinks t)

  (setq warning-minimum-level :error) ;; Only show errors in messages buffer, not warnings. Native comp introduces tons of these

  ;; (setq doom-modeline-buffer-encoding nil)
  ;; (setq doom-modeline-percent-position nil)
  ;; (setq doom-modeline-buffer-state-icon t)

  (define-key key-translation-map (kbd "M-9") (kbd "`"))
  (define-key key-translation-map (kbd "M-2") (kbd "~"))

  ;; Nog niet zeker, uitproberen
  (setq company-idle-delay 0.2)

  ;; (require 'company)
  ;; (add-to-list 'company-backends 'company-edbi)
  (evil-escape-mode -1)
  (direnv-mode)
  ;; (eshell-vterm-mode)

  ;; magit: escape and q to abort / exit popup
  (require 'transient)
  (define-key transient-map        "q" 'transient-quit-one)
  (define-key transient-edit-map   "q" 'transient-quit-one)
  (define-key transient-sticky-map "q" 'transient-quit-seq)
  (define-key transient-map        (kbd "<escape>") 'transient-quit-one)
  (define-key transient-edit-map   (kbd "<escape>") 'transient-quit-one)
  (define-key transient-sticky-map (kbd "<escape>") 'transient-quit-seq)
  (define-key evil-motion-state-map (kbd "C-z") nil) ;; Disable, is by default switch to / from emacs keybinds

  (spacemacs/set-leader-keys "o" 'evil-jump-backward)

  (spacemacs/declare-prefix-for-mode 'typescript-mode "mt" "test")
  (spacemacs/declare-prefix-for-mode 'typescript-tsx-mode "mt" "test")
  (spacemacs/set-leader-keys-for-major-mode 'typescript-tsx-mode "tt" 'typescript-expect-test-normal)
  (spacemacs/set-leader-keys-for-major-mode 'typescript-mode "tt" 'typescript-expect-test-normal)
  (spacemacs/set-leader-keys-for-major-mode 'typescript-tsx-mode "td" 'typescript-expect-test-debug)
  (spacemacs/set-leader-keys-for-major-mode 'typescript-mode "td" 'typescript-expect-test-debug)
  (spacemacs/set-leader-keys-for-major-mode 'typescript-tsx-mode "rt" 'tide-refactor)
  (spacemacs/set-leader-keys-for-major-mode 'typescript-mode "rt" 'tide-refactor)

  (global-set-key (kbd "C-l") 'evil-window-right)
  (global-set-key (kbd "C-h") 'evil-window-left)
  (global-set-key (kbd "C-j") 'evil-window-down)
  (global-set-key (kbd "C-k") 'evil-window-up)
  ;; (global-set-key [f10] '(lambda () (interactive) (profiler-start 'cpu)))
  ;; (global-set-key [f11] 'profiler-report)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)


  (require 'tide)
  (setq tide-completion-enable-autoimport-suggestions t)
  (setq tide-completion-ignore-case t)
  (setq tide-always-show-documentation t)

  ;; formatting - prettier mostly
  ;; TODO - This should be only in ts/tsx/js/... imo - now it's in every mode
  (apheleia-global-mode +1)


  ;; (setq avy-orders-alist
  ;;       '((avy-goto-char . avy-order-closest)
  ;;         (avy-goto-word-0 . avy-order-closest)))
  ;; (setq avy-keys (number-sequence ?a ?z))
  ;; (spacemacs/set-leader-keys "j" 'avy-goto-char)

  (setq avy-orders-alist
        '((avy-goto-char . avy-order-closest)
          (avy-goto-word-1 . avy-order-closest)
          (avy-goto-char-timer . avy-order-closest)
          ))
  (setq avy-keys (number-sequence ?a ?z))
  (spacemacs/set-leader-keys "j" 'avy-goto-word-1) ;; experimentje, overwrite veel bindings van spacemacs zelf

  (add-hook 'urweb-mode-hook 'lsp-mode)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'urweb-mode-hook 'flycheck-mode)
  (setq flycheck-check-syntax-automatically '(save))
  (defun two-screens-work ()
    (interactive)
    (shell-command "xrandr --output eDP-1 --scale 1x1 --mode 2560x1440 --pos 3840x0; xrandr --output HDMI-1 --scale 1.5x1.5 --mode 1920x1080 --pos 0x0"))

  (defun eshell-new()
    "Open a new instance of eshell."
    (interactive)
    (eshell 'N))

  (defun vterm-new()
    "Open a new instance of vterm."
    (interactive)
    (vterm (random 100000)))

  (defun mk-compile-command-with-notifs (comp)
    (if (string-equal system-type "darwin")
        ;; Anybar
        (s-concat "echo -n white | nc -4u -w1 localhost 1738;\n"
                  "if " comp "; then\n"
                  "  echo -n green | nc -4u -w1 localhost 1738\n"
                  "else \n"
                  "  echo -n red | nc -4u -w1 localhost 1738; exit 1\n"
                  "fi")
      ;; notify-send
      (s-concat "if " comp "; then\n"
                "  notify-send 'Compile OK' -i ~/dotfiles/checked.png -h string:sound-name:dialog-error\n"
                "else \n"
                "  notify-send 'Compile fail' -i ~/dotfiles/cancel.png -h string:sound-name:dialog-error; exit 1\n"
                "fi")))

  ;; (setq open-edbi-connections '())

  ;; (defun edbi:open-db-viewer-with-info (uri &optional user auth)
  ;;   "Open Database viewer buffer with data source info."
  ;;   (if ;; if the conn is already open -> reuse
  ;;       (assoc uri open-edbi-connections)
  ;;       (edbi:dbview-open (cdr (assoc uri open-edbi-connections)))
  ;;     ;; else make a new conn and save
  ;;     (message "yp")
  ;;     (let ((data-source (edbi:data-source uri user auth))
  ;;           (conn (edbi:start)))
  ;;       (edbi:connect conn data-source)
  ;;       ;; TODO: remove from open-edbi-connections if connection fails
  ;;       (map-put open-edbi-connections uri conn)
  ;;       (edbi:dbview-open conn))))

  ;; usage: (edbi:open-db-viewer-with-info "dbi:Pg:dbname=xxxx" "username" "password")
  ;; (defun school:connect-local ()
  ;;   (interactive)
  ;;   (edbi:open-db-viewer-with-info "dbi:Pg:dbname=urwebschool"))

  ;; TODO: open SSH port forwarding if not already present
  ;; ssh -L9999:localhost:5432 root@172.104.129.155
  ;; (defun school:connect-remote ()
  ;;   "Connect to De Rockschool DB via SSH post forwarded to 9999"
  ;;   (interactive)
  ;;   (edbi:open-db-viewer-with-info (concat "dbi:Pg:dbname=derockschool;host=localhost;port=9999") "nixcloud" "nixcloud"))

  (require 'em-term)
  (add-to-list 'eshell-visual-commands "psql")

  (require 'em-alias)
  (defalias 'uw (mk-compile-command-with-notifs "make build && restart-urweb"))


  ;; use sql-connect to connect to one of these
  (setq sql-postgres-login-params nil) 
  (setq sql-connection-alist
        '((aperi (sql-product 'postgres)
                 (sql-database (concat "postgresql://"
                                       "aperi"  ;; replace with your username
                                       ":"
                                       "aperi"
                                       ;; (read-passwd "Enter password: ")
                                       "@localhost"      ;; replace with your host
                                       ":5432"      ;; replace with your port
                                       "/aperi"  ;; replace with your database
                                       )))
          ("urwebschool"
           (sql-product 'postgres)
           (sql-database "urwebschool")
           (sql-user "simon")
           (sql-server "localhost")
           (sql-port 5432)
           )
          ("sqltypertest"
           (sql-product 'postgres)
           (sql-database "sqltypertest"))
          (* First run make tunnel_pg *)
          ("popcollege"
           (sql-product 'postgres)
           (sql-user "nixcloud")
           (sql-database "popcollege")
           (sql-server "localhost")
           (sql-password "nixcloud")
           (sql-port 3000)
           ) (* TODO automate SSH port forwarding *)
          ;; (secondary-db (sql-product 'postgres)
          ;;               (sql-database (concat "postgresql://"
          ;;                                     "username:"
          ;;                                     (read-passwd "Enter password: ")
          ;;                                     "@host"
          ;;                                     ":port"
          ;;                                     "/database")))
          ))


  ;; https://github.com/purcell/exec-path-from-shell
  ;; LD_LIBRARY_PATH needed for shared library liburweb_http.so, mac only I think
  ;; (when (memq window-system '(mac ns x))
  ;;   (exec-path-from-shell-initialize))
  ;; (exec-path-from-shell-copy-env "LD_LIBRARY_PATH")

  (require 'lsp-mode)
  (add-to-list 'lsp-language-id-configuration '(urweb-mode . "urweb"))
  ;; (setq lsp-print-io t)
  ;; (setq lsp-trace t)
  (setq lsp-report-if-no-buffer t)
  (setq lsp-auto-configure t)
  (customize-set-variable 'lsp-ui-sideline-enable t)
  (customize-set-variable 'lsp-ui-sideline-show-diagnostics t)
  (customize-set-variable 'lsp-ui-sideline-show-hover nil)
  (customize-set-variable 'lsp-ui-doc-alignment (quote window))
  (customize-set-variable 'lsp-ui-doc-include-signature t)
  (customize-set-variable 'lsp-ui-doc-position (quote at-point))

  ;; (setq lsp-disabled-clients '(eslint))
  ;; eslint is annoying, always wants to loads 1000's of files that are irrelevant to me. If you want to use it, get it configured properly first

  ;; Default left-to-right, perf
  (setq bidi-paragraph-direction 'left-to-right)
  (if (version<= "27.1" emacs-version)
      (setq bidi-inhibit-bpa t))

  ;; Global so-long mode: if files have possible perf issues -> switch to basic so-long mode for perf
  (if (version<= "27.1" emacs-version)
      (global-so-long-mode 1))

  ; Always show tooltip, even if there is only one match
  ; Otherwise if there is only one match a "preview" is shown and you don't see eg type info
  (setq company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))
                          
  ;; (setq lsp-print-performance t)

  ; Register urweb language server
  (defcustom lsp-urweb-language-server-urpfile "school" "Urp file to choose if multiple")
  (lsp-register-custom-settings '(("urweb.project.urpfile" lsp-urweb-language-server-urpfile)))
  (defgroup lsp-urweb nil
    "LSP support for Ur/Web."
    :group 'lsp-mode
    :link '(url-link "https://www.impredicative.com/ur"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("/home/simon/urweb/result/bin/urweb" "-startLspServer"))
                    :major-modes '(urweb-mode)
                    :server-id 'urweb-lsp
                    :initialization-options (lsp-configuration-section "urweb")))

  ;; https://stackoverflow.com/questions/6411121/how-to-make-emacs-use-my-bashrc-file

  ;; rust
  (setq rust-format-on-save t)

  ;; FSHARP
  ;; (setq doom-modeline-major-mode-icon nil) ;; Issue with icon bomps perf of fsharp

  ;; https://github.com/haskell/haskell-ide-engine/issues/881#issuecomment-508967691
  ;; (add-hook 'haskell-mode-hook (lambda ()  (setq tab-width 2)))
  ;; (lsp-haskell-set-formatter "brittany")
  ;; (lsp-haskell--set-configuration)
  ;; (setq tab-width 2)
  ;; (lsp-register-custom-settings '(("ormolu" lsp-haskell-formatting-provider)))

  ;; CSHARP
  (setq omnisharp-server-executable-path "/nix/store/wyz33mr8njm7cafnk9nccsy6i64jcgc0-omnisharp-roslyn-1.37.8/bin/omnisharp")
  (setq lsp-csharp-server-path "/nix/store/wyz33mr8njm7cafnk9nccsy6i64jcgc0-omnisharp-roslyn-1.37.8/bin/omnisharp")


  (require 'helm-bookmark) ;; TODO remove when spacemacs gets updated

  (defun pgformatter-format-buffer ()
    "Format sql files with pgformatter if present"
    (interactive)
    (when
        (and (eq major-mode 'sql-mode)
             (executable-find "pg_format"))
      (let ((buffer-with-sql (current-buffer)))
        (with-temp-buffer
          (let ((temp-buffer-orig-with-replacements (current-buffer)))
            (with-temp-buffer
              (let ((temp-buffer-result (current-buffer))
                    (matches '())
                    (i 1))
                (with-current-buffer buffer-with-sql
                  (progn
                    (copy-to-buffer temp-buffer-orig-with-replacements (point-min) (point-max))
                    (with-current-buffer temp-buffer-orig-with-replacements
                      ;; Replace :variable with $11111
                      ;; :variable is not valid syntax. So we replace it with the valid placholder syntax $1
                      ;; Max int value = 65000 so we use 11111 to approximate length of :variable string
                      ;; We also save the matches to reverse the replacement
                      (while (re-search-forward "[^:]\\(:[_A-Za-z0-9]+\\)"nil t)
                        (add-to-ordered-list 'matches (match-string 1) i)
                        (replace-match "$11111" nil nil nil 1)
                        (set 'i (+ i 1))
                        )
                      (let
                          ;; Run sqlfmt into temp-buffer-result
                          ((retcode (shell-command-on-region
                                     (point-min)
                                     (point-max)
                                     "pg_format"
                                     temp-buffer-result
                                     nil
                                     "**sqlfmt-error**"
                                     nil
                                     )))
                        (when
                            (= retcode 0)
                          (with-current-buffer temp-buffer-result
                            (progn
                              ;; Reverse :var -> $11111
                              (set 'i 0)
                              (goto-char (point-min))
                              (while (re-search-forward "\\$\\w+" nil t)
                                (replace-match (nth i matches))
                                (set 'i (+ i 1)))
                              (with-current-buffer buffer-with-sql
                                ;; Write buffer
                                (replace-buffer-contents temp-buffer-result ))
                              )
                            )
                          ))))))))))))

  ;; (add-hook 'sql-mode-hook
  ;;           (lambda () (add-hook 'before-save-hook 'pgformatter-format-buffer)))

  ;; OCAML
  ;; (setq merlin-command "ocamlmerlin")

  ;; UR-WEB
  (setq urweb-indent-level 2)
  (load "~/urweb/src/elisp/urweb-mode-startup")
  (defun init-urweb-proj ()
    (smartparens-mode)
    (require 'company)
    (spacemacs/toggle-auto-completion-on)
    )
  (add-hook 'urweb-mode-hook 'init-urweb-proj)

  (defun urweb-get-projectname (dir)
    (let* ((filesInDir (directory-files dir))
           (urpFiles (seq-filter (lambda (file) (s-suffix? ".urp" file)) filesInDir))
           (biggestFile
            (if (car filesInDir)
                (seq-reduce
                 (lambda
                   (acc file)
                   (if (>
                        (file-attribute-size (file-attributes file))
                        (file-attribute-size (file-attributes acc)))
                       file acc))
                 urpFiles
                 (car urpFiles))
              ""))
           )
      (s-replace ".urp" "" biggestFile)))

  (defun urweb-get-proj-dir (bfn)
    (locate-dominating-file
     bfn
     (lambda (dir)
       (some (lambda (f) (s-suffix? ".urp" f))
             (if (f-dir? dir)
                 (directory-files dir)
               (list '(dir)))))))

  ;; Smart compile: https://ambrevar.xyz/emacs/index.html
  ;; (make-variable-buffer-local 'compile-command)

  (defun urweb-set-compiler ()
    (let* ((proj-dir (urweb-get-proj-dir (buffer-file-name))))
      (if proj-dir (setq default-directory proj-dir))
      (if proj-dir (setq compile-command
                         (mk-compile-command-with-notifs
                          (format "urweb -tc %s" (urweb-get-projectname proj-dir)))))))
  (add-hook 'urweb-mode-hook 'urweb-set-compiler)

  (defun sml-set-compiler ()
    (let* ((proj-dir (locate-dominating-file "." "Makefile")))
      (if proj-dir (setq default-directory proj-dir))
      (if proj-dir (setq compile-command (mk-compile-command-with-notifs "make")))))
  (add-hook 'sml-mode-hook 'sml-set-compiler)

  ;; dap

  ;; Setup for node debugger:

  ;; (defun init-dap-node ()
  ;;   (let* ()
  ;;     (require 'dap-node)
  ;;     (dap-node-setup)
  ;;     (setq dap-debug-restart-keep-session nil)
  ;;     ))
  ;; (add-hook 'typescript-tsx-mode-hook 'init-dap-node)
  ;; (add-hook 'typescript-mode-hook 'init-dap-node)
  (defun typescript-expect-test-normal ()
    (interactive)
    (typescript-expect-test nil))
  (defun typescript-expect-test-debug ()
    (interactive)
    (typescript-expect-test 1))

  (defun typescript-expect-test (inspect)
    (interactive)
    (let* ((current-buff (window-buffer (minibuffer-selected-window)))
           (filename (buffer-file-name current-buff))
           (filename-corrected (concat filename ".corrected")))
      (with-temp-buffer
        (let ((output-buffer (current-buffer)))
          (shell-command
           (format "npx expect_test %s %s" filename (if inspect "--inspect" ""))
           output-buffer)
          (if
              ;; some output was written -> corrected file was made
              (/= (buffer-size output-buffer) 0)
              (let* ((existing-buffer (find-buffer-visiting filename-corrected)))
                ;; if we don't do this, every second test run we get a confirmation dialog saying "file has changed on disk, reload y/n...."
                (if existing-buffer
                    (progn
                      (with-current-buffer existing-buffer
                        (revert-buffer :ignore-auto :noconfirm))
                      (ediff-buffers
                       current-buff
                       existing-buffer
                       )
                      )
                  (ediff
                   filename
                   filename-corrected
                   )
                  )
                (delete-file filename-corrected)
                )
            (message "All expect tests passed")
            )
          )
        )
      )
    )

  ;; sassc
  (require 'flycheck)
  (setq flycheck-javascript-eslint-executable "eslint_d")

  (flycheck-define-checker sassc
    "A Sass syntax checker using the SassC compiler.
See URL `https://sass-lang.com/libsass'."
    :command ("sassc"
              "--line-numbers"
              "--stdin")
    :standard-input t
    :error-patterns
    ((error line-start
            (or "Syntax error: " "Error: ")
            (message (one-or-more not-newline)
                     (zero-or-more "\n"
                                   (one-or-more " ")
                                   (one-or-more not-newline)))
            (optional "\r") "\n" (one-or-more " ") "on line " line ":" column
            " of stdin"
            line-end))
    :modes scss-mode)

  (defun flycheck-sassc-setup ()
    "Set up the flycheck-sassc checker."
    (interactive)
    (add-to-list 'flycheck-checkers 'sassc))
  (flycheck-sassc-setup)
  (provide 'flycheck-sassc)
  (add-hook 'scss-mode-hook 'flycheck-sassc-setup)

  (setq flycheck-display-errors-delay 0)

  ;; sassc
;;   (require 'flycheck)

;;   (flycheck-define-checker sassc
;;     "A Sass syntax checker using the SassC compiler.
;; See URL `https://sass-lang.com/libsass'."
;;     :command ("sassc"
;;               "--line-numbers"
;;               "--stdin")
;;     :standard-input t
;;     :error-patterns
;;     ((error line-start
;;             (or "Syntax error: " "Error: ")
;;             (message (one-or-more not-newline)
;;                      (zero-or-more "\n"
;;                                    (one-or-more " ")
;;                                    (one-or-more not-newline)))
;;             (optional "\r") "\n" (one-or-more " ") "on line " line ":" column
;;             " of stdin"
;;             line-end))
;;     :modes scss-mode)

;;   (defun flycheck-sassc-setup ()
;;     "Set up the flycheck-sassc checker."
;;     (interactive)
;;     (add-to-list 'flycheck-checkers 'sassc))
;;   (flycheck-sassc-setup)
;;   (provide 'flycheck-sassc)
;;   (add-hook 'scss-mode-hook 'flycheck-sassc-setup)

  ;; (defun setup-school-local-shells ()
  ;;   (interactive)
  ;;   (persp-switch "School local shells")
  ;;   (winum-select-window-1)
  ;;   (split-window-right)
  ;;   (split-window-below)
  ;;   (split-window-right)
  ;;   (winum-select-window-3)
  ;;   (split-window-right)
  ;;   (rename-buffer "General" 1)
  ;;   (rename-buffer "Tunnel" 1)
  ;;   (rename-buffer "Haskell maildaemon" 1)
  ;;   (rename-buffer "Vterm" 1)
  ;;   (let* ()
  ;;     (winum-select-window-1)
  ;;     (cd "~/ur-proj/school")
  ;;     (vterm "General")
  ;;     (vterm-send-string "clear")
  ;;     (vterm-send-return)
  ;;     )
  ;;   (let* ()
  ;;     (winum-select-window-2)
  ;;     (cd "~/ur-proj/school")
  ;;     (vterm "Tunnel")
  ;;     (vterm-send-string "clear")
  ;;     (vterm-send-return)
  ;;     (vterm-send-string "make tunnel")
  ;;     )
  ;;   (let* ()
  ;;     (winum-select-window-3)
  ;;     (cd "~/ur-proj/school")
  ;;     (vterm "Urweb school")
  ;;     (vterm-send-string "clear")
  ;;     (vterm-send-return)
  ;;     (vterm-send-string "sudo make start")
  ;;     )
  ;;   (let* ()
  ;;     (winum-select-window-4)
  ;;     (cd "~/ur-proj/school")
  ;;     (vterm "Haskell maildaemon")
  ;;     (vterm-send-string "clear")
  ;;     (vterm-send-return)
  ;;     (vterm-send-string "make email_daemon")
  ;;     )
  ;;   (let* ()
  ;;     (winum-select-window-5)
  ;;     (cd "~/ur-proj/school")
  ;;     (vterm "SQL")
  ;;     (vterm-send-string "clear")
  ;;     (vterm-send-return)
  ;;     (vterm-send-string "psql urwebschool")
  ;;     )
  ;;   )

  ;; (defun restart-urweb ()
  ;;     (interactive)
  ;;     (with-current-buffer "Urweb school"
  ;;       (vterm-send-string " ")
  ;;       (vterm-send-return)))


  ;; Dummy var
  ;; (flycheck-def-config-file-var
  ;;     flycheck-urweb-urp urweb-checker ".urp" :safe #'stringp)
  ;; (defun find-urp ()
  ;;   (car
  ;;    (f-entries
  ;;     (or
  ;;      (flycheck--locate-dominating-file-matching default-directory ".*urp")
  ;;      default-directory)
  ;;     (lambda (file) (s-matches? ".urp" file)))))
  ;; (defun find-urweb-config-file (fn_ checker)
  ;;   (if (equal checker 'urweb-checker)
  ;;       (find-urp)
  ;;       nil))
  ;; (add-to-list 'flycheck-locate-config-file-functions 'find-urweb-config-file)
  ;; (require 'flycheck)
  ;; (defun secondArgMinusExt (opt file) (f-no-ext (f-filename file)))
  ;; (defun find-urp-dirname (checker) (f-dirname (find-urp)))
  ;; (flycheck-define-checker
  ;;     urweb-checker
  ;;   "Trying to get flycheck to work with urweb"
  ;;   :command ("urweb" "-tc" (config-file "" flycheck-urweb-urp secondArgMinusExt))
  ;;   :error-patterns
  ;;   ((error line-start (file-name) ":" line ":" column ":"
  ;;           (message (one-or-more not-newline)
  ;;                    (zero-or-more (seq "\n" (optional (seq (not-char "/") (zero-or-more not-newline)))))))) ;; Matching lines that DON'T start with "/"
  ;;   :modes urweb-mode
  ;;   :working-directory find-urp-dirname)
  ;; (spacemacs/add-flycheck-hook 'urweb-mode)
  ;; (add-to-list 'flycheck-checkers 'urweb-checker)


  ;; OCaml / Reason stuff
  ;; (setq opam (substring (shell-command-to-string "opam config var prefix 2> /dev/null") 0 -1))
  ;; (add-to-list 'load-path (concat opam "/share/emacs/site-lisp"))
  ;; (setq refmt-command (concat opam "/bin/refmt"))

  ;; (require 'reason-mode)
  ;; (require 'merlin)
  ;; (setq merlin-ac-setup t)
  ;; (add-hook 'reason-mode-hook (lambda ()
  ;;                               (add-hook 'before-save-hook 'refmt-before-save)
  ;;                               (merlin-mode)))

  ;; ;; Purescript-mode keybinds
  ;; (defun psc-ide-wrap-with-type-hole (start end)
  ;;   (interactive "r")
  ;;   (if (equal start end)
  ;;       (let ((ident-span (psc-ide-ident-pos-at-point)))
  ;;         (psc-ide-wrap-with-type-hole-impl (car ident-span) (cdr ident-span)))
  ;;     (psc-ide-wrap-with-type-hole-impl start end))
  ;;   )
  ;; (defun psc-ide-wrap-with-type-hole-impl (start end)
  ;;   (let ((ident (buffer-substring-no-properties start end)))
  ;;     (delete-region start end)
  ;;     (insert (format "((const :: forall a. a -> a -> a) (%s) ?hole)" ident))))
  ;; (spacemacs/set-leader-keys-for-major-mode 'purescript-mode
  ;;   "i" 'psc-ide-add-import
  ;;   "s" 'psc-ide-flycheck-insert-suggestion
  ;;   ;; "r" 'psc-ide-load-file-environment-into-psci
  ;;   "w" 'psc-ide-wrap-with-type-hole
  ;;   )
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "d0c943c37d6f5450c6823103544e06783204342430a36ac20f6beb5c2a48abe3" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a" "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   '(undo-tree spinner parent-mode pkg-info epl flx company-edbi s edbi epc ctable concurrent deferred bind-map bind-key popup direnv ghc haskell-mode caml skewer-mode json-snatcher json-reformat gitignore-mode web-completion-data dash-functional auto-complete company-tabnine unicode-escape names powerline multiple-cursors haml-mode tern anzu highlight f goto-chg magit-popup simple-httpd markdown-mode pos-tip anybar doom-themes company-postgresql typescript-mode org-plus-contrib hydra lv projectile avy company iedit smartparens evil flycheck yasnippet request helm helm-core magit transient git-commit with-editor async js2-mode dash xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help csv-mode ob-sml sml-mode graphviz-dot-mode ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen utop use-package tuareg toc-org tide tagedit sql-indent spaceline smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters pug-mode psci psc-ide popwin persp-mode pcre2el paradox orgit org-bullets open-junk-file ocp-indent nix-mode neotree move-text mmm-mode merlin markdown-toc magit-gitflow lorem-ipsum livid-mode linum-relative link-hint json-mode js2-refactor js-doc intero indent-guide hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flycheck-pos-tip flycheck-haskell flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode dumb-jump diminish define-word company-web company-tern company-statistics company-ghci company-ghc company-cabal column-enforce-mode coffee-mode cmm-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol aggressive-indent add-node-modules-path adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))
 '(paradox-github-token t)
 '(psc-ide-add-import-on-completion t t)
 '(psc-ide-rebuild-on-save nil t)
 )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "d0c943c37d6f5450c6823103544e06783204342430a36ac20f6beb5c2a48abe3" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a" "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   '(helm-gtags ggtags flycheck-ocaml dune counsel-gtags counsel swiper ivy direnv ghc haskell-mode caml skewer-mode json-snatcher json-reformat gitignore-mode web-completion-data dash-functional auto-complete company-tabnine unicode-escape names powerline multiple-cursors haml-mode tern anzu highlight f goto-chg magit-popup simple-httpd markdown-mode pos-tip anybar doom-themes company-postgresql typescript-mode org-plus-contrib hydra lv projectile avy company iedit smartparens evil flycheck yasnippet request helm helm-core magit transient git-commit with-editor async js2-mode dash xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help csv-mode ob-sml sml-mode graphviz-dot-mode ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen utop use-package tuareg toc-org tide tagedit sql-indent spaceline smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters pug-mode psci psc-ide popwin persp-mode pcre2el paradox orgit org-bullets open-junk-file ocp-indent nix-mode neotree move-text mmm-mode merlin markdown-toc magit-gitflow lorem-ipsum livid-mode linum-relative link-hint json-mode js2-refactor js-doc intero indent-guide hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flycheck-pos-tip flycheck-haskell flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode dumb-jump diminish define-word company-web company-tern company-statistics company-ghci company-ghc company-cabal column-enforce-mode coffee-mode cmm-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol aggressive-indent add-node-modules-path adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))
 '(paradox-github-token t)
 '(psc-ide-add-import-on-completion t t)
 '(psc-ide-rebuild-on-save nil t)
 '(safe-local-variable-values
   '((lsp-enabled-clients ts-ls)
     (lsp-java-vmargs "-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication" "-javaagent:/home/simon/.m2/repository/org/projectlombok/lombok/1.18.10/lombok-1.18.10.jar" "-Xbootclasspath/a:/home/simon/.m2/repository/org/projectlombok/lombok/1.18.10/lombok-1.18.10.jar")
     (typescript-backend . tide)
     (typescript-backend . lsp)
     (javascript-backend . tide)
     (javascript-backend . tern)
     (javascript-backend . lsp)))
 '(sql-connection-alist
   '(("urwebschool"
      (sql-product 'postgres)
      (sql-database "urwebschool"))
     ("sqltypertest"
      (sql-product 'postgres)
      (sql-database "sqltypertest"))
     ("hamaril"
      (sql-product 'postgres)
      (sql-user "nixcloud")
      (sql-database "hamaril")
      (sql-server ""))
     ("aperi"
      (sql-product 'postgres)
      (sql-user "aperi")
      (sql-database "aperi")
      (sql-server "localhost"))
     ("derockschool-prod"
      (sql-product 'postgres)
      (sql-user "nixcloud")
      (sql-database "derockschool")
      (sql-server ""))) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t))
)

