return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    after = function()
      local theme = {
        { "default-title" },
        winopts = {
          row = 1,
          col = 0,
          width = 1,
          height = 0.4,
          backdrop = 100,
          title_pos = "left",
          border = { "", "─", "", "", "", "", "", "" },
          preview = {
            layout = "horizontal",
            title_pos = "right",
            border = function(_, m)
              if m.type == "fzf" then
                return "single"
              else
                assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string", "no border set")
                local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
                if m.layout == "down" then
                  b[1] = "├" --top right
                  b[3] = "┤" -- top left
                elseif m.layout == "up" then
                  b[7] = "├" -- bottom left
                  b[6] = "" -- remove bottom
                  b[5] = "┤" -- bottom right
                elseif m.layout == "left" then
                  b[3] = "┬" -- top right
                  b[5] = "┴" -- bottom right
                  b[6] = "" -- remove bottom
                else -- right
                  b[1] = "┬" -- top left
                  b[7] = "┴" -- bottom left
                  b[6] = "" -- remove bottom
                end
                return b
              end
            end,
          },
        },
      }

      local up = {
        row = 1,
        col = 0,
        width = 1,
        height = 1,
        preview = {
          layout = "vertical",
          vertical = "up:50%",
          border = "none",
        },
      }

      theme.blines = { winopts = up, previewer = { toggle_behavior = "extend" } }
      theme.lines = theme.blines
      theme.grep = theme.blines
      theme.grep_curbuf = theme.blines
      theme.git = { blame = { winopts = up } }

      local opts = {
        fzf_opts = {
          ["--layout"] = "reverse-list",
          ["--info"] = "inline-right",
          ["--no-separator"] = "",
          ["--padding"] = "0",
        },
        fzf_colors = true,
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
        keymaps = {
          previewer = false,
        },
        file_ignore_patterns = {
          "%.age",
          "%.cache",
          "%.class",
          "%.dart_tool/",
          "%.dll",
          "%.docx",
          "%.dylib",
          "%.exe",
          "%.git/",
          "%.gradle/",
          "%.ico",
          "%.idea/",
          "%.ipynb",
          "%.jar",
          "%.jpeg",
          "%.jpg",
          "%.lock",
          "%.luac",
          "%.met",
          "%.min.js",
          "%.npz",
          "%.otf",
          "%.pdb",
          "%.pdf",
          "%.png",
          "%.pyc",
          "%.settings/",
          "%.so",
          "%.sqlite3",
          "%.ttf",
          "%.vale/",
          "%.vscode/",
          "%.webp",
          ".direnv/",
          ".direnv/*",
          "__pycache__/",
          "__pycache__/*",
          "_sources/",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "node_modules/*",
          "smalljre_*/*",
          "target/",
          "tmp/",
          "vendor/*",
        },
      }

      require("fzf-lua").setup(vim.tbl_deep_extend("force", theme, opts))

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
