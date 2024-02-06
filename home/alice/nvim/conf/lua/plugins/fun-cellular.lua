return {
  'eandrju/cellular-automaton.nvim',
  event = "VeryLazy",
  keys = {
    { "<leader>cr", mode = { 'n' }, "<cmd>CellularAutomaton make_it_rain<CR>" },
    { "<leader>cl", mode = { 'n' }, "<cmd>CellularAutomaton game_of_life<CR>" },
  }
}
