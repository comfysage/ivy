vim.opt.encoding = "utf-8"

vim.opt.title = true
vim.opt.titlestring = '%{expand("%:p:~:.")} · nvim'
vim.opt.errorbells = false
vim.opt.mouse = "nv"

-- set space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.opt.keywordprg = ":vertical botright help"

-- true colors
vim.opt.termguicolors = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 3

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15

-- completion height
vim.o.pumheight = 15
vim.opt.wildoptions = { "fuzzy", "pum", "tagfile" }
vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = { "fuzzy", "menu", "menuone", "noinsert", "preview" }

-- split directions
vim.o.splitbelow = true
vim.o.splitright = true

-- search settings
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- substitution with preview window
vim.opt.inccommand = "split"

-- folding
vim.opt.foldenable = false
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 4
-- vim.opt.foldmethod = 'marker'

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

vim.opt.timeout = false
-- Decrease mapped sequence wait time - displays which-key popup sooner
vim.opt.timeoutlen = 0

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.showcmd = false
vim.o.showtabline = 2
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

vim.opt.shell = os.getenv("SHELL") or "/bin/sh"

-- disable swap & backup, and configure undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true
-- dont unload abandoned buffers
vim.opt.hidden = true

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

vim.opt.winborder = vim.g.border_style

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

-- cursor
local guicursor_opts = {
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

local mode_lookup = {
  normal = "n-v",
  insert = "i-c-ci-ve",
  replace = "r-cr",
  operator = "o",
  showmatch = "sm",
}
local type_lookup = {
  block = "block",
  vertical = "ver",
  horizontal = "hor",
}
local guicusor = vim.iter(pairs(guicursor_opts)):fold("", function(str, mode, opts)
  vim.validate("mode", mode, function(v)
    return vim.tbl_contains({ "normal", "insert", "replace", "operator", "showmatch" }, v)
  end, "valid mode")
  vim.validate("opts", opts, function(v)
    vim.validate("type", v.type, function(t)
      return vim.tbl_contains({ "block", "vertical", "horizontal" }, t)
    end, "valid type")
    if v.type ~= "block" then
      vim.validate("size", v.size, function(s)
        return type(s) == "number"
      end, "valid size with type ~= block")
    end

    if v.animate then
      vim.validate("animate", v.animate, function(anim)
        vim.validate("wait", anim.wait, "number")
        vim.validate("on", anim.on, "number")
        vim.validate("off", anim.off, "number")
        return true
      end, "valid animation")
    end

    return true
  end, "valid opts")
  if #str > 0 then
    str = str .. ","
  end
  local s = string.format(
    "%s:%s",
    mode_lookup[mode],
    opts.type ~= "block" and string.format("%s%d", type_lookup[opts.type], opts.size) or type_lookup[opts.type]
  )

  if opts.animate then
    local anim = opts.animate
    local anim_str = string.format("blinkwait%d-blinkon%d-blinkoff%d", anim.wait, anim.on, anim.off)
    s = s .. "-" .. anim_str
  end

  return str .. s
end)

vim.opt.guicursor = guicusor

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
