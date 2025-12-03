require("blink.pairs").setup({
  mappings = {
    enabled = false,
  },
  highlights = {
    enabled = true,
    cmdline = true,
    groups = {
      "rainbow.1",
      "rainbow.2",
      "rainbow.3",
      "rainbow.4",
      "rainbow.5",
      "rainbow.6",
    },
    unmatched_group = "",
    -- highlights matching pairs under the cursor
    matchparen = {
      enabled = true,
      -- known issue where typing won't update matchparen highlight, disabled by default
      cmdline = false,
      -- also include pairs not on top of the cursor, but surrounding the cursor
      include_surrounding = false,
      group = "BlinkPairsMatchParen",
      priority = 250,
    },
  },
})
