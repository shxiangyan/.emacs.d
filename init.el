 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar yan/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		;;    	smex
		;;自动补全括号
		swiper
		counsel
		;;括号匹配
		smartparens
		;;帮助小显示命令行
		popwin

                anaconda-mode
                company-anaconda

                yasnippet
                flycheck
                helm
                ivy
                expand-region
                iedit
		) "Default packages")

 (setq package-selected-packages yan/packages)

 (defun yan/packages-installed-p ()
     (loop for pkg in yan/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (yan/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg yan/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

 ;; Find Executable Path on OS X
 ;;(when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
    ("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(package-selected-packages (quote (company hungry-delete swiper counsel smartparens popwin))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )






;;(electric-indent-mode -1)

;;(package-initialize)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(global-linum-mode t)

;;(set ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)

(setq inhibit-splash-screen t)

(setq initial-scratch-message nil)

(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

(global-set-key (kbd "<f2>") 'open-my-init-file)

(setq-default cursor-type 'bar)



;(setq package-archives
 ;     '(("elpy" . "http://jorgenschaefer.github.io/packages/")
  ;      ("melpa" . "https://melpa.org/packages/")
   ;     ("gnu" . "http://elpa.gnu.org/packages/")
    ;    ("melpa-stable" . "https://stable.melpa.org/packages/")))

;;禁止auto保存
(setq auto-save-default nil)


;;关闭生成自动备份文件
(setq make-backup-files nil)

;;使用下面的配置文件将删除功能配置成与其他图形界面的编辑器相同，即当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字
(delete-selection-mode 1)


(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(global-set-key (kbd "C-=")'er/expand-region)


;; 开启的时候是全屏
(setq initial-frame-alist (quote((fullscreen . maximized))))

;; 配置括号
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(require 'org)
(setq org-src-fontify-natively t)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;同时选中多个相同字符
(require 'iedit)


;;设置字体
(set-face-attribute 'default nil :height 160)

;;显示当前行
(global-hl-line-mode t)


;;自动补全
(global-company-mode t)
(setq hippie-expand-try-functions-list '(try-expand-debbrev
                                         try-expand-debbrev-all-buffers
                                         try-expand-debbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;;hungry-delete
(require 'hungry-delete)
(global-hungry-delete-mode)

;;smartparens setting, 自动补全括号
(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

(require 'popwin)
(popwin-mode t)

;;语法检查
(global-flycheck-mode t)

(require 'yasnippet)


;;代码补全
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook
           (lambda()
             (set(make-local-variable 'commpany-backends) '(commpany-anaconda commpany-dabbrev))))
;;(setq tramp-ssh-controlmaster-options "-o ControlMaster-auto -oControlPath='tramp.%%C' -o ContrlPersist=no")

(org-babel-do-load-languages
 'ort-babel-load-languages
 '((python .t)))
;;(set-default trauncate-line nil)

;;加快tramp速度
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
     (format "%s\\|%s"
             vc-ignore-dir-regexp
             tramp-file-name-regexp))
(setq tramp-verbose 1)

;;swiper setting
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

(global-set-key(kbd "M-s e")'iedit-mode)

(global-set-key(kbd "C-x /")'comment-or-uncomment-region)

(global-set-key (kbd "C-z")'er/expand-region)

;;(global-set-key(kbd "C-x x")'pythonic-activate)

;;查找多个字符串
;;(global-set-key(kbd "<f5>")'helm-do-ag-project-root)

;;org-mode语法高亮
(require 'org)
(setq org-src-fontify-natively t)
;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/.emacs.d/org"))
;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)



(global-auto-revert-mode t)




;;定义输入代替
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;;定义输入li得到xiaoli
					    ("li" "xiaoli")

					    ))
;;xiaoli/
;;输入定义的字符/ 得到全部字符串


