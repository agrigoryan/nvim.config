local function kulala()
  return require("kulala")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  once = true,
  callback = function()
    kulala().setup()
  end,
})

local map = vim.keymap.set
map("n", "<leader>Rb", function() kulala().scratchpad() end, { desc = "Open scratchpad" })
map("n", "<leader>Rr", function() kulala().replay() end, { desc = "Replay last request" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function(ev)
    local opts = function(desc) return { buffer = ev.buf, desc = desc } end
    map("n", "<leader>Rc", function() kulala().copy() end, opts("Copy as cURL"))
    map("n", "<leader>RC", function() kulala().from_curl() end, opts("Paste from cURL"))
    map("n", "<leader>Re", function() kulala().set_selected_env() end, opts("Set environment"))
    map("n", "<leader>Rg", function() kulala().download_graphql_schema() end, opts("Download GraphQL schema"))
    map("n", "<leader>Ri", function() kulala().inspect() end, opts("Inspect request"))
    map("n", "<leader>Rn", function() kulala().jump_next() end, opts("Next request"))
    map("n", "<leader>Rp", function() kulala().jump_prev() end, opts("Previous request"))
    map("n", "<leader>Rq", function() kulala().close() end, opts("Close window"))
    map("n", "<leader>Rs", function() kulala().run() end, opts("Send request"))
    map("n", "<leader>RS", function() kulala().show_stats() end, opts("Show stats"))
    map("n", "<leader>Rt", function() kulala().toggle_view() end, opts("Toggle headers/body"))
  end,
})
