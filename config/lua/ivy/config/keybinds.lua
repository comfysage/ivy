-- set space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move lines
keymaps.normal["<A-j>"] = { "<cmd>m .+1<cr>==", "move current line down" }
keymaps.normal["<A-k>"] = { "<cmd>m .-2<cr>==", "move current line up" }
keymaps.visual["J"] = { "<cmd>m '>+1<CR>gv=gv", "move selection down" }
keymaps.visual["K"] = { "<cmd>m '<-1<CR>gv=gv", "move selection up" }

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

-- improved clipboard
keymaps.normal["<leader>y"] = { '"+y', "copy to system clipboard" }
keymaps.visual["<leader>y"] = { '"+y', "copy to system clipboard" }
keymaps.normal["<leader>p"] = { '"+p', "paste from system clipboard" }
keymaps.visual["<leader>p"] = { '"+p', "paste from system clipboard" }

-- quit all
keymaps.normal["<leader>q"] = { vim.cmd.quitall, "quit all" }
keymaps.visual["<leader>q"] = { vim.cmd.quitall, "quit all" }

-- save file
keymaps.normal["<C-s>"] = { vim.cmd.write, "write file" }
