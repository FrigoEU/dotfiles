;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Victor Mono" :size 20))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
(setq doom-localleader-key ",")

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(map! :n "<left>" #'evil-window-left)
(map! :n "<right>" #'evil-window-right)
(map! :n "<up>" #'evil-window-up)
(map! :n "<down>" #'evil-window-down)

(map! :leader :prefix "w" :n "S-<left>" #'+evil/window-move-left)
(map! :leader :prefix "w" :n "S-<right>" #'+evil/window-move-right)
(map! :leader :prefix "w" :n "S-<up>" #'+evil/window-move-up)
(map! :leader :prefix "w" :n "S-<down>" #'+evil/window-move-down)

(map! :v "s" #'evil-embrace-evil-surround-region)

(map! :leader :n "l" #'show-workspace-switcher)

(map! :leader :prefix "g" :n "s" #'magit-status)
(map! :leader :prefix "g" :n "t" #'git-timemachine)

(map! :leader :prefix "r" :n "y" #'consult-yank-from-kill-ring)
(map! :leader :prefix "r" :n "l" #'vertico-repeat-last)

(setq scroll-margin 12)

(after! vertico-posframe
  ;; copied the number from default, but hardcoded it so it doesn't shift
  (setq vertico-posframe-width (round (* (frame-width) 0.62)))
  (setq vertico-posframe-border-width 8)
  (setq vertico-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8))))

(map! :leader :prefix "e" :n "n" #'flycheck-next-error)
(map! :leader :prefix "e" :n "p" #'flycheck-previous-error)
(map! :leader :prefix "e" :n "l" #'flycheck-list-errors)

(map! :leader :prefix "c" :n "C" #'compile)
(map! :leader :prefix "c" :n "r" #'recompile)

(map! :n "r" #'evil-enter-replace-state)

(map! :n "C-w" #'workspace-switcher)

(after! tide
  (map! :map tide-mode-map :prefix "g" :n "d" #'tide-jump-to-definition)
  (map! :map tide-mode-map :prefix "g" :n "D" #'tide-references)

  (map! :map tide-mode-map :localleader :n "h" #'tide-documentation-at-point)
  (map! :map tide-mode-map :localleader :n "a" #'tide-fix)
  (map! :map tide-mode-map :localleader :nv "t" #'tide-refactor)
  (map! :map tide-mode-map :localleader :prefix ["r" "r"] :n "s" nil)
  (map! :map tide-mode-map :localleader :prefix "r" :n "r" #'tide-rename-symbol)
  (map! :map tide-mode-map :localleader :prefix "r" :n "f" #'tide-rename-file)
  (map! :map tide-mode-map :localleader :n "o" #'tide-organize-imports)
  (map! :map tide-mode-map :localleader :prefix "S" :n "r" #'tide-restart-server)
  )


(after! eshell
  (after! em-shell
    (add-to-list eshell-visual-commands "psql")
    (add-to-list eshell-visual-commands "ssh")
    )
  )

(defun pcomplete/npm ()
  "Completion for `npm'."
  ;; Completion for the command argument.
  (pcomplete-here* '("install" "run" "start" "publish" "update"))

  ;; complete files/dirs forever if the command is `add' or `rm'.
  (when (pcomplete-match (regexp-opt '("run")) 1)
    (pcomplete-here
     (let* ((file (json-read-file "./package.json")))
       (if file
           (let* (
                  (scripts-1 (cdr (assoc 'scripts file)))
                  (scripts (cl-loop for (key . value) in scripts-1
                                    collect (cons (symbol-name key) value)))
                  (sorted-scripts (sort scripts (lambda (a b) (string< (car a) (car b)))))
                  )
             sorted-scripts
             )
         )
       )
     )))


(setq sql-postgres-login-params nil)
(setq sql-connection-alist
      '((aperi       (sql-product 'postgres) (sql-database "aperi" (sql-user "aperi") (sql-password "aperi") (sql-server "localhost")))
        (urwebschool (sql-product 'postgres) (sql-database "urwebschool") (sql-user "simon") (sql-server "localhost"))
        ))

(add-hook!
 sql-interactive-mode
 (set (make-local-variable 'company-backends)
      '(company-dabbrev-code)
      ))

(use-package! urweb-mode
  :load-path "/home/simon/urweb/src/elisp"
  ;; configure your package here
  )

(use-package! emmet-mode
  :hook (typescript-mode . emmet-mode)
  :hook (typescript-tsx-mode . emmet-mode)
  ;; configure your package here
  )

(defun workspace-switcher ()
  (interactive)
  (progn
    (+workspace/other)
    (show-workspace-switcher)
    )
  )

(defun show-workspace-switcher ()
  (interactive)
  (progn
    ;; Temporary change to how we want transient to show up
    ;; We always want this to go full length over the bottom
    ;; This option applies to all transient menus (including eg: magit)
    ;; So we roll it back after our own
    (setq transient-display-buffer-action
          '(display-buffer-in-side-window
            (side . bottom)
            (inhibit-same-window . nil)
            (window-parameters (no-other-window . t)))
          )
    (workspace-transient)
    (setq transient-display-buffer-action
          '(display-buffer-below-selected)
          )
    )
  )

(transient-define-prefix workspace-transient ()
  "test"
  :transient-non-suffix 'transient--do-quit-all ;; close transient state and popup buffer immediately when we use any other keybind
  ["Existing Workspaces"
   :class transient-row
   :setup-children
   (lambda (_els)
     (transient-parse-suffixes
      'workspace-transient
      (let ((i 0))
        (mapcar
         (lambda (name)
           (progn
             (cl-incf i)
             (let ((j i))
               (list
                (if (string= name (+workspace-current-name))
                    (concat "(" (number-to-string j) ")")
                  (number-to-string j))
                name
                (lambda () (interactive)
                  (progn
                    (+workspace/switch-to (- j 1))
                    (show-workspace-switcher)
                    ))
                )
               )
             ))
         (+workspace-list-names)
         )))
     )
   ]
  [
   ;; :class transient-row
   ["Modify"
    ("n" "New" +workspace/new-named ;; :transient transient--do-stay
     )
    ("x" "Delete" (lambda ()
                       (interactive)
                       (progn
                         (+workspace/delete (+workspace-current-name))
                         (+workspace/switch-to-0)
                         (show-workspace-switcher)
                         )))
    ]
   ["Premade"
    ("<f6>" "School sql" urwebschool-sql)
    ("<f7>" "School logs" urwebschool-logs)
    ("<f8>" "Aperi sql" aperi-sql)
    ("<f9>" "Aperi logs" aperi-logs)
    ]
   ]
  )

(defun urwebschool-sql ()
  (interactive)
  (progn
    (+workspace/new-named "school-sql")
    (find-file "/home/simon/ur-proj/school/sqlscratchpad.sql")
    (sql-connect "urwebschool")
    )
  )

;; (defun urwebschool-sql-hamaril ()
;;   (interactive)
;;   (progn
;;     (+workspace/new-named "school-sql-hamaril")
;;     (find-file "/home/simon/ur-proj/school/sqlscratchpad.sql")
;;     (let ((default-directory "/ssh:root@classyprod|sudo:postgres@classyprod:"))
;;       (sql-connect "hamaril"))
;;     )
;;   )


(defun urwebschool-logs ()
  (interactive)
  (let ((default-directory "/home/simon/ur-proj/school"))
    (+workspace/new-named "school-logs")
    (+vterm/here t)
    (vterm-insert "npm run proxy")
    (vterm-send-return)

    (+evil/window-vsplit-and-follow)

    (+vterm/here t)
    (vterm-insert "./school.exe")
    (vterm-send-return)

    (+evil/window-vsplit-and-follow)

    (+vterm/here t)
    (vterm-insert "nodemon")
    (vterm-send-return)
    )
  )

(defun aperi-sql ()
  (interactive)
  (progn
    (+workspace/new-named "aperi-sql")
    (find-file "/home/simon/projects/aperi-new/sqlscratchpad.sql")
    (sql-connect "aperi")
    )
  )


(defun aperi-logs ()
  (interactive)
  (let ((default-directory "/home/simon/projects/aperi-new"))
    (+workspace/new-named "aperi-logs")
    (+vterm/here t)
    (vterm-insert "npm run engine")
    (vterm-send-return)

    (+evil/window-vsplit-and-follow)

    (+vterm/here t)
    (vterm-insert "npm run device")
    (vterm-send-return)
    )
  )
