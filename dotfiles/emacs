;; .emacs
;
;;
;;; customizations follow
;;
;
;(package-initialize)
;(add-to-list 'custom-theme-load-path "~/git/emacs-color-theme-solarized")
;(add-to-list 'load-path "~/.emacs.d/lisp/")
;(load-theme 'leuven t)
;(load-theme 'solarized t)
;(setq custom-safe-themes t)

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . javascript-mode))

;; terminal mouse settings
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

(setq default-truncate-lines t)
(setq column-number-mode t)

;; prompt before exit
;(add-hook 'kill-emacs-query-functions
;  (lambda () (y-or-n-p "Exit Emacs? "))
;  'append)
(global-unset-key (kbd "C-x C-c"))

;; turn off backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; C programming considerations
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(c-set-offset 'substatement-open 0)
(c-set-offset 'inextern-lang 0)
(setq c-default-style "linux")

;; Text mode considerations
;;(define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)

;; Key bindings
(global-set-key [f1] 'goto-line)

;; http://stackoverflow.com/questions/23553881/emacs-indenting-of-c11-lambda-functions-cc-mode
(defadvice c-lineup-arglist (around my activate)
  "Improve indentation of continued C++11 lambda function opened as argument."
  (setq ad-return-value
        (if (and (equal major-mode 'c++-mode)
                 (ignore-errors
                   (save-excursion
                     (goto-char (c-langelem-pos langelem))
                     ;; Detect "[...](" or "[...]{". preceded by "," or "(",
                     ;;   and with unclosed brace.
                     (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
            0                           ; no additional indent
          ad-do-it)))                   ; default behavior
;
;;
;;; end customizations
;;
;

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode) (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format (concat "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
(setq require-final-newline 'query)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote light))
 '(inhibit-startup-screen t))
