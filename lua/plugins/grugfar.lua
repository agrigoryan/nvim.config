require("grug-far").setup()

vim.keymap.set("n", "<leader>sr", function()
  require("grug-far").open()
end, { desc = "Search and Replace" })

vim.keymap.set("v", "<leader>sr", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search and Replace (word)" })
