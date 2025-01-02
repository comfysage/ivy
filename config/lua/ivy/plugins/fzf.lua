return {
  {
    "fzf-lua",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_set_hl(0, 'FzfLuaBorder', {link = 'FloatBorder'})
      local M = {}
      M.style = {}

      M.style.dropdown = {
        winopts_fn = function()
          return {
            width = math.min(vim.o.columns, 80),
            height = math.min(vim.o.lines, 12),
            border = vim.g.bc_all,
          }
        end,
        previewer = false,
      }

      M.style.bottom = {
        winopts_fn = function()
          return {
            split = "botright 28new", -- open in a full-width split on the bottom
            preview = {
              layout = "vertical",
              vertical = "up:60%",
              title_pos = "left",
            },
          }
        end,
        fzf_opts = {
          ['--layout'] = 'reverse-list',
          ['--info'] = 'inline-right',
          ['--no-separator'] = '',
        }
      }

      M.style.main = {
        winopts_fn = function()
          return {
            width = math.min(math.floor(vim.o.columns * 0.8), 160),
            height = math.floor(vim.o.lines * 0.9),
            border = vim.g.bc_all,
          }
        end,
      }

      ---@param name string
      ---@param opts table
      ---@return table
      M.get_style = function(name, opts)
        opts = opts or {}
        local style = M.style[name]
        return vim.tbl_deep_extend("force", style or {}, opts)
      end

      M.theme = "bottom"

      local create_theme = function(opts)
        return M.get_style(M.theme, opts)
      end

      require("fzf-lua").setup(create_theme({
        winopts = {
          backdrop = 100,
          preview = {
            winopts = {
              cursorline = false,
            },
          },
        },
        file_icon_padding = " ",
        prompt = " ",
        previewer = 'builtin',
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
      }))

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
