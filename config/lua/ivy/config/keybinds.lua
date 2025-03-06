---@diagnostic disable-next-line: missing-fields
local keymaps = require("keymaps").setup()

local function kmgroup(props)
  if not props.group then
    vim.notify(string.format("[%s] %s", "globals.keymap", "`Keymap.group` requires `group` field"), vim.log.levels.WARN)
    return
  end
  local mappings = props
  vim.iter(ipairs(mappings)):each(function(_, map)
    if #map < 4 then
      vim.notify(
        string.format("[%s] %s", "globals.keymap", "`Keymap.group` requires 4 paramaters per keymap"),
        vim.log.levels.WARN
      )
      return
    end
    local mode = map[1]
    local lhs = map[2]
    local rhs = map[3]
    local desc = map[4]

    if not keymaps[mode] then
      vim.notify(
        string.format("[%s] %s", "globals.keymap", "keymap mode '" .. mode .. "' does not exist"),
        vim.log.levels.WARN
      )
      return
    end
    keymaps[mode][lhs] = { rhs, desc, group = props.group }
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

kmgroup({
  group = "keymaps",
  {
    "normal",
    "<space>,k",
    [[<cmd>s/keymaps\.\(\w*\)\["\([^"]*\)"\] = { \([^,]*\), "\([^"]*\)" }/{ "\1", "\2", \3, "\4" }/<cr>]],
    "transform line to group item format",
  },
})

kmgroup({
  group = "movement",
  { "normal", "W", "g_", "goto last non empty of line" },
  { "normal", "B", "^", "goto first non empty of line" },
  { "visual", "W", "g_", "goto last non empty of line" },
  { "visual", "B", "^", "goto first non empty of line" },
})

kmgroup({
  group = "vertical movment",
  { "normal", "<C-d>", "<C-d>zz", "go down and center line" },
  { "normal", "<C-u>", "<C-u>zz", "go up and center line" },
  { "normal", "n", "nzzzv", "goto next search and uncover line" },
  { "normal", "N", "Nzzzv", "goto prev search and uncover line" },
})

kmgroup({
  group = "fixup",
  { "normal", "<S-down>", "<nop>", "remove shift down movement" },
  { "normal", "<S-up>", "<nop>", "remove shift up movement" },
})

kmgroup({
  group = "workspace",
  { "normal", "<leader>q", vim.cmd.quitall, "quit all" },
  { "visual", "<leader>q", vim.cmd.quitall, "quit all" },
})

kmgroup({
  group = "file",
  { "normal", "<C-s>", vim.cmd.update, "save file" },
})

-- window movement
for _, direction in ipairs({ "h", "j", "k", "l" }) do
  keymaps.normal["<leader>" .. direction] = {
    function()
      vim.cmd.wincmd(direction)
    end,
    string.format("switch window `%s`", direction),
    group = "windows",
  }
end

keymaps.normal["s"] = { "<nop>", "fixup `s`", group = "fixup" }

kmgroup({
  group = "windows",
  { "normal", "sv", vim.cmd.vsplit, "split window vertical" },
  { "normal", "sh", vim.cmd.split, "split window horizontal" },
})

kmgroup({
  group = "tabs",
  { "normal", "<space><tab>]", vim.cmd.tabnext, "next tab" },
  { "normal", "<space><tab>[", vim.cmd.tabprev, "prev tab" },
  { "normal", "<space><tab>n", cbcall(vim.cmd, [[$tabedit]]), "open new tab" },
  { "normal", "<space><tab>d", vim.cmd.tabclose, "close current tab" },
  { "normal", "<space><tab>x", vim.cmd.tabclose, "close current tab" },
  {
    "normal",
    "<space><tab><",
    function()
      vim.cmd([[ -tabmove ]])
    end,
    "move tab to the left",
  },
  {
    "normal",
    "<space><tab>>",
    function()
      vim.cmd([[ +tabmove ]])
    end,
    "move tab to the right",
  },
})

kmgroup({
  group = "windows",
  {
    "normal",
    "<C-\\>",
    function()
      vim.cmd([[vs | wincmd l]])
    end,
    "split file vertically",
  },
  { "normal", "<C-h>", "<C-w>h", "switch window left" },
  { "normal", "<C-l>", "<C-w>l", "switch window right" },
  { "normal", "<C-j>", "<C-w>j", "switch window down" },
  { "normal", "<C-k>", "<C-w>k", "switch window up" },
})

kmgroup({
  group = "selection",
  { "normal", "<M-v>", "^vg_", "select contents of current line" },
})

keymaps.normal[";"] = {
  function()
    vim.notify("use `v;`", vim.log.levels.WARN)
  end,
  "fixup `v;`",
  group = "fixup",
}
vim.keymap.set("o", ";", "iw", { desc = "select inside word" })
vim.keymap.set("v", ";", "iw", { desc = "select inside word" })

keymaps.normal["D"] = { "0d$", "clear current line", group = "edit" }

kmgroup({
  group = "diagnostics",
  { "normal", "<leader>dd", vim.diagnostic.open_float, "hover diagnostics" },
})

kmgroup({
  group = "recording",
  { "normal", "q", "<nop>", "fixup q" },
  { "normal", "Q", "q", "record macro" },
})

kmgroup({
  group = "treesitter",
  { "normal", "gm", vim.show_pos, "inspect treesitter node" },
})

kmgroup({
  group = "windows",
  {
    "normal",
    "<c-w><m-h>",
    "<plug>(expand-window-left)",
    "expand window left",
  },
  {
    "normal",
    "<c-w><m-j>",
    "<plug>(expand-window-down)",
    "expand window down",
  },
  {
    "normal",
    "<c-w><m-k>",
    "<plug>(expand-window-up)",
    "expand window up",
  },
  {
    "normal",
    "<c-w><m-l>",
    "<plug>(expand-window-right)",
    "expand window right",
  },
})
kmgroup({
  group = "windows",
  {
    "normal",
    "<plug>(expand-window-left)",
    function()
      if vim.fn.winnr() == vim.fn.winnr("h") then
        vim.fn.win_move_separator(vim.fn.winnr("h"), -1)
      end
    end,
    "expand window left",
  },
  {
    "normal",
    "<plug>(expand-window-down)",
    function()
      vim.fn.win_move_statusline(vim.fn.winnr(), 1)
    end,
    "expand window down",
  },
  {
    "normal",
    "<plug>(expand-window-up)",
    function()
      if vim.fn.winnr() == vim.fn.winnr("k") then
        vim.fn.win_move_statusline(vim.fn.winnr("k"), -1)
      end
    end,
    "expand window up",
  },
  {
    "normal",
    "<plug>(expand-window-right)",
    function()
      vim.fn.win_move_separator(vim.fn.winnr(), 1)
    end,
    "expand window right",
  },
})
