return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },

  single_file_support = false,
  root_dir = function(buf)
    local root_dir = vim.fs.root(buf, { "package.json", "tsconfig.json" })

    -- this is needed to make sure we don't pick up root_dir inside node_modules
    local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
    if node_modules_index and node_modules_index > 0 then
      ---@diagnostic disable-next-line: need-check-nil
      root_dir = root_dir:sub(1, node_modules_index - 2)
    end

    return root_dir
  end,
  settings = {
    expose_as_code_action = {
      "add_missing_imports",
      "fix_all",
      "remove_unused",
    },
    tsserver_path = vim.fn.resolve(vim.fn.exepath("tsserver") .. "/../../lib/node_modules/typescript/bin/tsserver"),
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
