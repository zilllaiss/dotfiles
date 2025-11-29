-- https://github.com/slint-ui/slint/discussions/7013
--
-- to run in nvim do :lua SlintShowPreview("ComponentName")
function SlintShowPreview(component_name)
  -- this works but is deprecated for some reason
  --vim.lsp.buf.execute_command {
  --  command = 'slint/showPreview',
  --  arguments = {
  --    vim.uri_from_bufnr(0),
  --    component_name,
  --  },
  --}
  -- get the client for the current buffer.
  local client = vim.lsp.get_client_by_id(vim.lsp.get_clients({ bufnr = 0 })[1].id)

  if client and client.server_capabilities and client.server_capabilities.executeCommandProvider then
    client:exec_cmd {
      title = 'Preview Slint UI',
      command = 'slint/showPreview',
      arguments = {
        vim.uri_from_bufnr(0),
        component_name,
      },
    }
  else
    vim.notify("No active client or server does not support 'slint/showPreview' command.", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>zs", "<cmd>lua SlintShowPreview")

