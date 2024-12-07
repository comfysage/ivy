return {
  -- we set these to lazy as we use another plugin to load them
  { "telescope-project.nvim", lazy = false },
  { "telescope-fzf-native.nvim", lazy = false },
  { "telescope-ui-select.nvim", lazy = false },

  {
    "telescope.nvim",
    event = "DeferredUIEnter",
    after = function()
      -- so quircky but we need to load this before telescope
      local exts = {
        "project",
        "ui-select",
        "fzf-native",
      }

      -- trigger the load of all the extensions we use
      for _, ext in ipairs(exts) do
        require("lz.n").trigger_load({ "telescope-" .. ext .. ".nvim" })
      end

      local bc = vim.g.bc

      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")

      local M = {}

      ---@alias TelescopeStyle 'dropdown'|'bottom'|'main'

      ---@type { [TelescopeStyle]: table }
      M.style = {}

      M.style.dropdown = {
        theme = "dropdown",
        borderchars = {
          { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
          prompt = { bc.horiz, bc.vert, " ", bc.vert, bc.topleft, bc.topright, bc.vert, bc.vert },
          results = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.vertright, bc.vertleft, bc.botright, bc.botleft },
          preview = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
        },
        layout_config = {
          width = function(_, max_columns, _)
            return math.min(max_columns, 80)
          end,
          height = function(_, _, max_lines)
            return math.min(max_lines, 12)
          end,
        },
        results_title = false,
        sorting_strategy = "ascending",
        previewer = false,
      }

      M.style.bottom = themes.get_ivy({
        theme = "bottom",
        -- border = true,
        preview = true,
        shorten_path = true,
        hidden = true,
        prompt_title = "",
        preview_title = "",
        borderchars = {
          preview = { " ", " ", " ", " ", " ", " ", " ", " " },
        },
      })

      M.style.main = {
        theme = "main",
        -- winblend = 20;
        layout_config = {
          width = function(_, max_columns, _)
            return math.min(math.floor(max_columns * 0.8), 160)
          end,
          height = function(_, _, max_lines)
            return math.floor(max_lines * 0.9)
          end,
        },
        show_line = false,
        results_title = "",
        prompt_prefix = "$ ",
        prompt_position = "top",
        prompt_title = "",
        preview_title = "",
        preview_width = 0.4,
      }

      ---@param name TelescopeStyle
      ---@param opts table
      ---@return table
      M.get_style = function(name, opts)
        opts = opts or {}
        local style = M.style[name]
        return vim.tbl_deep_extend("force", style or {}, opts)
      end

      local theme = "dropdown"

      local create_theme = function(opts)
        return M.get_style(theme, opts)
      end

      local project_actions = require("telescope._extensions.project.actions")
      local telescope = require("telescope")

      telescope.load_extension("fzf")
      telescope.load_extension("project")
      telescope.load_extension("ui-select")

      telescope.load_extension("keymaps_nvim")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          multi_icon = "│",
          file_ignore_patterns = {
            "%.npz",
            "%.pyc",
            "%.luac",
            "%.ipynb",
            "vendor/*",
            "%.lock",
            "__pycache__/*",
            "%.sqlite3",
            "%.ipynb",
            "node_modules/*",
            "%.min.js",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.age",
            "%.svg",
            "%.otf",
            "%.ttf",
            "\\.git/",
            "%.webp",
            "\\.dart_tool/",
            "\\.gradle/",
            "\\.idea/",
            "\\.settings/",
            "\\.vscode/",
            "__pycache__/",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "target/",
            "%.pdb",
            "%.dll",
            "%.class",
            "%.exe",
            "%.so",
            "%.cache",
            "%.ico",
            "%.pdf",
            "%.dylib",
            "%.jar",
            "%.docx",
            "%.met",
            "smalljre_*/*",
            "\\.vale/",
            "_sources/",
            "tmp/",
          },
          borderchars = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
        },
        pickers = {
          find_files = create_theme(),
          live_grep = create_theme({
            previewer = true,
          }),
          load_session = create_theme(),
        },
        extensions = {
          ["ui-select"] = create_theme(),
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          project = {
            search_by = { "path", "title" },
            hidden_files = true, -- default: false
            sync_with_nvim_tree = true, -- default false
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
            end,
          },
        },
      })

      local keymaps = require("keymaps").setup({})
      keymaps.normal["<leader><leader>"] = { builtin.find_files, "find files" }
      keymaps.normal["<leader>fr"] = { builtin.live_grep, "grep through all files" }
      keymaps.normal["<leader>fs"] = { "<cmd>SessionManager load_session<cr>", "show nvim sessions" }
      keymaps.normal["<leader>fh"] = { builtin.help_tags, "search help tags" }
      keymaps.normal["<leader>fp"] = { require("telescope").extensions.project.project, "skip to project" }
      keymaps.normal["<leader>ft"] = { "<cmd>TodoTelescope<cr>", "live grep but for TODOs and FIXMEs" }
      keymaps.normal["<leader>fc"] = { builtin.git_commits, "git commits" }
      keymaps.normal["<leader>f/"] = { builtin.current_buffer_fuzzy_find, "fuzzy find in current buffer" }
    end,
  },
}
