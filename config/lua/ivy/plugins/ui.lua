return {
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local winbar = {
        lualine_c = {
          {
            function()
              return "▌"
            end,
            color = "MiniIconsAzure",
          },
          { "filename", path = 1 },
          "searchcount",
        },
      }

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "ministarter" },
            winbar = {},
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 300,
            tabline = 500,
            winbar = 500,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "filename", path = 1 },
            "diff",
            "searchcount",
          },
          lualine_x = {
            {
              function()
                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local result = vim.iter(vim.lsp.get_clients({ bufnr = 0 })):find(function(
                  client --[[@as vim.lsp.Client]]
                )
                  return client.config.name ~= "null-ls"
                    and vim.iter(ipairs(client.config.filetypes)):any(function(_, ft)
                      return ft == buf_ft
                    end)
                end)
                if result then
                  return result.config.name
                end
              end,
              draw_empty = false,
              icon = "lsp ::",
            },
            "diagnostics",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },

  {
    "tabby.nvim",
    event = "DeferredUIEnter",
    after = function()
      local left_sep = ""
      local right_sep = ""

      local C = require("evergarden.colors").get()
      local tab_hl = "TabLine"
      local cur_hl = "TabLineSel"
      local o = {
        theme = {
          fill = { fg = C.overlay0 },
          head = tab_hl,
          current_tab = cur_hl,
          tab = tab_hl,
          current_win = cur_hl,
          win = tab_hl,
          tail = tab_hl,
        },
      }

      local function preset_tab(line, tab, opt)
        local hl = tab.is_current() and opt.theme.current_tab or opt.theme.tab
        return {
          line.sep(left_sep, hl, opt.theme.fill),
          tab.in_jump_mode() and tab.jump_key() or {
            tab.number(),
            margin = " ",
          },
          line.sep(right_sep, hl, opt.theme.fill),
          hl = hl,
          margin = " ",
        }
      end

      local function preset_win(line, tab, win, opt)
        local hl = (tab.is_current() and win.is_current()) and opt.theme.current_win or opt.theme.win
        return {
          line.sep(left_sep, hl, opt.theme.fill),
          win.buf_name(),
          line.sep(right_sep, hl, opt.theme.fill),
          hl = hl,
          margin = " ",
        }
      end
      require("tabby").setup({
        line = function(line)
          return {
            line.tabs().foreach(function(tab)
              return {
                preset_tab(line, tab, o),
                tab.wins().foreach(function(win)
                  return preset_win(line, tab, win, o)
                end),
              }
            end),
            hl = o.theme.fill,
          }
        end,
      })
    end,
  },

  {
    "fidget.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("fidget").setup({
        notification = {
          override_vim_notify = true,
          view = { group_separator_hl = "MsgSeparator" },
          window = { normal_hl = "MsgArea", winblend = 100 },
        },
        progress = {
          display = {
            done_icon = "",
            progress_icon = { pattern = "dots", period = 1 },
          },
          ignore = {
            "null-ls",
          },
        },
      })
    end,
  },

  {
    "nvim-colorizer.lua",
    event = "DeferredUIEnter",
    after = function()
      require("colorizer").setup({
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = false,
          rgb_fn = false,
          hsl_fn = false,
          css = false,
          css_fn = false,
          mode = "background",
          tailwind = "both",
          sass = {
            enable = true,
            parsers = { css = true },
          },
          virtualtext = " ",
        },

        buftypes = {
          "*",
          "!dashboard",
          "!lazy",
          "!popup",
          "!prompt",
        },
      })
    end,
  },

  -- highlight TODO, FIXME, etc.
  {
    "todo-comments.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("todo-comments").setup()
    end,
  },

  -- dependencies
  { "yosu.nvim" },
}
