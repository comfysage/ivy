vim.o.encoding = "utf-8"

vim.o.title = true
vim.o.titlestring = "%f · nvim"
vim.o.errorbells = false
vim.o.mouse = "nv"

-- set space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.o.keywordprg = ":vertical botright help"
vim.o.rulerformat = "%Ll %l:%c %p%%"

-- true colors
vim.o.termguicolors = true

-- line numbers
vim.o.number = true
vim.o.relativenumber = false
vim.o.numberwidth = 3

vim.o.cursorline = true
vim.o.cursorlineopt = "both"

-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15

-- completion height
vim.o.pumheight = 15
vim.opt.wildoptions = { "fuzzy", "pum", "tagfile" }
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.completeopt = { "fuzzy", "menu", "menuone", "noinsert", "preview" }

-- split directions
vim.o.splitbelow = true
vim.o.splitright = true

-- search settings
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- substitution with preview window
vim.o.inccommand = "split"

-- folding
vim.o.foldlevelstart = 99
vim.api.nvim_create_autocmd("WinNew", {
  group = vim.api.nvim_create_augroup("ivy:options:folds", { clear = true }),
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.wo[win].foldcolumn = "1"
    vim.wo[win].foldenable = true
    vim.wo[win].foldnestmax = 1
    vim.wo[win].foldmethod = "indent"
  end,
})

-- redefine word boundaries - '_' is a word separator, this helps with snake_case
vim.opt.iskeyword:remove("_")

-- allow cursor to move paste the end of the line in visual block mode
vim.o.virtualedit = "block"

-- indentations settings
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 0 -- dont insert spaces on <tab>
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
-- Enable break indent
vim.o.breakindent = true
vim.o.wrap = false

vim.opt.fillchars:append({
  fold = " ",
  eob = "·",
  diff = "─",
  foldopen = "▼",
  foldclose = "▶",
})

-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"

-- hide search notices, intro
vim.opt.shortmess:append("sI")

vim.o.formatoptions = "tcrqj"

-- hide extra text
vim.o.conceallevel = 2
vim.o.concealcursor = "c"

-- nice font icons or something
vim.g.have_nerd_font = true

-- Decrease update time
vim.o.updatetime = 250

vim.o.timeout = false
-- Decrease mapped sequence wait time - displays which-key popup sooner
vim.o.timeoutlen = 0

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
vim.o.showcmd = false
vim.o.showtabline = 2
vim.o.cmdheight = 0
-- global statusline
vim.o.laststatus = 3

-- use rg for grepping
vim.o.grepprg = vim.fn.executable("rg") == 1 and "rg --vimgrep" or "grep -n $* /dev/null"
vim.o.grepformat = "%f:%l:%c:%m"

-- let me have spelling checking for english
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")
vim.o.spellsuggest = "double,4"

-- indent blank line imporvments
vim.o.list = true

vim.o.shell = os.getenv("SHELL") or "/bin/sh"
if vim.fn.has("unix") == 1 then
  vim.o.shell = "/bin/sh"
end

-- disable swap & backup, and configure undo files
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.o.undofile = true
-- dont unload abandoned buffers
vim.o.hidden = true

---@type { [string]: { style: string, ['vert'|'vertleft'|'vertright'|'horiz'|'horizup'|'horizdown'|'verthoriz'|'topleft'|'topright'|'botleft'|'botright']: string, bottom?: string } }
local borderchars = {
  solid = {
    style = "solid",
    vert = "█",
    vertleft = "█",
    vertright = "█",
    horiz = "▄",
    horizup = "▀",
    horizdown = "▄",
    verthoriz = "█",
    topleft = "▄",
    topright = "▄",
    botleft = "▀",
    botright = "▀",
    bottom = "▀",
  },
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
  none = {
    vert = "",
    vertleft = "",
    vertright = "",
    horiz = "",
    horizup = "",
    horizdown = "",
    verthoriz = "",
    topleft = "",
    topright = "",
    botleft = "",
    botright = "",
  },
  bold = {
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    topleft = "┏",
    topright = "┓",
    botright = "┛",
    botleft = "┗",
  },
}

vim.g.border_style = "single"
-- my custom borderchars
vim.g.bc = borderchars[vim.g.border_style]
vim.g.bc_all = {
  vim.g.bc.topleft,
  vim.g.bc.top or vim.g.bc.horiz,
  vim.g.bc.topright,
  vim.g.bc.vert,
  vim.g.bc.botright,
  vim.g.bc.bottom or vim.g.bc.horiz,
  vim.g.bc.botleft,
  vim.g.bc.vert,
}
vim.opt.fillchars:append({
  horiz = vim.g.bc.horiz,
  horizup = vim.g.bc.horizup,
  horizdown = vim.g.bc.horizdown,
  vert = vim.g.bc.vert,
  vertright = vim.g.bc.vertright,
  vertleft = vim.g.bc.vertleft,
  verthoriz = vim.g.bc.verthoriz,
})

vim.o.winborder = vim.g.border_style

-- rust save
vim.g.rustfmt_autosave = 1

-- cursor
vim.g.guicursor_config = {
  normal = {
    type = "block",
  },
  insert = {
    type = "vertical",
    size = 20,
    animate = {
      wait = 50,
      on = 250,
      off = 250,
    },
  },
  replace = {
    type = "horizontal",
    size = 20,
  },
  operator = {
    type = "horizontal",
    size = 50,
  },
  showmatch = {
    type = "block",
  },
}

-- lsp
vim.diagnostic.config({
  virtual_text = {
    hl_mode = "combine",
  },
  -- virtual_lines = {
  --   current_line = true,
  -- },
  signs = true,
  float = {
    border = vim.g.bc_all,
    header = "",
    prefix = function(_, i)
      return string.format("%d. ", i), "LineNr"
    end,
  },
})
