;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Soham Chowdhury"
      user-mail-address "chow.soham@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "PragmataPro Liga" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq haskell-process-type 'cabal-new-repl)

(after! lsp-haskell
 (setq lsp-haskell-process-path-hie "ghcide")
 (setq lsp-haskell-process-args-hie '()))

(map! :leader
      (:after lsp-mode
        (:prefix ("l" . "LSP")
          :desc "Excute code action" "a" #'lsp-execute-code-action
          :desc "Go to definition" "d" #'lsp-find-definition
          :desc "Glance at doc" "g" #'lsp-ui-doc-glance
          (:prefix ("u" . "LSP UI")
            :desc "Toggle doc mode" "d" #'lsp-ui-doc-mode
            :desc "Toggle sideline mode"  "s" #'lsp-ui-sideline-mode
            :desc "Glance at doc" "g" #'lsp-ui-doc-glance
            :desc "Toggle imenu"  "i" #'lsp-ui-imenu)))
       (:prefix-map ("b" . "buffer")
        :desc "Previous buffer"             "h"   #'previous-buffer
        :desc "Next buffer"                 "l"   #'next-buffer))

(map! :map org-mode-map
      :localleader
      "x" #'org-latex-preview)

(after! ivy
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-delete-char))

(defun setup-pragmata-ligatures ()
  (setq prettify-symbols-alist
        (append prettify-symbols-alist
          '(("<-"   . ?🡐)
            ("->"   . ?🡒)
            ("=>"   . ?⇒)
            ("<=>"  . ?⟺)
            ("<==>" . ?⟺)
            ("==>"  . ?⟹)
            ("<=="  . ?⟸)
            ("|->"  . ?⟼)
            ("<-|"  . ?⟻)
            ("|=>"  . ?⟾)
            ("<=|"  . ?⟽)))))

(defun refresh-pretty ()
  (prettify-symbols-mode -1)
  (prettify-symbols-mode +1))

;; Hooks for modes in which to install the Pragmata ligatures
(mapc (lambda (hook)
        (add-hook hook (lambda () (setup-pragmata-ligatures) (refresh-pretty))))
      '(text-mode-hook
        prog-mode-hook))
(global-prettify-symbols-mode +1)

(setq org-bullets-bullet-list '("·" "··" "𐬼"))

(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))
