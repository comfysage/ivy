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
                cssls = {},
                dockerls = {},
                emmet_language_server = {
                  filetypes = {
                    "astro",
                    "css",
                    "eruby",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "less",
                    "sass",
                    "scss",
                    "pug",
                    "typescriptreact",
                  },
                },
                helm_ls = {},
                hls = {},
                html = {},
                intelephense = {},
                jqls = {},
                jsonls = {
                  settings = {
                    json = {
                      schemas = require("schemastore").json.schemas(),
                      validate = { enable = true },
                    },
                  },
                },
                marksman = {},
                nushell = {},
                serve_d = {},
                sourcekit = {},
                taplo = {},
                teal_ls = {},
                tailwindcss = {
                  filetypes = {
                    "astro",
                    "javascriptreact",
                    "typescriptreact",
                    "html",
                    "css",
                    "tera",
                  },
                },
                tinymist = {
                  settings = {
                    formatterMode = "typstyle",
                    exportPdf = "onDocumentHasTitle",
                  },
                },
                volar = {
                  capabilities = {
                    workspace = {
                      didChangeWatchedFiles = {
                        dynamicRegistration = true,
                      },
                    },
                  },
                  root_markers = { "package.json" },
                },
                yamlls = {
                  settings = {
                    yaml = {
                      completion = true,
                      validate = true,
                      suggest = {
                        parentSkeletonSelectedFirst = true,
                      },
                      schemas = vim.tbl_extend("keep", {
                        ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
                        ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
                        ["https://json.schemastore.org/helmfile"] = "helmfile.{yaml,yml}",
                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
                        ["https://goreleaser.com/static/schema.json"] = ".goreleaser.{yml,yaml}",
                      }, require("schemastore").yaml.schemas()),
                    },
                    redhat = {
                      telemetry = {
                        enabled = false,
                      },
                    },
                  },
                },
              }
            end,
            on_attach = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)

              if client == nil then
                return
              end

              local navic_present, navic = pcall(require, "nvim-navic")

              if navic_present and client.server_capabilities.documentSymbolProvider then
                navic.attach(client, ev.buf)
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
              local function use_border(cb)
                return function()
                  cb({ border = vim.g.bc.style })
                end
              end
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "K", use_border(vim.lsp.buf.hover), opts)
              vim.keymap.set("i", "<C-k>", use_border(vim.lsp.buf.signature_help), opts)
              vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
              vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
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
