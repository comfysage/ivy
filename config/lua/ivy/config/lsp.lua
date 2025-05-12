local props = vim.g.lsp_config or {}

vim.validate("vim.g.lsp_config.common", props.common, { "table", "function" })
vim.validate("vim.g.lsp_config.servers", props.servers, { "table", "function" })
vim.validate("vim.g.lsp_config.on_attach", props.on_attach, "function")

local function setup_ls(name, cfg)
  ---@diagnostic disable-next-line: param-type-mismatch
  local ok, result = pcall(vim.lsp.config, name, cfg)
  if not ok then
    vim.notify(('unable to configure lsp server %s:\n\t%s'):format(name, result))
    return
  end
  vim.lsp.enable(name)
end

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
