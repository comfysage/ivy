local makeopt = require("chai.options").makeopt

return {
  options = {
    common = makeopt({
      {},
      "common server config",
      { "table", "callable" },
    }),
    servers = makeopt({
      {},
      "lsp servers to configure",
      { "table", "callable" },
    }),
    on_attach = makeopt({
      default = nil,
      description = "callback after lsp attaches",
      validator = "callable",
      optional = true,
    }),
  },
  setup = function(props)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
      callback = props.on_attach,
    })

    local common = props.common
    if type(common) == "function" then
      common = common()
    end

    vim.lsp.config("*", common)

    local servers = props.servers
    if type(servers) == "function" then
      servers = servers()
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    vim.iter(pairs(servers)):each(vim.lsp.config)
  end,
}
