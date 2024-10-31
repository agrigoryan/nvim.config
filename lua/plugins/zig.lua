return {
  {
    "ziglang/zig.vim",
    ft = "zig",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zig" })
      else
        opts.ensure_installed = { "zig" }
      end
    end,
  },
}
