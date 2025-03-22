{:setup (fn []
  (local keymaps ((. (require :keymaps) :setup)))

  (fn kmgroup [props]
    (when (not props.group)
      (vim.notify (string.format "[%s] %s" :globals.keymap
                                 "`Keymap.group` requires `group` field")
                  vim.log.levels.WARN)
      (lua "return "))
    (local mappings props)
    (: (vim.iter (ipairs mappings)) :each
       (fn [_ map]
         (when (< (length map) 4)
           (vim.notify (string.format "[%s] %s" :globals.keymap
                                      "`Keymap.group` requires 4 paramaters per keymap")
                       vim.log.levels.WARN)
           (lua "return "))
         (local mode (. map 1))
         (local lhs (. map 2))
         (local rhs (. map 3))
         (local desc (. map 4))
         (when (not (. keymaps mode))
           (vim.notify (string.format "[%s] %s" :globals.keymap
                                      (.. "keymap mode '" mode
                                          "' does not exist"))
                       vim.log.levels.WARN)
           (lua "return "))
         (tset (. keymaps mode) lhs {1 rhs 2 desc :group props.group}))))

  (fn cbcall [___fn___ props] (fn [] (pcall ___fn___ props)))

  (set vim.g.mapleader " ")
  (set vim.g.maplocalleader " m")
  (kmgroup {1 [:normal
               "<space>,k"
               "<cmd>s/keymaps\\.\\(\\w*\\)\\[\"\\([^\"]*\\)\"\\] = { \\([^,]*\\), \"\\([^\"]*\\)\" }/{ \"\\1\", \"\\2\", \\3, \"\\4\" }/<cr>"
               "transform line to group item format"]
            :group :keymaps})
  (kmgroup {1 [:normal :W :g_ "goto last non empty of line"]
            2 [:normal :B "^" "goto first non empty of line"]
            3 [:visual :W :g_ "goto last non empty of line"]
            4 [:visual :B "^" "goto first non empty of line"]
            :group :movement})
  (kmgroup {1 [:normal :<C-d> :<C-d>zz "go down and center line"]
            2 [:normal :<C-u> :<C-u>zz "go up and center line"]
            3 [:normal :n :nzzzv "goto next search and uncover line"]
            4 [:normal :N :Nzzzv "goto prev search and uncover line"]
            :group "vertical movment"})
  (kmgroup {1 [:normal :<S-down> :<nop> "remove shift down movement"]
            2 [:normal :<S-up> :<nop> "remove shift up movement"]
            :group :fixup})
  (kmgroup {1 [:normal :<leader>q vim.cmd.quitall "quit all"]
            2 [:visual :<leader>q vim.cmd.quitall "quit all"]
            :group :workspace})
  (kmgroup {1 [:normal :<C-s> vim.cmd.update "save file"] :group :file})
  (each [_ direction (ipairs [:h :j :k :l])]
    (tset keymaps.normal (.. :<leader> direction)
          {1 (fn [] (vim.cmd.wincmd direction))
           2 (string.format "switch window `%s`" direction)
           :group :windows}))
  (set keymaps.normal.s {1 :<nop> 2 "fixup `s`" :group :fixup})
  (kmgroup {1 [:normal :sv vim.cmd.vsplit "split window vertical"]
            2 [:normal :sh vim.cmd.split "split window horizontal"]
            :group :windows})
  (kmgroup {1 [:normal "<space><tab>]" vim.cmd.tabnext "next tab"]
            2 [:normal "<space><tab>[" vim.cmd.tabprev "prev tab"]
            3 [:normal
               :<space><tab>n
               (cbcall vim.cmd :$tabedit)
               "open new tab"]
            4 [:normal
               :<space><tab>d
               vim.cmd.tabclose
               "close current tab"]
            5 [:normal
               :<space><tab>x
               vim.cmd.tabclose
               "close current tab"]
            6 [:normal
               :<space><tab><
               (fn [] (vim.cmd " -tabmove "))
               "move tab to the left"]
            7 [:normal
               :<space><tab>>
               (fn [] (vim.cmd " +tabmove "))
               "move tab to the right"]
            :group :tabs})
  (kmgroup {1 [:normal
               "<C-\\>"
               (fn [] (vim.cmd "vs | wincmd l"))
               "split file vertically"]
            2 [:normal :<C-h> :<C-w>h "switch window left"]
            3 [:normal :<C-l> :<C-w>l "switch window right"]
            4 [:normal :<C-j> :<C-w>j "switch window down"]
            5 [:normal :<C-k> :<C-w>k "switch window up"]
            :group :windows})
  (kmgroup {1 [:normal :<M-v> :^vg_ "select contents of current line"]
            :group :selection})
  (tset keymaps.normal ";"
        {1 (fn [] (vim.notify "use `v;`" vim.log.levels.WARN))
         2 "fixup `v;`"
         :group :fixup})
  (vim.keymap.set :o ";" :iw {:desc "select inside word"})
  (vim.keymap.set :v ";" :iw {:desc "select inside word"})
  (set keymaps.normal.D {1 :0d$ 2 "clear current line" :group :edit})
  (kmgroup {1 [:normal
               :<leader>dd
               vim.diagnostic.open_float
               "hover diagnostics"]
            :group :diagnostics})
  (kmgroup {1 [:normal :q :<nop> "fixup q"]
            2 [:normal :Q :q "record macro"]
            :group :recording})
  (kmgroup {1 [:normal :gm vim.show_pos "inspect treesitter node"]
            :group :treesitter})
  (local ns (vim.api.nvim_create_namespace :resize-mode))
  (tset keymaps.normal :<space>w
        [(fn []
           (vim.on_key (fn [key typed]
                         (local switch
                                {:<C-H> (fn []
                                          (when (= (vim.fn.winnr)
                                                   (vim.fn.winnr :l))
                                            (let [___antifnl_rtns_1___ [(vim.fn.win_move_separator (vim.fn.winnr :h)
                                                                                                   (- 1))]]
                                              (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
                                          (vim.fn.win_move_separator (vim.fn.winnr)
                                                                     (- 1)))
                                 :<C-J> (fn []
                                          (when (not= (vim.fn.winnr)
                                                      (vim.fn.winnr :j))
                                            (vim.fn.win_move_statusline (vim.fn.winnr)
                                                                        1))
                                          (vim.fn.win_move_statusline (vim.fn.winnr :k)
                                                                      1))
                                 :<C-K> (fn []
                                          (when (not= (vim.fn.winnr)
                                                      (vim.fn.winnr :j))
                                            (vim.fn.win_move_statusline (vim.fn.winnr)
                                                                        (- 1)))
                                          (vim.fn.win_move_statusline (vim.fn.winnr :k)
                                                                      (- 1)))
                                 :<C-L> (fn []
                                          (when (= (vim.fn.winnr)
                                                   (vim.fn.winnr :l))
                                            (let [___antifnl_rtns_1___ [(vim.fn.win_move_separator (vim.fn.winnr :h)
                                                                                                   1)]]
                                              (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
                                          (vim.fn.win_move_separator (vim.fn.winnr)
                                                                     1))})
                         (local k (vim.fn.keytrans typed))
                         (if (= k :<Esc>) (vim.on_key nil ns)
                             (vim.tbl_contains [:h :j :k :l] k)
                             (vim.cmd.wincmd k)
                             (vim.tbl_contains (vim.tbl_keys switch) k)
                             (do
                               (local ___fn___ (. switch k))
                               (when (and ___fn___
                                          (= (type ___fn___) :function))
                                 (___fn___))))
                         "") ns))
         "enter resize mode"])
  (tset keymaps.terminal :<esc><esc>
        ["<C-\\><C-n>" "escape terminal mode"]))}

