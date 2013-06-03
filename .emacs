
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
 '(custom-enabled-themes (quote (misterioso))))
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


;;;emacs ends here
