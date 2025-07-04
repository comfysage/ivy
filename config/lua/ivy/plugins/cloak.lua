-- hide my secrets
return {
  {
    "cloak.nvim",
    event = "BufReadPre",
    after = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = "Comment",
        patterns = {
          {
            -- Match any file starting with ".env".
            -- This can be a table to match multiple file patterns.
            file_pattern = {
              ".env",
              ".env.local",
              ".env.dev",
              ".env.development",
              "wrangler.toml",
              ".dev.vars",
              "secrets.yaml",
              "secrets.yml",
              "*.age",
            },
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
            cloak_pattern = { ":.+", "=.+" },
          },
        },
      })
    end,
  },
}
