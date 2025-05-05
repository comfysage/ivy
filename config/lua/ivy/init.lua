require("ivy.config.disable")

require("lz.n").load({
  "chai.nvim",
  lazy = false,
  after = function()
    require("chai").setup({
      custom_module = "ivy.config",
    })
    require("chai.parts")
      :new({
        {
          "ivy.config.options",
        },
        {
          "ivy.config.autocmds",
        },
        {
          "ivy.config.ft",
        },
        {
          "ivy.config.keybinds",
        },
        {
          "ivy.config.lsp",
          opts = {
            common = function()
              require("lz.n").trigger_load({
                "blink.cmp",
                "lsp-status.nvim",
                "schemastore.nvim",
              })
              local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

              return { capabilities = capabilities }
            end,
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
                  settings = {
                    Lua = {
                      runtime = {
                        version = 'LuaJIT',
                      },
                      workspace = {
                        checkThirdParty = false,
                        library = {
                          vim.env.VIMRUNTIME
                          -- Depending on the usage, you might want to add additional paths here.
                          -- "${3rd}/luv/library"
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
                ols = {},
                taplo = {},
                teal_ls = {},
                tinymist = {},
                ts_ls = {},
                tailwindcss = {},
                volar = {},
                yamlls = {
                  settings = {
                    yaml = {
                      schemas = vim.tbl_extend("keep", {
                        ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
                        ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
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
                local group =
                  vim.api.nvim_create_augroup(string.format("lsp:document_highlight:%d", ev.buf), { clear = true })
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
              vim.keymap.set("n", "<localleader>f", function()
                vim.lsp.buf.format({ async = true })
              end, opts)
            end,
          },
        },
      })
      :setup()
  end,
})
require("lz.n").load("ivy.plugins")

require("ivy.health").loaded = true
