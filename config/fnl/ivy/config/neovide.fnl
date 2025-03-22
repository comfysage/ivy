(when (not vim.g.neovide) (lua "return "))

(set vim.g.neovide_transparency 1)

(fn _G.neovide_alpha []
  (string.format "%x" (math.floor (* 255 (or vim.g.transparency 0.8)))))

(if (= (. (vim.uv.os_uname) :sysname) :Darwin)
    (do
      (set vim.g.neovide_normal_opacity 0.6)
      (set vim.g.neovide_window_blurred true))
    (set vim.g.neovide_normal_opacity 0.9))

(vim.api.nvim_create_autocmd :ColorScheme
                             {:callback (fn []
                                          (local normal
                                                 (or (vim.api.nvim_get_hl 0
                                                                          {:name :Normal})
                                                     {:bg 0 :fg 0}))
                                          (local bg
                                                 (string.format "%x" normal.bg))
                                          (local fg
                                                 (string.format "%x" normal.fg))
                                          (set vim.g.neovide_background_color
                                               (.. bg (_G.neovide_alpha)))
                                          (set vim.g.neovide_title_background_color
                                               bg)
                                          (set vim.g.neovide_title_text_color
                                               fg))
                              :group (vim.api.nvim_create_augroup "neovide:background"
                                                                  {:clear true})})

(vim.api.nvim_exec_autocmds :ColorScheme {})

(set vim.g.fontsize 14)

(local fonts [{:family "Maple Mono"} {:family "Symbols Nerd Font" :size 13}])

(set vim.o.guifont
     (: (vim.iter fonts) :fold ""
        (fn [acc font]
          (when (> (length acc) 0) (set-forcibly! acc (.. acc ",")))
          (.. acc
              (string.format "%s:h%d" font.family (or font.size vim.g.fontsize))))))

(set vim.g.lineheight 1.2)

(set vim.opt.linespace (math.floor (* (- vim.g.lineheight 1) vim.g.fontsize)))

(set vim.g.neovide_detach_on_quit :always_detach)

(vim.keymap.set :n :<m-enter>
                (fn []
                  (set vim.g.neovide_fullscreen (not vim.g.neovide_fullscreen))
                  (if vim.g.neovide_fullscreen
                      (vim.notify "enabling fullscreen")
                      (vim.notify "disabling fullscreen")))
                {:noremap true :silent true})

