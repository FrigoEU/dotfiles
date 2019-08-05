;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
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
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     csv
     sml
     ;; graphviz
     ;; ruby
     ;; purescript
     ;; ruby
     ;; sml
     ;; ocaml
     ;; ruby
     ;; vimscript
     markdown
     sql
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     auto-completion
     ;; better-defaults
     ;; csharp
     ;; emacs-lisp
     javascript
     typescript
     html
     ;; haskell
     ;; purescript
     git
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
     ;; themes-megapack
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '((nix-mode)
                                      (add-node-modules-path)
                                      (anybar)
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))



(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
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
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
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
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup 1
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
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
  (setq css-indent-offset 2)
  (setq json-indent-offset 2)

  (setq system-uses-terminfo nil)
  (setq-default spacemacs-show-trailing-whitespace nil)
  (setq mac-right-option-modifier 'nil)
  (setq scroll-margin 8)
  (setq vc-follow-symlinks t)
  
  ;; TYPESCRIPT/TSX
  ;; (setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")
  ;; (add-hook 'find-file-hook 'tsx-stuff)
  (defun my/use-tslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (tslint (and root
                        (expand-file-name "node_modules/tslint/bin/tslint"
                                          root))))
      (when (and tslint (file-executable-p tslint))
        (setq-local flycheck-typescript-tslint-executable tslint))))
  
  (add-hook 'flycheck-mode-hook #'my/use-tslint-from-node-modules)
  ;; (defun tsx-stuff ()
  ;;   ;; we want to start this only when opening tsx, not just web-mode
  ;;   (when (string= (file-name-extension buffer-file-name) "tsx")
  ;;     (emmet-mode)
  ;;     (setq-local emmet-expand-jsx-className? t)
  ;;     (smartparens-mode)
  ;;     (spacemacs/toggle-auto-completion-on)
  ;;     (add-to-list 'company-backends 'company-tide)
  ;;     (my/use-tslint-from-node-modules)
  ;;     ))
  ;; (flycheck-add-mode 'typescript-tslint 'web-mode)
  ;; (add-hook 'typescript-mode-hook 'my/use-tslint-from-node-modules)
  ;; (add-hook 'web-mode-hook 'prettier-js-mode)



  ;; HASKELL
  ;; (setq-default dotspacemacs-configuration-layers
  ;;               '(auto-completion
  ;;                 (haskell :variables haskell-completion-backend 'intero)))

  ;; CSHARP
  ;; (setq omnisharp-server-executable-path "/usr/local/bin/omnisharp")

  (require 'helm-bookmark) ;; TODO remove when spacemacs gets updated

  ;; UR-WEB
  (load "~/.emacs.d/elpa/ur/urweb-mode-startup")
  (setq urweb-indent-level 2)
  (add-hook 'urweb-mode-hook 'smartparens-mode)

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
      (s-replace ".urp" "" biggestFile)
      )
    )

  (defun urweb-get-proj-dir (bfn)
    (locate-dominating-file
     bfn
     (lambda (dir)
       (some (lambda (f) (s-suffix? ".urp" f))
             (if (f-dir? dir)
                 (directory-files dir)
               (list '(dir)))))))

  (defun urweb-get-info ()
    (interactive)
    (let*
        ((row (line-number-at-pos))
         (col (evil-column))
         (bfn (buffer-file-name))
         (proj-dir (urweb-get-proj-dir bfn))
         (filename (file-relative-name bfn proj-dir))
         (loc (concat filename ":" (number-to-string row) ":" (number-to-string col)))
         )
      (require 's)
      (require 'f)
      (require 'simple)
      (message (let
                   ((default-directory proj-dir))
                 (shell-command-to-string (concat "urweb -getInfo " loc))))))

  (spacemacs/set-leader-keys-for-major-mode 'urweb-mode
    "i" 'urweb-get-info)

  ;; Smart compile: https://ambrevar.xyz/emacs/index.html
  (make-variable-buffer-local 'compile-command)

  (defun urweb-set-compiler ()
    (let* ((proj-dir (urweb-get-proj-dir (buffer-file-name))))
      (setq default-directory proj-dir)
      (setq compile-command
            (format (s-concat "echo -n white | nc -4u -w0 localhost 1738;\n"
                              "if urweb -tc %s; then\n"
                              "  echo -n green | nc -4u -w0 localhost 1738\n"
                              "else \n"
                              "  echo -n red | nc -4u -w0 localhost 1738; exit 1\n"
                              "fi")
                    (urweb-get-projectname proj-dir)))
      ))
  (add-hook 'urweb-mode-hook 'urweb-set-compiler)

  (defun sml-set-compiler ()
    (let* ((proj-dir (locate-dominating-file "." "Makefile")))
      (setq default-directory proj-dir)
      (setq compile-command
            (s-concat "echo -n white | nc -4u -w0 localhost 1738;\n"
                      "if make; then\n"
                      "  echo -n green | nc -4u -w0 localhost 1738\n"
                      "else \n"
                      "  echo -n red | nc -4u -w0 localhost 1738; exit 1\n"
                      "fi"
                      ))
      ))
  (add-hook 'sml-mode-hook 'sml-set-compiler)

  (global-set-key (kbd "C-l") 'evil-window-right)
  (global-set-key (kbd "C-h") 'evil-window-left)
  (global-set-key (kbd "C-j") 'evil-window-down)
  (global-set-key (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)


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
   (quote
    ("93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "d0c943c37d6f5450c6823103544e06783204342430a36ac20f6beb5c2a48abe3" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a" "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (anybar doom-themes company-postgresql typescript-mode org-plus-contrib hydra lv projectile avy company iedit smartparens evil flycheck yasnippet request helm helm-core magit transient git-commit with-editor async js2-mode dash xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help csv-mode ob-sml sml-mode graphviz-dot-mode ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen utop use-package tuareg toc-org tide tagedit sql-indent spaceline smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters pug-mode psci psc-ide popwin persp-mode pcre2el paradox orgit org-bullets open-junk-file ocp-indent nix-mode neotree move-text mmm-mode merlin markdown-toc magit-gitflow lorem-ipsum livid-mode linum-relative link-hint json-mode js2-refactor js-doc intero indent-guide hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flycheck-pos-tip flycheck-haskell flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode dumb-jump diminish define-word company-web company-tern company-statistics company-ghci company-ghc company-cabal column-enforce-mode coffee-mode cmm-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol aggressive-indent add-node-modules-path adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(psc-ide-add-import-on-completion t t)
 '(psc-ide-rebuild-on-save nil t)
 '(sql-connection-alist
   (quote
    (("urwebschool"
      (sql-product
       (quote postgres))
      (sql-user "Simon")
      (sql-database "urwebschool")
      (sql-server ""))
     ("hamaril"
      (sql-product
       (quote postgres))
      (sql-user "nixcloud")
      (sql-database "hamaril")
      (sql-server ""))
     ("derockschool-prod"
      (sql-product
       (quote postgres))
      (sql-user "nixcloud")
      (sql-database "derockschool")
      (sql-server ""))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
