vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.titlestring = "%f · nvim"
vim.opt.errorbells = false
vim.opt.mouse = "nv"

-- true colors
vim.opt.termguicolors = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 3

-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15

-- completion height
vim.o.pumheight = 15
vim.opt.wildoptions = { "fuzzy", "pum", "tagfile" }
vim.opt.wildmode = "longest:full,full"

vim.iter(ipairs({ "menu", "menuone", "noselect", "preview" })):each(function(_, option)
  if not vim.tbl_contains(vim.opt.completeopt:get(), option) then
    vim.opt.completeopt:append(option)
  end
end)

-- split directions
vim.o.splitbelow = true
vim.o.splitright = true

-- search settings
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
-- substitution with preview window
vim.opt.inccommand = "split"

-- folding
vim.opt.foldenable = false
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 4
-- vim.opt.foldmethod = 'marker'

-- enable treesitter folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- redefine word boundaries - '_' is a word separator, this helps with snake_case
vim.opt.iskeyword:remove("_")

-- allow cursor to move paste the end of the line in visual block mode
vim.opt.virtualedit = "block"

-- indentations settings
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 0 -- dont insert spaces on <tab>
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
-- Enable break indent
vim.opt.breakindent = true
vim.o.wrap = false

-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"

-- hide search notices, intro
vim.opt.shortmess:append("sI")

vim.opt.formatoptions = "tcrqj"

-- hide extra text
vim.opt.conceallevel = 2
vim.opt.concealcursor = "c"

-- nice font icons or something
vim.g.have_nerd_font = true

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.showcmd = false
vim.o.showtabline = 0
vim.o.cmdheight = 0
-- global statusline
vim.o.laststatus = 3

-- use rg for grepping
vim.opt.grepprg = vim.fn.executable("rg") == 1 and "rg --vimgrep" or "grep -n $* /dev/null"
vim.opt.grepformat = "%f:%l:%c:%m"

-- let me have spelling checking for english
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")

-- indent blank line imporvments
vim.opt.list = true

vim.opt.shell = vim.env["SHELL"] or "/usr/bin/bash"

-- disable swap, backup, and undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true
-- dont unload abandoned buffers
vim.opt.hidden = true

local borderchars = {
  single = {
    style = "single",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    verthoriz = "┼",
    topleft = "┌",
    topright = "┐",
    botleft = "└",
    botright = "┘",
  },
  double = {
    style = "double",
    vert = "║",
    vertleft = "╣",
    vertright = "╠",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    verthoriz = "╬",
    topleft = "╔",
    topright = "╗",
    botleft = "╚",
    botright = "╝",
  },
  rounded = {
    style = "rounded",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    verthoriz = "┼",
    topleft = "╭",
    topright = "╮",
    botleft = "╰",
    botright = "╯",
  },
}

-- my custom borderchars
vim.g.bc = borderchars.rounded
vim.opt.fillchars:append({
  horiz = vim.g.bc.horiz,
  horizup = vim.g.bc.horizup,
  horizdown = vim.g.bc.horizdown,
  vert = vim.g.bc.vert,
  vertright = vim.g.bc.vertright,
  vertleft = vim.g.bc.vertleft,
  verthoriz = vim.g.bc.verthoriz,
})

-- rust save
vim.g.rustfmt_autosave = 1

-- disable remote plugin providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- fix markfown stuff
vim.g.markdown_recommended_style = 0
