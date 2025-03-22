(local makeopt (. (require :chai.options) :makeopt))

{:setup (fn []
          (vim.api.nvim_create_autocmd :VimResized
                                       {:command "wincmd ="
                                        :desc "Automatically resize windows when the host window size changes."
                                        :pattern "*"})
          (vim.api.nvim_create_autocmd :TextYankPost
                                       {:callback (fn []
                                                    (vim.highlight.on_yank {:higroup :IncSearch
                                                                            :timeout 200}))
                                        :desc "Highlight yanked text"
                                        :pattern "*"})
          (vim.api.nvim_create_autocmd [:RecordingEnter :RecordingLeave]
                                       {:callback (fn [data]
                                                    (local msg
                                                           (or (and (= data.event
                                                                       :RecordingEnter)
                                                                    "Recording macro...")
                                                               "Macro recorded"))
                                                    (vim.notify msg
                                                                vim.log.levels.INFO
                                                                {:title :Macro}))
                                        :desc "Notify when recording macro"})
          (vim.api.nvim_create_autocmd :WinEnter
                                       {:callback (fn [ev]
                                                    (when (not= (. vim.bo
                                                                   ev.buf
                                                                   :buftype)
                                                                :terminal)
                                                      (lua "return "))
                                                    (vim.cmd :startinsert))
                                        :pattern "term://*"})
          (vim.api.nvim_create_autocmd :TermOpen
                                       {:callback (fn [] (vim.cmd :startinsert))
                                        :desc "start insert mode on TermOpen"
                                        :pattern "term://*"})
          (vim.api.nvim_create_autocmd :TermOpen
                                       {:callback (fn []
                                                    (set vim.opt_local.number
                                                         false))
                                        :desc "remove line numbers"
                                        :pattern "term://*"})
          (vim.api.nvim_create_autocmd :BufWritePre
                                       {:callback (fn []
                                                    (local dir
                                                           (vim.fn.expand "<afile>:p:h"))
                                                    (when (= (dir:find "%l+://")
                                                             1)
                                                      (lua "return "))
                                                    (when (= (vim.fn.isdirectory dir)
                                                             0)
                                                      (vim.fn.mkdir dir :p)))
                                        :desc "create path to file"}))}

