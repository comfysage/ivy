return {
  {
    "mossy.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("mossy").setup()
      local sources = require("mossy.sources")
      sources:setup({
        "treefmt",
        "clang-format",
        "nixfmt",
        "shfmt",
        "stylua",
      })
      ---@diagnostic disable-next-line: missing-fields
      sources:add("stylua"):with({
        filetypes = { "lua" },
      })
      ---@diagnostic disable-next-line: missing-fields
      sources:add("prettier"):with({
        filetypes = { "html", "markdown", "astro", "vue" },
      })
      vim.keymap.set("n", "<localleader>mf", require("mossy").format)
    end,
  },
  {
    "none-ls.nvim",
    event = "DeferredUIEnter",
    after = function()
      local null_present, null = pcall(require, "null-ls")

      if not null_present then
        return
      end

      local sources = {
        null.builtins.diagnostics.statix,
        null.builtins.diagnostics.deadnix,
        null.builtins.diagnostics.selene,

        -- docs
        null.builtins.diagnostics.proselint,
      }

      null.setup({
        sources = sources,
      })

      vim.api.nvim_create_user_command("NullToggle", function(ev)
        if not ev.args or #ev.args ~= 1 or not ev.args[1] then
          return
        end
        local method_name = string.upper(ev.args[1])
        local ok, nll = pcall(require, "null-ls")

        if not ok then
          return
        end
        local method = null.methods[method_name]
        if method then
          nll.toggle({ methods = method })
        end
      end, {
        nargs = 1,
        complete = function(_, _, _)
          local ok, nll = pcall(require, "null-ls")

          if not ok then
            return
          end
          local methods = vim
            .iter(pairs(nll.methods))
            :map(function(k, _)
              return string.lower(k)
            end)
            :totable()
          return methods
        end,
      })
    end,
  },

  { "lsp-status.nvim" },
  { "schemastore.nvim" },

  {
    "nvim-lspconfig",
    event = "DeferredUIEnter",
    after = function()
      require("lz.n").trigger_load({
        "blink.cmp",
        "lsp-status.nvim",
        "schemastore.nvim",
      })

      local lsp_present, lspconfig = pcall(require, "lspconfig")
      local navic_present, navic = pcall(require, "nvim-navic")

      if not lsp_present then
        vim.notify("lspnot present", vim.log.levels.ERROR)
        return
      end

      -- border style
      require("lspconfig.ui.windows").default_options.border = vim.g.bc.style

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          if client == nil then
            return
          end

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
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

      local common = { capabilities = capabilities }

      local servers = {
        astro = {},
        bashls = {},
        cssls = {},
        denols = {
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          single_file_support = false,
          settings = {
            deno = {
              inlayHints = {
                parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enable = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },
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
        gopls = {
          single_file_support = true,
          filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
          cmd = {
            "gopls", -- share the gopls instance if there is one already
            "-remote.debug=:0",
          },
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = "Fuzzy",
              diagnosticsDelay = "500ms",
              symbolMatcher = "fuzzy",
              semanticTokens = true,
              gofumpt = true,
            },
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
        lua_ls = {
          settings = {
            Lua = {
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
        nil_ls = {
          autostart = true,
          cmd = { "nil" },
          settings = {
            ["nil"] = {
              formatting = {
                command = { "nixfmt" },
              },
              nix = { maxMemoryMB = nil },
            },
          },
        },
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
          root_dir = require("lspconfig.util").root_pattern("package.json"),
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

      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_extend("force", common, config))
      end
    end,
  },

  {
    "crates.nvim",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "quill.nvim",
    after = function()
      -- require("quill").setup()
    end,
  },
  {
    "symbol-usage.nvim",
    after = function()
      local SymbolKind = vim.lsp.protocol.SymbolKind

      ---@diagnostic disable-next-line: missing-fields
      require("symbol-usage").setup({
        hl = { link = "LspInlayHint" },
        ---@type lsp.SymbolKind[] Symbol kinds what need to be count (see `lsp.SymbolKind`)
        kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Constant },
        ---@type 'above'|'end_of_line'|'textwidth'|'signcolumn' `above` by default
        vt_position = "end_of_line",
        -- Recommended to use with `above` vt_position to avoid "jumping lines"
        ---@type string|table|false
        request_pending_text = false, -- "loading...",
      })
    end,
  },
}
