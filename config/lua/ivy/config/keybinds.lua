---@diagnostic disable-next-line: missing-fields
local keymaps = require("keymaps").setup()

local function kmgroup(mappings)
  coroutine.wrap(function ()
    vim.iter(ipairs(mappings)):each(function(_, map)
      if #map < 4 then
        vim.notify(
          string.format("[%s] %s", "kmgroup", "requires 4 paramaters per keymap"),
          vim.log.levels.WARN
        )
        return
      end
      local mode = map[1]
      local lhs = map[2]
      local rhs = map[3]
      local desc = map[4]

        vim.schedule(function()
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
        end)
    end)
  end)()
end

local function directionalmap(mode, lhs, f, fmt)
  vim.iter(ipairs({ {"h", "left"}, {"j", "down"}, {"k", "up"}, {"l", "right"} })):each(function(_, map)
    local d = map[1]
    local _lhs = lhs:format(d)
    local direction = map[2]
    vim.keymap.set(mode, _lhs, f(d), { noremap = true, silent = true, desc = fmt:format(direction) })
  end)
end

local function cbcall(fn, props)
  return function()
    pcall(fn, props)
  end
end

-- set space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

-- [movement]
kmgroup({
  { { "n", "v" }, "W", "g_", "goto last non empty of line" },
  { { "n", "v" }, "B", "^", "goto first non empty of line" },
})

-- [vertical movment]
kmgroup({
  { "n", "<C-d>", "<C-d>zz", "go down and center line" },
  { "n", "<C-u>", "<C-u>zz", "go up and center line" },
  { "n", "n", "nzzzv", "goto next search and uncover line" },
  { "n", "N", "Nzzzv", "goto prev search and uncover line" },
})

-- [fixup]
kmgroup({
  { { "n", "v" }, "<S-down>", "<nop>", "remove shift down movement" },
  { { "n", "v" }, "<S-up>", "<nop>", "remove shift up movement" },
})

-- [workspace]
kmgroup({
  { "n", "<leader>q", vim.cmd.quitall, "quit all" },
})

-- [file]
kmgroup({
  { "n", "<C-s>", vim.cmd.update, "save file" },
})

-- [window movement]
directionalmap("n", "<leader>w%s", function(lhs)
  return cbcall(vim.cmd.wincmd, lhs)
end, "switch window %s")

-- [fixup]
vim.keymap.set("n", "s", "<nop>")

-- [windows]
kmgroup({
  { "n", "sv", vim.cmd.vsplit, "split window vertical" },
  { "n", "sh", vim.cmd.split, "split window horizontal" },
  { "n", "q", cbcall(vim.cmd.wincmd, "q"), "close window" },
})

-- [tabs]
kmgroup({
  { "n", "<space><tab>]", vim.cmd.tabnext, "next tab" },
  { "n", "<space><tab>[", vim.cmd.tabprev, "prev tab" },
  { "n", "<space><tab>n", cbcall(vim.cmd, [[$tabedit]]), "open new tab" },
  { "n", "<space><tab>d", vim.cmd.tabclose, "close current tab" },
  { "n", "<space><tab>x", vim.cmd.tabclose, "close current tab" },
  {
    "n",
    "<space><tab><",
    function()
      vim.cmd([[ -tabmove ]])
    end,
    "move tab to the left",
  },
  {
    "n",
    "<space><tab>>",
    function()
      vim.cmd([[ +tabmove ]])
    end,
    "move tab to the right",
  },
})

-- [splits]
keymaps.normal["<C-\\>"] = {
  function()
    vim.cmd([[vs | wincmd l]])
  end,
  "split file vertically",
}

-- [selection]
kmgroup({
  { "n", "<M-v>", "^vg_", "select contents of current line" },
})

-- [fixup]
keymaps.normal[";"] = {
  function()
    vim.notify("use `v;`", vim.log.levels.WARN)
  end,
  "fixup `v;`",
}

-- [selection]
vim.keymap.set("o", ";", "iw", { desc = "select inside word" })
vim.keymap.set("v", ";", "iw", { desc = "select inside word" })

-- [edit]
vim.keymap.set({'n', 'v'}, "C", "\"_c", { desc = "non-copy change" })
vim.keymap.set({'n', 'v'}, "D", "\"_d", { desc = "non-copy delete" })
vim.keymap.set("n", "<leader>D", "0d$", { desc = "clear current line" })

-- [recording]
kmgroup({
  { "n", "Q", "q", "record macro" },
})

-- [treesitter]
kmgroup({
  { "n", "gm", vim.show_pos, "inspect treesitter node" },
})

local ns = vim.api.nvim_create_namespace("resize-mode")
keymaps.normal["<space>w"] = {
  function()
    vim.on_key(function(key, typed)
      local switch = {
        ["<C-H>"] = function()
          if vim.fn.winnr() == vim.fn.winnr("l") then
            return vim.fn.win_move_separator(vim.fn.winnr("h"), -1)
          end
          vim.fn.win_move_separator(vim.fn.winnr(), -1)
        end,
        ["<C-J>"] = function()
          if vim.fn.winnr() ~= vim.fn.winnr("j") then
            vim.fn.win_move_statusline(vim.fn.winnr(), 1)
          end
          vim.fn.win_move_statusline(vim.fn.winnr("k"), 1)
        end,
        ["<C-K>"] = function()
          if vim.fn.winnr() ~= vim.fn.winnr("j") then
            vim.fn.win_move_statusline(vim.fn.winnr(), -1)
          end
          vim.fn.win_move_statusline(vim.fn.winnr("k"), -1)
        end,
        ["<C-L>"] = function()
          if vim.fn.winnr() == vim.fn.winnr("l") then
            return vim.fn.win_move_separator(vim.fn.winnr("h"), 1)
          end
          vim.fn.win_move_separator(vim.fn.winnr(), 1)
        end,
      }

      local k = vim.fn.keytrans(typed)
      if k == "<Esc>" then
        vim.on_key(nil, ns)
      elseif vim.tbl_contains({ "h", "j", "k", "l" }, k) then
        vim.cmd.wincmd(k)
      elseif vim.tbl_contains(vim.tbl_keys(switch), k) then
        local fn = switch[k]
        if fn and type(fn) == "function" then
          fn()
        end
      end
      return ""
    end, ns)
  end,
  "enter resize mode",
}

-- [terminal]
keymaps.terminal["<esc><esc>"] = { [[<C-\><C-n>]], "escape terminal mode" }

-- [editing]
keymaps.normal["g."] = { [[:%s/<c-r>"/<c-r>./g<cr>]], "repeat last edit for file" }
