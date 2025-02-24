return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "FloatBorder" })

      require("fzf-lua").setup({
        winopts = function(opts)
          opts = opts or {}
          local size = 30
          local preview_size = size / 2
          if opts.previewer == false then
            size = size / 2
          end
          local bottom_border = { vim.g.bc.horiz, vim.g.bc.horiz, vim.g.bc.horiz, "", "", "", "", "" }
          return {
            height = size,
            width = 1.0,
            col = 0,
            row = vim.o.lines - size - 1 - vim.o.cmdheight, -- offset to avoid covering statusline
            preview = {
              winopts = {
                cursorline = false,
              },
              layout = "vertical",
              vertical = "up:" .. preview_size,
              title_pos = "left",
            },
            backdrop = 100,
            border = bottom_border,
          }
        end,
        fzf_opts = {
          ["--layout"] = "reverse-list",
          ["--info"] = "inline-right",
          ["--no-separator"] = "",
        },
        file_icon_padding = " ",
        prompt = " ",
        previewer = "builtin",
        files = {
          cwd_prompt = false,
          previewer = false,
          git_icons = false,
        },
        grep_curbuf = {
          winopts = {
            treesitter = true,
          },
        },
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
          "%.git/",
          "%.webp",
          "%.dart_tool/",
          "%.gradle/",
          "%.idea/",
          "%.settings/",
          "%.vscode/",
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
          "%.vale/",
          "_sources/",
          "tmp/",
        },
      })

      require("fzf-lua").register_ui_select()

      local keymaps = require("keymaps").setup()
      keymaps.normal["<leader><leader>"] = {
        require("fzf-lua").files,
        "find files",
      }
      keymaps.normal["<leader>fr"] = { require("fzf-lua").live_grep, "grep through all files" }
      keymaps.normal["<leader>fs"] = { "<cmd>SessionManager load_session<cr>", "show nvim sessions" }
      keymaps.normal["<leader>fh"] = { require("fzf-lua").helptags, "search help tags" }
      keymaps.normal["<leader>fq"] = { require("fzf-lua").quickfix, "search quick fix list" }
      keymaps.normal["<leader>ft"] = {
        function()
          vim.cmd([[TodoFzfLua]])
        end,
        "live grep but for TODOs and FIXMEs",
      }
      keymaps.normal["<leader>fc"] = { require("fzf-lua").git_commits, "git commits" }
      keymaps.normal["<leader>f/"] = { require("fzf-lua").grep_curbuf, "fuzzy find in current buffer" }
    end,
  },
}
