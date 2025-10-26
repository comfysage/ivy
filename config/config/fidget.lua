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
