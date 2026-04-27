;; =========================================
;; 基本設定
;; =========================================
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)

;; =========================================
;; package管理
;; =========================================
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; =========================================
;; SKK（日本語入力）🔥
;; =========================================
(use-package ddskk
  :init
  ;; デフォルトでSKK有効
  (global-set-key (kbd "C-x C-j") 'skk-mode)

  :config
  ;; 辞書設定（必要に応じて変更）
  (setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")

  ;; 入力モード表示
  (setq skk-show-mode-show t)

  ;; スペースで変換
  (setq skk-use-jisx0201-input-method nil)

  ;; Enterで確定
  (define-key skk-j-mode-map (kbd "RET") 'skk-kakutei)

  ;; バックスペース
  (define-key skk-j-mode-map (kbd "DEL") 'skk-delete-backward-char)

  ;; 軽量化
  (setq skk-auto-insert-paren nil))

;; =========================================
;; 補完UI
;; =========================================
(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)))

(use-package marginalia
  :init
  (marginalia-mode))

;; =========================================
;; LSP（コード理解）
;; =========================================
(use-package eglot
  :hook (python-mode . eglot-ensure))

;; =========================================
;; Python
;; =========================================
(use-package python)

(use-package blacken
  :hook (python-mode . blacken-mode))

;; =========================================
;; Git
;; =========================================
(use-package magit
  :bind ("C-x g" . magit-status))

;; =========================================
;; AI（最重要）
;; =========================================
(use-package gptel
  :config
  (setq gptel-api-key (getenv "OPENAI_API_KEY"))
  (setq gptel-model "gpt-4.1")
  :bind ("C-c a" . gptel))

;; =========================================
;; Copilot（補完）
;; =========================================
;; (use-package copilot
;;  :hook (prog-mode . copilot-mode)
;;  :bind (("C-<tab>" . copilot-accept-completion)))

;; =========================================
;; その他
;; =========================================
(use-package which-key
  :init (which-key-mode))

(set-language-environment "UTF-8")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
