return {
  {
    "scalameta/nvim-metals",
    opts = function(_, opts)
      -- 1. Initialize capabilities if they don't exist
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- 2. Explicitly disable foldingRange
      if capabilities.textDocument then
        capabilities.textDocument.foldingRange = nil
      end

      -- 3. Apply these capabilities to the metals options
      opts.capabilities = capabilities

      return opts
    end,
  },
}
