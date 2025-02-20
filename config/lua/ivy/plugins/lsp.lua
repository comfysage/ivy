return {
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function()
      local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = pmenu.bg })
      local ok, result = pcall(require("blink.cmp").setup, {
        cmdline = {
          -- By default, we choose providers for the cmdline based on the current cmdtype
          -- You may disable cmdline completions by replacing this with an empty table
          sources = {
            default = function()
              local type = vim.fn.getcmdtype()
              -- Search forward and backward
              if type == "/" or type == "?" then
                return { "buffer", "lsp" }
              end
              -- Commands
              if type == ":" then
                return { "cmdline" }
              end
              return {}
            end,
          },
        },
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = {
          ["<c-space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
          ["<C-e>"] = { "hide" },

          ["<tab>"] = {
            "select_and_accept",
            "snippet_forward",
            "fallback",
          },
          ["<s-tab>"] = { "snippet_backward", "fallback" },
          ["<down>"] = { "select_next", "fallback" },
          ["<up>"] = { "select_prev", "fallback" },

          ["<c-j>"] = { "scroll_documentation_down", "fallback" },
          ["<c-k>"] = { "scroll_documentation_up", "fallback" },
        },

        appearance = {},

        completion = {
          list = {
            cycle = {
              from_top = false,
              from_bottom = false,
            },
          },

          menu = {
            min_width = vim.o.pumwidth,
            max_height = vim.o.pumheight,
            scrolloff = 0,
            border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },

            draw = {
              -- align_to = "label", -- or 'none' to disable, or 'cursor' to align to the cursor
              padding = 1,
              gap = 1,
              treesitter = { "buffer", "lsp" },
              columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
              components = {
                source_name = {
                  width = { max = 30 },
                  text = function(ctx)
                    return string.format("(%s)", ctx.source_name)
                  end,
                  highlight = "BlinkCmpSource",
                },
                kind_icon = {
                  text = function(ctx)
                    if ctx.kind == "Color" then
                      ctx.kind_icon = "󱓻"
                    end
                    return ctx.kind_icon .. ctx.icon_gap
                  end,
                },
              },
            },
          },

          ghost_text = {
            enabled = true,
          },
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },

          transform_items = function(_, items)
            return vim
              .iter(ipairs(items))
              :map(function(_, item)
                if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                  item.score_offset = item.score_offset + 1
                end
                return item
              end)
              :totable()
          end,
          min_keyword_length = function()
            local default = 1
            return vim.bo.filetype == "markdown" and 2 or default
          end,
        },

        -- experimental signature help support
        signature = {
          enabled = true,
        },

        fuzzy = {
          max_typos = function(_)
            return 0
          end,
          -- frecency tracks the most recently/frequently used items and boosts the score of the item
          use_frecency = false,
          -- proximity bonus boosts the score of items matching nearby words
          use_proximity = true,

          prebuilt_binaries = {
            download = false,
          },
        },
      })
      if not ok then
        vim.notify("error configuring blink.cmp:\n\t" .. result, vim.log.levels.ERROR)
        return
      end
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
        -- general
        null.builtins.formatting.treefmt.with({
          condition = function(utils)
            return utils.root_has_file("treefmt.toml")
          end,
        }),

        -- nix
        null.builtins.formatting.nixfmt,
        null.builtins.diagnostics.statix,
        null.builtins.diagnostics.deadnix,

        -- go
        null.builtins.formatting.gofumpt,

        -- webdev
        null.builtins.formatting.prettier.with({
          filetypes = {
            "html",
            "astro",
            "vue",
          },
        }),

        -- shell
        null.builtins.formatting.shfmt,

        -- lua
        null.builtins.formatting.stylua,
        null.builtins.diagnostics.selene,

        -- docs
        null.builtins.diagnostics.proselint,
      }

      null.setup({
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup(("null:formatting:%d"):format(bufnr), { clear = true }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  filter = function(c)
                    return c.name == "null-ls"
                  end,
                })
              end,
            })
          end
        end,
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

  {
    "nvim-lspconfig",
    event = "DeferredUIEnter",
    after = function()
      local plugins = {
        { "blink.cmp" },
        { "lsp-status.nvim" },
        { "schemastore.nvim" },
        { "py_lsp.nvim" },
        { "typescript-tools.nvim" },
        { "go.nvim" },
      }
      require("lz.n").load(plugins)

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

      -- setup python
      pcall(require("py_lsp").setup, common)

      require("typescript-tools").setup({
        single_file_support = false,
        root_dir = function(fname)
          local root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json")(fname)

          -- this is needed to make sure we don't pick up root_dir inside node_modules
          local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
          if node_modules_index and node_modules_index > 0 then
            ---@diagnostic disable-next-line: need-check-nil
            root_dir = root_dir:sub(1, node_modules_index - 2)
          end

          return root_dir
        end,
        settings = {
          expose_as_code_action = {
            "add_missing_imports",
            "fix_all",
            "remove_unused",
          },
          tsserver_path = vim.fn.resolve(
            vim.fn.exepath("tsserver") .. "/../../lib/node_modules/typescript/bin/tsserver"
          ),
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      local go_present, go_lsp = pcall(require, "go.lsp")
      local go_config = go_present
          and (function()
            local ok, config = pcall(go_lsp.config)
            if ok then
              return config
            end
            return {}
          end)()
        or {}

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
        gopls = go_config,
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
    "go.nvim",
    ft = {
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gohtmltmpl",
      "gotexttmpl",
    },
    after = function()
      require("go").setup({
        disable_defaults = false,
        icons = {
          breakpoint = " ",
          currentpos = " ",
        },
        trouble = true,
        luasnip = true,
        dap_debug_keymap = false,
        lsp_cfg = false,
        lsp_keymaps = false,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
        },
      })
    end,
  },
  { "guihua.lua" },
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
