return {
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu" })
          vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = pmenu.bg })
        end,
      })
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
}
