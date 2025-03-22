(local makeopt (. (require :chai.options) :makeopt))

{:options {:common (makeopt [{}
                             "common server config"
                             (fn [v]
                               (local (ok _)
                                      (pcall vim.validate
                                             "common server configuration" v
                                             [:table :function]))
                               ok)])
           :on_attach (makeopt [(fn [])
                                "callback after lsp attaches"
                                :function])
           :servers (makeopt [{}
                              "lsp servers to configure"
                              (fn [v]
                                (local (ok _)
                                       (pcall vim.validate
                                              "server configurations" v
                                              [:table :function]))
                                ok)])}
 :setup (fn [props]
          (vim.api.nvim_create_autocmd :LspAttach
                                       {:callback props.on_attach
                                        :group (vim.api.nvim_create_augroup :LspAttach
                                                                            {:clear true})})
          (var common props.common)
          (when (= (type common) :function) (set common (common)))
          (vim.lsp.config "*" common)
          (var servers props.servers)
          (when (= (type servers) :function) (set servers (servers)))
          (: (vim.iter (pairs servers)) :each vim.lsp.config)
          (local lsp-names (: (: (vim.iter (ipairs (vim.api.nvim_get_runtime_file :lsp/*.lua
                                                                                  true)))
                                 :map
                                 (fn [_ filepath]
                                   (local name
                                          (: (vim.fs.basename filepath) :match
                                             "([^.]+)%.lua"))
                                   (or (and (not= name "*") name) nil)))
                              :totable))
          (vim.lsp.enable lsp-names))}

