if not vim.g.neovide then
  return
end

-- background --
vim.g.neovide_opacity = 1.0

_G.neovide_alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

if vim.uv.os_uname().sysname == "Darwin" then
  vim.g.neovide_normal_opacity = 0.6
  -- options only currently available on macOS
  vim.g.neovide_window_blurred = true
else
  -- helper function for transparency formatting
  vim.g.neovide_normal_opacity = 0.9
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("neovide:background", { clear = true }),
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" }) or { bg = 0, fg = 0 }
    local bg = normal.bg and string.format("%x", normal.bg)
    local fg = normal.fg and string.format("%x", normal.fg)
    if bg then
      vim.g.neovide_background_color = bg .. _G.neovide_alpha()
      vim.g.neovide_title_background_color = bg
    end
    if fg then
      vim.g.neovide_title_text_color = fg
    end
  end,
})
vim.api.nvim_exec_autocmds("ColorScheme", {})

-- font & cursor --

vim.g.fontsize = 12
vim.opt.guifont = {
  "Maple Mono",
  "Symbols Nerd Font",
  string.format(":h%d", vim.g.fontsize),
}
vim.g.lineheight = 1.2

vim.opt.linespace = math.floor((vim.g.lineheight - 1) * vim.g.fontsize)

vim.g.neovide_cursor_smooth_blink = true

-- behavior --
vim.g.neovide_detach_on_quit = "always_detach"

vim.keymap.set("n", "<m-enter>", function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  if vim.g.neovide_fullscreen then
    vim.notify("enabling fullscreen")
  else
    vim.notify("disabling fullscreen")
  end
end, { noremap = true, silent = true })
