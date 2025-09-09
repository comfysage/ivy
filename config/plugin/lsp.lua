local props = vim.g.lsp_config or {}

vim.validate("vim.g.lsp_config.common", props.common, { "table", "function" })
vim.validate("vim.g.lsp_config.servers", props.servers, { "table", "function" })
vim.validate("vim.g.lsp_config.on_attach", props.on_attach, "function")

local components = {
  {
    name = "inlay_hint",
    callback = function(client, buf)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
      end
    end,
  },
  {
    name = "document_highlight",
    callback = function(client, buf)
      if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup(string.format("lsp:document_highlight:%d", buf), { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = group,
          buffer = buf,
          callback = function()
            vim.lsp.buf.clear_references()
            vim.lsp.buf.document_highlight()
          end,
          desc = "highlight lsp reference",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          group = group,
          buffer = buf,
          callback = function()
            vim.lsp.buf.clear_references()
          end,
          desc = "clear lsp references",
        })
      end
    end,
  },
  {
    name = "linked_editing_range",
    callback = function(client, _)
      if client.server_capabilities.linkedEditingRangeProvider then
        vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
      end
    end,
  },
  {
    name = "document_color",
    callback = function(client, bufnr)
      if client.server_capabilities.documentColorProvider then
        vim.lsp.document_color.enable(true, bufnr)
      end
    end,
  },
  { name = "user", callback = props.on_attach },
}

vim.iter(ipairs(components)):each(function(_, fn)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp:" .. fn.name, { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client == nil then
        return
      end
      local ok, result = pcall(fn.callback, client, ev.buf)
      if not ok then
        vim.api.nvim_echo(
          { { "unable to run on attach events for lsp server " }, { client.name }, { ":\n\t" }, { result } },
          true,
          { err = true }
        )
        return
      end
    end,
  })
end)

local common = props.common
if type(common) == "function" then
  common = common()
end

vim.lsp.config("*", common)

local function setup_ls(name, cfg)
  ---@diagnostic disable-next-line: param-type-mismatch
  local ok, result = pcall(vim.lsp.config, name, cfg)
  if not ok then
    vim.notify(("unable to configure lsp server %s:\n\t%s"):format(name, result))
    return
  end
  vim.lsp.enable(name)
end

local servers = props.servers
if type(servers) == "function" then
  ---@diagnostic disable-next-line: cast-local-type
  servers = servers()
end

---@diagnostic disable-next-line: param-type-mismatch
vim.iter(pairs(servers)):each(setup_ls)
