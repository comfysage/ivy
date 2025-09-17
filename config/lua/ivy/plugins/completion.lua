return {
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function()
      local ok, icons = pcall(require, "mini.icons")
      if not ok then
        vim.notify("could not find `mini.icons` module", vim.log.leves.WARN)
      end

      require("lz.n").trigger_load({ "windsurf.nvim" })

      local keymap = {
        preset = "none",
        ["<c-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },

        ["<tab>"] = {
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<down>"] = { "select_next", "fallback" },
        ["<up>"] = { "select_prev", "fallback" },

        ["<c-b>"] = { "scroll_documentation_up", "fallback" },
        ["<c-f>"] = { "scroll_documentation_down", "fallback" },
      }

      local ok, result = pcall(require("blink.cmp").setup, {
        cmdline = {
          enabled = true,
          completion = {
            menu = {
              auto_show = true,
            },
            list = {
              selection = {
                preselect = false,
              },
            },
          },
          keymap = keymap,
          -- By default, we choose providers for the cmdline based on the current cmdtype
          -- You may disable cmdline completions by replacing this with an empty table
          sources = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == "/" or type == "?" then
              return { "buffer", "lsp" }
            end
            -- Commands
            if type == ":" then
              return { "cmdline", "path" }
            end
            return {}
          end,
        },
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = keymap,

        appearance = {
          kind_icons = {
            Class = icons.get("lsp", "class"),
            Color = icons.get("lsp", "color"),
            Constant = icons.get("lsp", "constant"),
            Constructor = icons.get("lsp", "constructor"),
            Enum = icons.get("lsp", "enum"),
            EnumMember = icons.get("lsp", "enummember"),
            Event = icons.get("lsp", "event"),
            Field = icons.get("lsp", "field"),
            File = icons.get("lsp", "file"),
            Folder = icons.get("lsp", "folder"),
            Function = icons.get("lsp", "function"),
            Interface = icons.get("lsp", "interface"),
            Keyword = icons.get("lsp", "keyword"),
            Method = icons.get("lsp", "method"),
            Module = icons.get("lsp", "module"),
            Operator = icons.get("lsp", "operator"),
            Property = icons.get("lsp", "property"),
            Reference = icons.get("lsp", "reference"),
            Snippet = icons.get("lsp", "snippet"),
            Struct = icons.get("lsp", "struct"),
            Text = icons.get("lsp", "text"),
            TypeParameter = icons.get("lsp", "typeparameter"),
            Unit = icons.get("lsp", "unit"),
            Value = icons.get("lsp", "value"),
            Variable = icons.get("lsp", "variable"),
          },
        },

        completion = {
          trigger = {
            show_on_keyword = true,
          },

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
            border = "none",

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
                  highlight = function(ctx)
                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                    return hl
                  end,
                },
                kind = {
                  highlight = function(ctx)
                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                    return hl
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
          default = { "lsp", "path", "snippets", "buffer", "windsurf" },

          per_filetype = {
            minifiles = { "path", "buffer" },
          },

          providers = {
            windsurf = {
              name = "windsurf",
              module = "codeium.blink",
              async = true,
              max_items = 2,
            },
          },

          transform_items = function(_, items)
            return vim
              .iter(ipairs(items))
              :map(function(_, item)
                if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                  item.score_offset = item.score_offset + 1
                end
                if item.source == "windsurf" then
                  item.score_offset = item.score_offset + 2
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
          enabled = false,
        },

        fuzzy = {
          max_typos = function(_)
            return 0
          end,
          -- frecency tracks the most recently/frequently used items and boosts the score of the item
          frecency = {
            enabled = false,
          },
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

  -- sources
  {
    "windsurf.nvim",
    after = function()
      require("codeium").setup({
        enable_cmp_source = false,
      })
    end,
  },
}
