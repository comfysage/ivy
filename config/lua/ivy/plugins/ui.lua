return {

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
