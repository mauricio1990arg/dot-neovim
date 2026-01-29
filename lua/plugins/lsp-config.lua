return {
  "hrsh7th/cmp-nvim-lsp",
  config = function()
    vim.lsp.enable({ "lua_ls", "jsonls", "yamlls", "lemminx" })
    
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf
        
        if client and client.supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end
        
        local opts = { buffer = bufnr, silent = true }
        
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })
  end,
}
