return {
  -- tree view
  {
    "neo-tree.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lz.n").trigger_load("nui.nvim")
      require("neo-tree").setup({
        popup_border_style = "", -- use 'winborder'
        filesystem = {
          use_libuv_file_watcher = true,
        },
        default_component_configs = {
          icon = {
            provider = function(icon, node) -- setup a custom icon provider
              local text, hl
              local mini_icons = require("mini.icons")
              if node.type == "file" then -- if it's a file, set the text/hl
                text, hl = mini_icons.get("file", node.name)
              elseif node.type == "directory" then -- get directory icons
                text, hl = mini_icons.get("directory", node.name)
                -- only set the icon text if it is not expanded
                if node:is_expanded() then
                  text = nil
                end
              end

              -- set the icon text/highlight only if it exists
              if text then
                icon.text = text
              end
              if hl then
                icon.highlight = hl
              end
            end,
          },
          kind_icon = {
            provider = function(icon, node)
              local mini_icons = require("mini.icons")
              icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
            end,
          },
        },
      })
      local keymaps = require("keymaps").setup()
      keymaps.normal["<space>n"] = { "<cmd>Neotree<cr>", "open tree view" }

      vim.api.nvim_create_autocmd("WinEnter", {
        pattern = "neo-tree *",
        group = vim.api.nvim_create_augroup("filetype:neo-tree:options", { clear = true }),
        callback = function(ev)
          vim.api.nvim_set_option_value("sidescrolloff", 0, { win = ev.win })
        end,
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
    "markit.nvim",
    event = "UIEnter",
    after = function()
      require("markit").setup({
        -- whether to map keybinds or not. default true
        default_mappings = false,
        mappings = {
          set = "m", -- Sets a letter mark (will wait for input).
          set_next = "m,", -- Set next available lowercase mark at cursor.
          toggle = "m;", -- Toggle next available mark at cursor.
          toggle_mark = "M", -- Toggle a mark at the current line.
          next = "]m", -- Goes to next mark in buffer.
          prev = "[m", -- Goes to previous mark in buffer.

          preview = "m:", -- Previews mark (will wait for user input). press <cr> to just preview the next mark.
          annotate = "m<cr>", -- Prompts the user for a virtual line annotation that is then placed above the bookmark. Requires neovim 0.6+ and is not mapped by default.

          delete = "dm", -- Delete a letter mark (will wait for input).
          delete_line = "dm-", -- Deletes all marks on current line.
          delete_buf = "dm<space>", -- Deletes all marks in current buffer.

          -- set_bookmark[0-9] = "m", -- Sets a bookmark from group[0-9].
          -- delete_bookmark[0-9] = "dm", -- Deletes all bookmarks from group[0-9].
          -- delete_bookmark = "dm=", -- Deletes the bookmark under the cursor.
          -- next_bookmark = "}m", -- Moves to the next bookmark having the same type as the bookmark under the cursor.
          -- prev_bookmark = "{m", -- Moves to the previous bookmark having the same type as the bookmark under the cursor.
          -- next_bookmark[0-9] = "", -- Moves to the next bookmark of the same group type. Works by first going according to line number, and then according to buffer number.
          -- prev_bookmark[0-9] = "", -- Moves to the previous bookmark of the same group type. Works by first going according to line number, and then according to buffer number.
        },
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher value means better performance but may cause visual lag,
        -- while lower value may cause performance penalties. default 150.
        refresh_interval = 150,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {
          "nofile",
        },
      })
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
    "mini.icons",
    lazy = false,
    priority = 1000,
    after = function()
      local justfile = {
        glyph = "󰚩",
        hl = "MiniIconsOrange",
      }
      require("mini.icons").setup({
        extension = {
          tera = { glyph = "󰅩", hl = "MiniIconsOrange" },
        },
        file = {
          [".ecrc"] = {
            glyph = "",
            hl = "MiniIconsGreen",
          },
          [".envrc"] = {
            glyph = "",
            hl = "MiniIconsYellow",
          },
          [".editorconfig"] = {
            glyph = "",
            hl = "MiniIconsGreen",
          },
          [".luacheckrc"] = {
            glyph = "󰢱",
            hl = "MiniIconsBlue",
          },
          [".Justfile"] = justfile,
          [".justfile"] = justfile,
          ["Justfile"] = justfile,
          ["justfile"] = justfile,
        },
        lsp = {
          color = { glyph = "󰏘" },
          constant = { glyph = "󰏿" },
          constructor = { glyph = "󰒓" },
          event = { glyph = "󱐋" },
          file = { glyph = '󰈚' },
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
  { "rainbow-delimiters.nvim" },

  -- rust lsp + formmating
  {
    "rustaceanvim",
    ft = "rust",
  },

  -- add better undo history
  {
    "undotree",
    event = "BufReadPost",
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

  {
    "hunk.nvim",
    cmd = { "DiffEditor" },
    after = function()
      require("lz.n").trigger_load("nui.nvim")

      require("hunk").setup()
    end,
  },

  {
    "nui.nvim",
  },

  {
    "nvim-nio",
  },
}
