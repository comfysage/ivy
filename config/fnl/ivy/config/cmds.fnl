(vim.api.nvim_create_user_command :OpenPdf
                                  (fn []
                                    (let [filepath (vim.api.nvim_buf_get_name 0)]
                                      (when (filepath:match "%.typ$")
                                        (vim.ui.open (vim.fn.shellescape (filepath:gsub "%.typ$"
                                                                                        :.pdf))
                                                     {}))))
                                  {})

