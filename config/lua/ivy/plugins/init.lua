return {
  -- tree view
  {
    "nvim-tree.lua",
    after = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        diagnostics = { enable = true },
        renderer = {
          indent_markers = { enable = true },
          icons = { web_devicons = { folder = { enable = true } } },
        },
        modified = { enable = true },
      })

      local keymaps = require("keymaps").setup()
      keymaps.normal["<c-n>"] = {
        function()
          require("nvim-tree.api").tree.open()
        end,
        "open nvim tree",
      }

      vim.api.nvim_create_autocmd("WinEnter", {
        pattern = "NvimTree_*",
        group = vim.api.nvim_create_augroup("filetype:nvimtree:options", { clear = true }),
        callback = function(ev)
          vim.api.nvim_set_option_value("sidescrolloff", 0, { win = ev.win })
        end,
      })
    end,
  },

  -- keymaps
  {
    "keymaps.nvim",
    priority = 1000,
    after = function()
      require("keymaps").setup()

      keymaps.normal["<leader>fm"] = {
        function()
          require("telescope").extensions.keymaps_nvim.keymaps_nvim()
        end,
        "find keymaps",
      }
    end,
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
    "mini.animate",
    event = "UIEnter",
    after = function()
      require("mini.animate").setup()
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
          style = "sign",
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
    "mini.move",
    event = "BufAdd",
    after = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = "<",
          right = ">",
          down = "<M-j>",
          up = "<M-k>",

          -- Move current line in Normal mode
          line_left = "",
          line_right = "",
          line_down = "<M-j>",
          line_up = "<M-k>",
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
  { "rainbow-delimiters.nvim" },

  -- rust lsp + formmating
  {
    "rustaceanvim",
    ft = "rust",
  },

  {
    "lazydev.nvim",
    after = function()
      require("lazydev").setup()
    end,
  },

  -- add better undo history
  {
    "undotree",
    after = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },

  -- track my time coding
  {
    "vim-wakatime",
    enabled = function()
      return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
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

  -- discord integration
  {
    "cord.nvim",
    after = function()
      require("cord").setup({
        editor = { image = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp" },
        display = { swap_icons = true }, -- place the editor image as the main image
      })
    end,
  },
}
