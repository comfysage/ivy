local makeopt = require("chai.options").makeopt

return {
  options = {
    common = makeopt({
      {},
      "common server config",
      function(v)
        local ok, _ = pcall(vim.validate, "common server configuration", v, { "table", "function" })
        return ok
      end,
    }),
    servers = makeopt({
      {},
      "lsp servers to configure",
      function(v)
        local ok, _ = pcall(vim.validate, "server configurations", v, { "table", "function" })
        return ok
      end,
    }),
    on_attach = makeopt({
      function() end,
      "callback after lsp attaches",
      "function",
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

    local lsp_names = vim
      .iter(ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)))
      :map(function(_, filepath)
        local name = vim.fs.basename(filepath):match("([^.]+)%.lua")
        return name ~= "*" and name or nil
      end)
      :totable()
    vim.lsp.enable(lsp_names)
  end,
}
