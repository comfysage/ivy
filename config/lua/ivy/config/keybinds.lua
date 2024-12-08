---@diagnostic disable-next-line: missing-fields
local keymaps = require("keymaps").setup()

-- set space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vertical movment
keymaps.normal["<C-d>"] = { "<C-d>zz", "go down and center line" }
keymaps.normal["<C-u>"] = { "<C-u>zz", "go up and center line" }
keymaps.normal["n"] = { "nzzzv", "goto next search and uncover line" }
keymaps.normal["N"] = { "Nzzzv", "goto prev search and uncover line" }

-- NvimTree
keymaps.normal["<C-N>"] = {
  function()
    require("nvim-tree.api").tree.open()
  end,
  "open nvim tree",
}

-- quit all
keymaps.normal["<leader>q"] = { vim.cmd.quitall, "quit all" }
keymaps.visual["<leader>q"] = { vim.cmd.quitall, "quit all" }

-- save file
keymaps.normal["<C-s>"] = { vim.cmd.update, "save file" }

-- window movement
for _, direction in ipairs({ "h", "j", "k", "l" }) do
  keymaps.normal["<leader>" .. direction] = {
    function()
      vim.cmd.wincmd(direction)
    end,
    string.format("switch window `%s`", direction),
  }
end

keymaps.normal["sv"] = { vim.cmd.vsplit, "split window vertical" }
keymaps.normal["sh"] = { vim.cmd.split, "split window horizontal" }
