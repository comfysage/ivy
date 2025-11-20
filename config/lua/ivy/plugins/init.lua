return {
  {
    "evergarden",
    lazy = false,
    priority = 1200,
  },
  {
    "catppuccin",
    lazy = false,
    priority = 1000,
  },

  {
    "lylla.nvim",
    lazy = false,
  },

  {
    "tabby.nvim",
    event = "UIEnter",
  },

  {
    "fzf-lua",
    event = "UIEnter",
  },
  {
    "artio",
    lazy = false,
    deps = { "mini.icons" },
  },

  {
    "blink.indent",
    event = "UIEnter",
  },

  -- tree view
  {
    "neo-tree.nvim",
    event = "UIEnter",
    deps = { "nui" },
  },

  {
    "nvim-bqf",
    lazy = false,
  },

  {
    "mossy.nvim",
    event = "UIEnter",
    deps = { "nio" },
  },

  {
    "nvim-lint",
    event = "BufAdd",
  },

  {
    "fidget.nvim",
    event = "UIEnter",
  },

  -- completion
  {
    "blink.cmp",
    event = "UIEnter",
    deps = { "windsurf.nvim" },
  },

  {
    "windsurf.nvim",
    name = "windsurf.nvim",
    after = function()
      require("codeium").setup({
        enable_cmp_source = false,
      })
    end,
  },

  -- keymaps
  {
    "keymaps.nvim",
    lazy = false,
    priority = 1000,
    after = function()
      require("keymaps").setup()
    end,
  },

  {
    "marks.nvim",
    lazy = false,
  },

  {
    "shelf.nvim",
    lazy = false,
  },

  -- mini
  {
    "mini.ai",
    event = "BufAdd",
    after = function()
      require("mini.ai").setup({
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",

          -- Next/last variants
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
        },
      })
    end,
  },
  {
    "mini.align",
    event = "BufAdd",
    after = function()
      require("mini.align").setup()
    end,
  },
  {
    "mini.bracketed",
    event = "UIEnter",
    after = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "mini.diff",
    event = "BufAdd",
    after = function()
      require("mini.diff").setup({
        view = {
          style = "number",
          signs = {
            add = "│",
            change = "│",
            delete = "│",
            topdelete = "‾",
            changedelete = "~",
            untracked = "┆",
          },
        },
        delay = { text_change = 1000 },
        mappings = {
          -- Apply hunks inside a visual/operator region
          apply = "gh",

          -- Reset hunks inside a visual/operator region
          reset = "gH",

          -- Hunk range textobject to be used inside operator
          -- Works also in Visual mode if mapping differs from apply and reset
          textobject = "gh",

          -- Go to hunk range in corresponding direction
          goto_first = "[H",
          goto_prev = "[h",
          goto_next = "]h",
          goto_last = "]H",
        },
      })

      vim.keymap.set("n", "zd", function()
        require("mini.diff").toggle_overlay()
      end, { desc = "toggle diff overlay" })
    end,
  },
  {
    "mini.files",
    event = "UIEnter",
    after = function()
      require("mini.files").setup({
        options = {
          use_as_default_explorer = false,
        },
        windows = {
          -- Maximum number of windows to show side by side
          max_number = 3,
          -- Whether to show preview of file/directory under cursor
          preview = false,
          -- Width of focused window
          width_focus = 50,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 25,
        },
      })
      local keymaps = require("keymaps").setup()
      keymaps.normal["<space>sp"] = { require("mini.files").open, "Open Files", group = "UI" }
      keymaps.normal["-"] = {
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0))
        end,
      }
    end,
  },
  {
    "mini-git",
    event = "UIEnter",
    after = function()
      require("mini.git").setup()
    end,
  },
  {
    "mini.icons",
    lazy = false,
    priority = 1000,
    after = function()
      require("mini.icons").setup({
        filetype = {
          qmljs = { glyph = "󰫾", hl = "MiniIconsAzure" },
          tera = { glyph = "󰅩", hl = "MiniIconsOrange" },
          just = {
            glyph = "󰚩",
            hl = "MiniIconsOrange",
          },

          -- mini.nvim
          ["minideps-confirm"] = { glyph = "", hl = "MiniIconsOrange" },
          minifiles = { glyph = "󰙅", hl = "MiniIconsGreen" },
          ["minifiles-help"] = { glyph = "󰙅", hl = "MiniIconsGreen" },
          mininotify = { glyph = "", hl = "MiniIconsYellow" },
          ["mininotify-history"] = { glyph = "", hl = "MiniIconsYellow" },
          minipick = { glyph = "󱡠", hl = "MiniIconsCyan" },
          ministarter = { glyph = "", hl = "MiniIconsAzure" },

          -- plugins
          bufferlist = { glyph = "󱡠", hl = "MiniIconsAzure" }, -- shelf
        },
        file = {
          [".envrc"] = {
            glyph = "",
            hl = "MiniIconsYellow",
          },
          [".luacheckrc"] = "lua",
          [".Justfile"] = "justfile",
          [".justfile"] = "justfile",
          ["Justfile"] = "justfile",
          ["justfile"] = "justfile",
        },
        lsp = {
          color = { glyph = "󰏘" },
          constant = { glyph = "󰏿" },
          constructor = { glyph = "󰒓" },
          event = { glyph = "󱐋" },
          file = { glyph = "󰈚" },
          ["function"] = { glyph = "󰊕" },
          property = { glyph = "󰖷" },
          snippet = { glyph = "󱄽" },
          string = { glyph = "“" },
          value = { glyph = "󰦨" },
          variable = { glyph = "󰆦" },
        },
      })
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },
  {
    "mini.jump2d",
    event = "BufAdd",
    after = function()
      require("mini.jump2d").setup({
        view = {
          dim = true,
        },
      })
    end,
  },
  {
    "mini.move",
    event = "BufAdd",
    after = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = "<",
          right = ">",
          down = "<s-m-j>",
          up = "<s-m-k>",

          -- Move current line in Normal mode
          line_left = "",
          line_right = "",
          line_down = "<s-m-j>",
          line_up = "<s-m-k>",
        },

        -- Options which control moving behavior
        options = {
          -- Automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      })
    end,
  },
  {
    "mini.operators",
    event = "BufAdd",
    after = function()
      require("mini.operators").setup({
        exchange = { prefix = "Cx" },
        multiply = { prefix = "Cm" },
        replace = { prefix = "Cr" },
        sort = { prefix = "" },
      })
    end,
  },
  {
    "mini.pairs",
    event = "InsertEnter",
    after = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "mini.splitjoin",
    event = "BufAdd",
    after = function()
      require("mini.splitjoin").setup()
    end,
  },
  {
    "mini.surround",
    event = "InsertEnter",
    after = function()
      require("mini.surround").setup({
        mappings = {
          add = "S", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
          suffix_last = "", -- Suffix to search with "prev" method
          suffix_next = "", -- Suffix to search with "next" method
        },
      })
    end,
  },
  {
    "mini.trailspace",
    event = "BufAdd",
    after = function()
      require("mini.trailspace").setup({
        -- highlight only in normal buffers (ones with empty 'buftype'). this is
        -- useful to not show trailing whitespace where it usually doesn't matter.
        only_in_normal_buffers = true,
      })
    end,
  },

  -- lsp
  {
    "rainbow-delimiters.nvim",
    event = "UIEnter",
    before = function()
      vim.g.rainbow_delimiters = {
        blacklist = { "markdown", "markdown_inline", "help" },
      }
    end,
  },

  {
    "direnv.nvim",
    enabled = function()
      return vim.fn.executable("direnv") == 1
    end,
    after = function()
      require("direnv").setup({
        autoload_direnv = true,
      })
    end,
  },

  {
    "nivvie.nvim",
    lazy = false,
  },

  {
    "cord.nvim",
    name = "cord.nvim",
    lazy = false,
    after = function()
      require("cord").setup({
        editor = {
          tooltip = "the modal text editor of your nightmares",
        },
        display = {
          -- theme = "",
        },
        buttons = {
          {
            label = "View Repository",
            url = function(opts)
              return opts.repo_url
            end,
          },
        },
        hooks = {
          post_activity = function(_, activity)
            local version = vim.version()
            activity.assets.small_text = string.format("Neovim %s.%s.%s", version.major, version.minor, version.patch)
          end,
        },
      })
    end,
  },

  {
    "toggleterm.nvim",
    event = "UIEnter",
  },

  {
    "cloak.nvim",
    event = "BufReadPre",
  },

  {
    "zk-nvim",
    ft = "markdown",
  },

  {
    "vim-startuptime",
    lazy = false,
  },

  -- builtin
  { "nvim.difftool", lazy = false },
  { "nvim.undotree", event = "UIEnter" },

  -- dependencies
  { "nui.nvim" },
  { "nvim-nio" },
  { "yosu.nvim" },
}
