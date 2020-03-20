(setq user-full-name "Soham Chowdhury"
      user-mail-address "chow.soham@gmail.com")

(setq doom-font (font-spec :family "PragmataPro Liga" :size 20)
      doom-variable-pitch-font (font-spec :family "PragmataPro Liga" :size 20))

(setq doom-theme 'doom-one)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq treemacs-width 30)

(setq org-directory "~/org/")

(after! org
  (add-to-list 'org-modules 'org-habit t))

(map! :map org-mode-map
      :localleader
      "x" #'org-latex-preview)

(setq org-bullets-bullet-list '("·" "··" "𐬼"))

(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))

(setq display-line-numbers-type nil)

(map! :leader
       (:prefix-map ("b" . "buffer")
        :desc "Previous buffer"             "h"   #'previous-buffer
        :desc "Next buffer"                 "l"   #'next-buffer))

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
;; (mapc (lambda (hook)
;;         (add-hook hook (lambda () (setup-pragmata-ligatures) (refresh-pretty))))
;;       '(text-mode-hook
;;         prog-mode-hook))
;; (global-prettify-symbols-mode +1)

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
            :desc "Toggle imenu"  "i" #'lsp-ui-imenu))))

(after! haskell-mode
  (set-formatter! 'ormolu "ormolu"
    :modes '(haskell-mode)))

(global-company-mode +1)
