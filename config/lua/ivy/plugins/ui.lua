return {
  {
    "lualine.nvim",
    after = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
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
        winbar = {
          lualine_c = { "navic" },
          lualine_x = {
            {
              function()
                return "  "
              end,
              cond = function()
                local present, navic = pcall(require, "nvim-navic")
                if not present then
                  return false
                end
                return navic.is_available()
              end,
            },
          },
        },
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },

  {
    "fidget.nvim",
    after = function()
      require("fidget").setup({
        notification = {
          override_vim_notify = true,
          view = { group_separator_hl = "MsgSeparator" },
          window = { normal_hl = "NonText", winblend = 0 },
        },
        progress = {
          display = {
            done_icon = "",
            progress_icon = { pattern = "dots", period = 1 },
          },
          ignore = {
            "copilot",
            "null-ls",
          },
        },
      })
    end,
  },

  {
    "indent-blankline.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("ibl").setup({
        scope = { enabled = false },
        indent = {
          highlight = {
            "IblIndent",
            "RainbowRed",
            "IblIndent",
            "RainbowOrange",
            "IblIndent",
            "RainbowYellow",
            "IblIndent",
            "RainbowGreen",
            "IblIndent",
            "RainbowAqua",
            "IblIndent",
            "RainbowBlue",
            "IblIndent",
            "RainbowPurple",
          },
        },
        exclude = {
          filetypes = {
            "alpha",
            "fugitive",
            "help",
            "lazy",
            "NvimTree",
            "ToggleTerm",
            "LazyGit",
            "prompt",
            "code-action-menu-menu",
            "code-action-menu-warning-message",
            "Trouble",
          },
        },
      })
    end,
  },

  {
    "nvim-web-devicons",
    priority = 100,
    after = function()
      local ctp_present, ctp_pallets = pcall(require, "catppuccin.palettes")

      if ctp_present then
        local C = ctp_pallets.get_palette()

        local justfile = {
          icon = "󱚣",
          name = "Justfile",
          color = C.peach,
        }

        require("nvim-web-devicons").setup({
          override_by_filename = {
            [".ecrc"] = {
              icon = "",
              name = "EditorConfigChecker",
              color = C.green,
            },
            [".envrc"] = {
              icon = "",
              name = "envrc",
              color = C.yellow,
            },
            [".editorconfig"] = {
              icon = "",
              name = "EditorConfig",
              color = C.green,
            },
            [".luacheckrc"] = {
              icon = "󰢱",
              name = "LuacheckRC",
              color = C.blue,
            },
            [".Justfile"] = justfile,
            [".justfile"] = justfile,
            ["Justfile"] = justfile,
            ["justfile"] = justfile,
          },
        })
      else
        require("nvim-web-devicons").setup()
      end
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

  {
    "which-key.nvim",
    priority = 1000,
    after = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "find" },
      })
    end,
  },
}
