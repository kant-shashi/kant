
(global-linum-mode t)
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;;add colors to shell
(setq ansi-term-color-vector [unspecified "#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#DD6600" "#dc8cc3" "#93e0e3" "#dcdccc"])

;;package archive
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


;;el-get
;;https://github.com/dimitri/el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;;enable jedi autocompletion
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;;enable flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-to-list 'load-path "~/.emacs.d/")
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;;enable linum mode
(add-hook 'python-mode-hook 'linum-mode)

(package-initialize)
(elpy-enable)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
  '(lambda ()
     (font-lock-add-keywords
       nil
        '(("\t" 0 'trailing-whitespace prepend))
     )
   )
)
(put 'upcase-region 'disabled nil)

(setq tabbar-buffer-groups-function
      (lambda ()
        (list "All")))

;; code for smooth scrolling begins
(defun smooth-scroll (number-lines increment)
  (if (= 0 number-lines)
      t
    (progn
      (sit-for 0.02)
      (scroll-up increment)
       (smooth-scroll (- number-lines 1) increment))))

(global-set-key [(mouse-5)] '(lambda () (interactive) (smooth-scroll 6 1)))
(global-set-key [(mouse-4)] '(lambda () (interactive) (smooth-scroll 6 -1)))

;; code for smooth scrolling ends here

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; configuration for c++ (3 June 13) starts here
;; Here is a sample .emacs configuration for working with C++.
;; Note that everything after a semicolon is a comment.
;; Part I. Essentials to editing
;; Specify a directory where to load additional Emacs Lisp files.
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
;; Turns on syntax highlighting.
(global-font-lock-mode t)
;; Sets the syntax highlighting to the maximum amount of colorization.
(setq font-lock-maximum-decoration t)
;; Do not make backup recovery files when editing.
(setq make-backup-files nil)
;; Use Shift + the arrow keys to move between windows in a frame
(when (fboundp 'windmove-default-keybindings)
            (windmove-default-keybindings))
;; Part II. Configure Emacs as a great C++ IDE
;; Include the C/C++ mode Elisp package
(require 'cc-mode)
;; In versions of Emacs greater than 23.2, do the following
(when (or (> emacs-major-version 23)
                (and (= emacs-major-version 23)
                     (>= emacs-minor-version 2)))
 ;; Use the GDB visual debugging mode
 (setq gdb-many-windows t)
 ;; Turn Semantic on
 (semantic-mode 1)
 ;; Try to make completions when not typing
 (global-semantic-idle-completions-mode 1)
 ;; Use the Semantic speedbar additions
 (add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb))))
;; Treat .h files as C++ files (instead of C)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; Use the indentation style of "The C++ Programming Language"
(setq c-default-style "stroustrup")
;; Return adds a newline and indents
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;; Run compile when you press F5
(global-set-key (kbd "<f5>") 'compile)
;;configuration for c++ (3 June 13) ends here.

;; making tab navigation easy (start here)
(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)
;; making tab navigation easy (ends here)

;;(menu-bar-mode -1)    ;hide menu-bar
(scroll-bar-mode -1)  ;hide scroll bar
(tool-bar-mode -1)  ;hide tool-bar

;;(provide '.emacs)
;;; .emacs ends here
