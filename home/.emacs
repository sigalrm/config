;; .emacs
;
;;
;;; customizations follow
;;
;

(setq default-truncate-lines t)

;; turn off backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; C programming considerations
;(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(c-set-offset 'substatement-open 0)
(c-set-offset 'inextern-lang 0)
(setq c-default-style "linux")

;; Text mode considerations
;;(define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)

;; Key bindings
(global-set-key [f1] 'goto-line)

;
;;
;;; end customizations
;;
;

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
(setq require-final-newline 'query)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
