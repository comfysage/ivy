(local { : makeopt } (require :chai.options))

{:options {:float_border (makeopt [:single
                                   "border for floating windows"
                                   (fn [v]
                                     (vim.tbl_contains [:single
                                                        :double
                                                        :rounded
                                                        :solid]
                                                       v))])}
 :setup (fn [props]
          (set vim.opt.encoding :utf-8)
          (set vim.opt.title true)
          (set vim.opt.titlestring "%f · nvim")
          (set vim.opt.errorbells false)
          (set vim.opt.mouse :nv)
          (set vim.opt.keywordprg ":vertical botright help")
          (set vim.opt.termguicolors true)
          (set vim.opt.number true)
          (set vim.opt.relativenumber false)
          (set vim.opt.numberwidth 3)
          (set vim.o.scrolloff 5)
          (set vim.o.sidescrolloff 15)
          (set vim.o.pumheight 15)
          (set vim.opt.wildoptions [:fuzzy :pum :tagfile])
          (set vim.opt.wildmode "longest:full,full")
          (: (vim.iter (ipairs [:menu :menuone :noselect :preview])) :each
             (fn [_ option]
               (when (not (vim.tbl_contains (vim.opt.completeopt:get) option))
                 (vim.opt.completeopt:append option))))
          (set vim.o.splitbelow true)
          (set vim.o.splitright true)
          (set vim.opt.incsearch true)
          (set vim.opt.hlsearch true)
          (set vim.o.ignorecase true)
          (set vim.o.smartcase true)
          (set vim.opt.inccommand :split)
          (set vim.opt.foldenable false)
          (set vim.opt.foldlevelstart 0)
          (set vim.opt.foldnestmax 4)
          (set vim.opt.foldmethod :expr)
          (set vim.opt.foldexpr "nvim_treesitter#foldexpr()")
          (vim.opt.iskeyword:remove "_")
          (set vim.opt.virtualedit :block)
          (set vim.o.shiftwidth 2)
          (set vim.o.tabstop 2)
          (set vim.o.softtabstop 0)
          (set vim.o.expandtab true)
          (set vim.o.smartindent true)
          (set vim.o.smarttab true)
          (set vim.opt.breakindent true)
          (set vim.o.wrap false)
          (set vim.o.signcolumn "yes:1")
          (vim.opt.shortmess:append :sI)
          (set vim.opt.formatoptions :tcrqj)
          (set vim.opt.conceallevel 2)
          (set vim.opt.concealcursor :c)
          (set vim.g.have_nerd_font true)
          (set vim.opt.updatetime 250)
          (set vim.opt.timeout false)
          (set vim.opt.timeoutlen 0)
          (set vim.opt.showmode false)
          (set vim.opt.showcmd false)
          (set vim.o.showtabline 1)
          (set vim.o.cmdheight 0)
          (set vim.o.laststatus 3)
          (set vim.opt.grepprg
               (or (and (= (vim.fn.executable :rg) 1) "rg --vimgrep")
                   "grep -n $* /dev/null"))
          (set vim.opt.grepformat "%f:%l:%c:%m")
          (set vim.opt.spelllang [:en])
          (vim.opt.spelloptions:append :noplainbuffer)
          (set vim.opt.list true)
          (set vim.opt.shell (or (os.getenv :SHELL) :/bin/sh))
          (set vim.opt.swapfile false)
          (set vim.opt.backup false)
          (set vim.opt.undodir (.. (vim.fn.stdpath :state) :/undodir))
          (set vim.opt.undofile true)
          (set vim.opt.hidden true)
          (local borderchars
                 {:double {:botleft "╚"
                           :botright "╝"
                           :horiz "═"
                           :horizdown "╦"
                           :horizup "╩"
                           :style :double
                           :topleft "╔"
                           :topright "╗"
                           :vert "║"
                           :verthoriz "╬"
                           :vertleft "╣"
                           :vertright "╠"}
                  :rounded {:botleft "╰"
                            :botright "╯"
                            :horiz "─"
                            :horizdown "┬"
                            :horizup "┴"
                            :style :rounded
                            :topleft "╭"
                            :topright "╮"
                            :vert "│"
                            :verthoriz "┼"
                            :vertleft "┤"
                            :vertright "├"}
                  :single {:botleft "└"
                           :botright "┘"
                           :horiz "─"
                           :horizdown "┬"
                           :horizup "┴"
                           :style :single
                           :topleft "┌"
                           :topright "┐"
                           :vert "│"
                           :verthoriz "┼"
                           :vertleft "┤"
                           :vertright "├"}
                  :solid {:botleft "▀"
                          :botright "▀"
                          :bottom "▀"
                          :horiz "▄"
                          :horizdown "▄"
                          :horizup "▀"
                          :style :solid
                          :topleft "▄"
                          :topright "▄"
                          :vert "█"
                          :verthoriz "█"
                          :vertleft "█"
                          :vertright "█"}})
          (set vim.g.bc (or (. borderchars props.float_border)
                            borderchars.single))
          (set vim.g.bc_all [vim.g.bc.topleft
                             (or vim.g.bc.top vim.g.bc.horiz)
                             vim.g.bc.topright
                             vim.g.bc.vert
                             vim.g.bc.botright
                             (or vim.g.bc.bottom vim.g.bc.horiz)
                             vim.g.bc.botleft
                             vim.g.bc.vert])
          (vim.opt.fillchars:append {:horiz vim.g.bc.horiz
                                     :horizdown vim.g.bc.horizdown
                                     :horizup vim.g.bc.horizup
                                     :vert vim.g.bc.vert
                                     :verthoriz vim.g.bc.verthoriz
                                     :vertleft vim.g.bc.vertleft
                                     :vertright vim.g.bc.vertright})
          (set vim.g.rustfmt_autosave 1)
          (set vim.g.loaded_node_provider 0)
          (set vim.g.loaded_perl_provider 0)
          (set vim.g.loaded_python_provider 0)
          (set vim.g.loaded_python3_provider 0)
          (set vim.g.loaded_ruby_provider 0)
          (set vim.g.markdown_recommended_style 0)
          (local guicursor-opts
                 {:insert {:animate {:off 150 :on 150 :wait 50}
                           :size 200
                           :type :vertical}
                  :normal {:type :block}
                  :operator {:size 50 :type :horizontal}
                  :replace {:size 20 :type :horizontal}
                  :showmatch {:type :block}})
          (local mode-lookup {:insert :i-ci-ve
                              :normal :n-v-c
                              :operator :o
                              :replace :r-cr
                              :showmatch :sm})
          (local type-lookup {:block :block :horizontal :hor :vertical :ver})
          (local guicusor (: (vim.iter (pairs guicursor-opts)) :fold ""
                             (fn [str mode opts]
                               (vim.validate :mode mode
                                             (fn [v]
                                               (vim.tbl_contains [:normal
                                                                  :insert
                                                                  :replace
                                                                  :operator
                                                                  :showmatch]
                                                                 v))
                                             "valid mode")
                               (vim.validate :opts opts
                                             (fn [v]
                                               (vim.validate :type v.type
                                                             (fn [t]
                                                               (vim.tbl_contains [:block
                                                                                  :vertical
                                                                                  :horizontal]
                                                                                 t))
                                                             "valid type")
                                               (when (not= v.type :block)
                                                 (vim.validate :size v.size
                                                               (fn [s]
                                                                 (= (type s)
                                                                    :number))
                                                               "valid size with type ~= block"))
                                               (when v.animate
                                                 (vim.validate :animate
                                                               v.animate
                                                               (fn [anim]
                                                                 (vim.validate :wait
                                                                               anim.wait
                                                                               :number)
                                                                 (vim.validate :on
                                                                               anim.on
                                                                               :number)
                                                                 (vim.validate :off
                                                                               anim.off
                                                                               :number)
                                                                 true)
                                                               "valid animation"))
                                               true)
                                             "valid opts")
                               (when (> (length str) 0)
                                 (set-forcibly! str (.. str ",")))
                               (var s
                                    (string.format "%s:%s" (. mode-lookup mode)
                                                   (or (and (not= opts.type
                                                                  :block)
                                                            (string.format "%s%d"
                                                                           (. type-lookup
                                                                              opts.type)
                                                                           opts.size))
                                                       (. type-lookup opts.type))))
                               (when opts.animate (local anim opts.animate)
                                 (local anim-str
                                        (string.format "blinkwait%d-blinkon%d-blinkoff%d"
                                                       anim.wait anim.on
                                                       anim.off))
                                 (set s (.. s "-" anim-str)))
                               (.. str s))))
          (set vim.opt.guicursor guicusor)
          (vim.diagnostic.config {:float {:border vim.g.bc_all
                                          :header ""
                                          :prefix (fn [_ i]
                                                    (values (string.format "%d. "
                                                                           i)
                                                            :LineNr))}
                                  :signs true
                                  :virtual_text {:hl_mode :combine}}))}

