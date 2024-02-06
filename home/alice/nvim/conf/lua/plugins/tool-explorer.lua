return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
    -- "nvim-tree/nvim-web-devicons"
  },
  config = function()
    vim.keymap.set("n", "<leader>o", ":vsp | Oil<CR>", { noremap = true })
    require("oil").setup({
      default_file_explorer = true,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        -- <S-CR>
        ["<S-CR>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["g."] = "actions.toggle_hidden",
      },
    })
  end
}
