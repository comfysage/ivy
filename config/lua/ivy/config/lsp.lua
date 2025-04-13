local makeopt = require("chai.options").makeopt

local function setup_ls(name, cfg)
  ---@diagnostic disable-next-line: param-type-mismatch
  local ok, result = pcall(vim.lsp.config, name, cfg)
  if not ok then
    vim.notify(('unable to configure lsp server %s:\n\t%s'):format(name, result))
    return
  end
  vim.lsp.enable(name)
end

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
    vim.iter(pairs(servers)):each(setup_ls)
  end,
}
