vim.g.lsp_config = {
  common = {},
  servers = function()
    return {
      astro = {},
      bashls = {},
      clangd = {},
      cssls = {},
      denols = {},
      dockerls = {},
      emmet_language_server = {},
      gopls = {},
      hls = {},
      html = {},
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      lua_ls = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
              },
            },
          })
        end,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            diagnostics = {
              globals = { "vim", "package", "table" },
            },
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
          },
        },
      },
      marksman = {},
      nil_ls = {},
      nushell = {},
      taplo = {},
      teal_ls = {},
      tinymist = {},
      ts_ls = {},
      tailwindcss = {},
      vue_ls = {},
      yamlls = {
        settings = {
          yaml = {
            schemas = vim.tbl_extend("keep", {
              ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
              ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
              "*lab-ci.{yaml,yml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
              "docker-compose.{yml,yaml}",
              ["https://goreleaser.com/static/schema.json"] = ".goreleaser.{yml,yaml}",
            }, require("schemastore").yaml.schemas()),
          },
        },
      },
      zk = {},
      zls = {},
    }
  end,
  on_attach = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil then
      return
    end

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end

    if client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup(string.format("lsp:document_highlight:%d", ev.buf), { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end,
        desc = "highlight lsp reference",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = group,
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
        desc = "clear lsp references",
      })
    end

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
}

local config_base = 'ivy.config'

local load_cfg = function(name)
  local mod = config_base .. '.' .. name
  local ok, result = pcall(require, mod)
  if not ok then
    return vim.notify('error loading ' .. mod .. ':\n\t' .. result, vim.log.levels.ERROR)
  end
  return result
end

vim.iter(ipairs({
  {'autocmds'},
  {'cmds', event = 'VimEnter'},
  {'ft'},
  {'keybinds', event = 'UIEnter'},
  {'lsp', event = { 'BufReadPre', 'BufNewFile' }},
  {'neovide', event = 'UIEnter'},
  {'options'},
})):each(function(_, opts)
  local name = opts[1]
  if not name then
    return
  end
  if opts.event then
    vim.api.nvim_create_autocmd(opts.event, {
      group = vim.api.nvim_create_augroup('ivy:' .. vim.inspect(opts.event) .. '[' .. name .. ']', { clear = true }),
      callback = function(_)
        load_cfg(name)
      end,
      once = true,
    })
    return
  end
  load_cfg(name)
end)

require("lz.n").load("ivy.plugins")

do
  local localpackdir = vim.fn.stdpath("data") .. "/site/pack/local/start"
  vim.opt.rtp:append(localpackdir)

  local ok, loom = pcall(require, "loom")
  if not ok then
    return
  end
  ---@diagnostic disable-next-line: missing-fields
  loom.setup({
    hlgroups = {
      "@loom.indent",
      "rainbow.1",
      "@loom.indent",
      "rainbow.2",
      "@loom.indent",
      "rainbow.3",
      "@loom.indent",
      "rainbow.4",
      "@loom.indent",
      "rainbow.5",
      "@loom.indent",
      "rainbow.6",
    },
  })
  local c = require("evergarden.colors").get()
  vim.api.nvim_set_hl(0, "@loom.indent", { fg = c.surface1 })
end

require("ivy.health").loaded = true
