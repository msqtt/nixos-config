local fp = require("utils").fp
local km = require("modules.keymap.utils")

local n, v, t, i = km.new_mode "n", km.new_mode "v", km.new_mode "t", km.new_mode "i"
local nore, silent = km.new_opt("noremap", true), km.new_opt("silent", true)

vim.g.mapleader = " "
vim.g.localmapleader = " "

local keymaps = {
  { n, "Y",          "0",                                  nore },
  { n, "O",          "$",                                  nore },
  { n, "N",          "5j",                                 nore },
  { n, "E",          "5k",                                 nore },
  { v, "<",          "<gv",                                nore },
  { v, ">",          ">gv",                                nore },
  { v, "N",          ":move '>+1<CR>gv-gv",                nore },
  { v, "E",          ":move '<-2<CR>gv-gv",                nore },
  { n, "S",          "viw",                                nore },
  { n, "vv",         "0wv$",                               nore },
  { n, "<C-l>",      ":set cursorline! cursorcolumn!<CR>", nore + silent },
  { n, "<leader>q",  ":q!<CR>",                            nore },
  { n, "<leader>w",  ":w!<CR>",                            nore },
  { n, "qx",         ":bd<CR>",                            nore },
  { n, "X",          "s",                                  nore },
  { n, "cc",         "<C-w>c",                             nore },
  { n, "co",         "<C-w>o",                             nore },
  { n, "<tab>",      ":tabn<CR>",                          nore + silent },
  { n, "<S-tab>",    ":tabp<CR>",                          nore + silent },
  { n, "<A-y>",      "<C-w>h",                             nore },
  { n, "<A-n>",      "<C-w>j",                             nore },
  { n, "<A-e>",      "<C-w>k",                             nore },
  { n, "<A-o>",      "<C-w>l",                             nore },
  { t, "<A-y>",      [[ <C-\><C-N><C-w>h ]],               nore },
  { t, "<A-n>",      [[ <C-\><C-N><C-w>j ]],               nore },
  { t, "<A-e>",      [[ <C-\><C-N><C-w>k ]],               nore },
  { t, "<A-o>",      [[ <C-\><C-N><C-w>l ]],               nore },
  { n, "<A-S-y>",    ":vertical resize -2<CR>",            nore },
  { n, "<A-S-o>",    ":vertical resize +2<CR>",            nore },
  { n, "<A-S-e>",    ":resize -2<CR>",                     nore },
  { n, "<A-S-e>",    ":resize -2<CR>",                     nore },
  { n, "<c-w>y",     "<c-w>H",                             nore },
  { n, "<c-w>n",     "<c-w>J",                             nore },
  { n, "<c-w>e",     "<c-w>K",                             nore },
  { n, "<c-w>o",     "<c-w>L",                             nore },
  { n, "s=",         "<C-w>=",                             nore },
  { n, "<leader>t",  ":sp<CR><C-w>j:terminal<CR>",         nore },
  { n, "<leader>vt", ":vsp | terminal<CR>",                nore },
  { t, "<Esc>",      "<C-\\><C-n>",                        nore },
  { i, "<C-c>",      "<ESC>",                              nore },
  { n, "<C-j>",      "J",                                  nore },
  { i, "<C-d>",      "<del>",                              nore },
  { i, "<C-l>",      "<ESC>O",                             nore },
  { i, "<C-b>",      "<Left>",                             nore },
  { i, "<C-f>",      "<Right>",                            nore },
  { i, "<A-b>",      "<C-Left>",                           nore },
  { i, "<A-f>",      "<C-Right>",                          nore },
  { n, "!",          ":RunCmd ",                           nore },
  { n, "D!",         ":CloseCmd<CR>",                      nore },
}


local commands = {
  { "Format", "LspZeroFormat", {} },
}

fp.map(commands, km.uwrap_cmd_set)
fp.map(keymaps, km.uwrap_set)
