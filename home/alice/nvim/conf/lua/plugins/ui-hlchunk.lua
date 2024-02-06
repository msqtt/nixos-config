return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    require("hlchunk").setup({
      indent = {
        enable = false,
        chars = { "│", "¦", "┆", "┊", }, -- more code can be found in https://unicodeplus.com/
      },
      blank = {
        enable = false,
      }

    })
  end
}
