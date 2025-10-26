require("marks").setup({
  -- whether to map keybinds or not. default true
  default_mappings = false,
  mappings = {},
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

vim.keymap.set("n", "m", "<Plug>(Marks-set)", { desc = "sets a letter mark (will wait for input)" })
vim.keymap.set("n", "m,", "<Plug>(Marks-setnext)", { desc = "set next available lowercase mark at cursor" })
vim.keymap.set("n", "m;", "<Plug>(Marks-toggle)", { desc = "toggle next available mark at cursor" })
vim.keymap.set("n", "]m", "<Plug>(Marks-next)", { desc = "goes to next mark in buffer" })
vim.keymap.set("n", "[m", "<Plug>(Marks-prev)", { desc = "goes to previous mark in buffer" })

vim.keymap.set(
  "n",
  "m:",
  "<Plug>(Marks-preview)",
  { desc = "previews mark (will wait for user input). press <cr> to just preview the next mark" }
)

vim.keymap.set("n", "dm", "<Plug>(Marks-delete)", { desc = "delete a letter mark (will wait for input)" })
vim.keymap.set("n", "dm-", "<Plug>(Marks-deleteline)", { desc = "deletes all marks on current line" })
vim.keymap.set("n", "dm<space>", "<Plug>(Marks-deletebuf)", { desc = "deletes all marks in current buffer" })
