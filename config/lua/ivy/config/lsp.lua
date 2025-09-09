vim.g.lsp_config = {
  common = {},
  servers = function()
    return {
      astro = {},
      bashls = {},
      clangd = {},
      colorlsp = {},
      cssls = {},
      denols = {},
      dockerls = {},
      emmet_language_server = {},
      gopls = {},
      hls = {},
      html = {},
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      lua_ls = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath("config")
              and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
              },
            },
          })
        end,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = {
                "lua/?.lua",
                "lua/?/init.lua",
              },
            },
            diagnostics = {
              globals = { "vim", "package", "table" },
            },
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
          },
        },
      },
      marksman = {},
      nil_ls = {},
      nushell = {},
      taplo = {},
      teal_ls = {},
      tinymist = {},
      ts_ls = {},
      tailwindcss = {},
      vue_ls = {},
      yamlls = {
        settings = {
          yaml = {
            schemas = vim.tbl_extend("keep", {
              ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
              ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
              ["https://goreleaser.com/static/schema.json"] = ".goreleaser.{yml,yaml}",
            }, require("schemastore").yaml.schemas()),
          },
        },
      },
      zk = {},
      zls = {},
    }
  end,
  on_attach = function(_, buf)
    local opts = { buffer = buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
}
