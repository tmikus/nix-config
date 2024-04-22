local wk = require "which-key"
local telescope = require "telescope.builtin"

-- Settings the leader
vim.g.mapleader = " "

-- Better Vim default keymappings
local n_defaults = {
  -- General
  ["<c-s>"] = { "<cmd>w<cr>", "Save changes", nowait = true, silent = true },
  ["<leader>cl"] = { "<cmd>nohl<cr>", " Clear search highlights" },
  -- Telescope shortcuts
  ["<c-p>"] = { telescope.find_files, "Find file" },
  ["<c-f>"] = { telescope.live_grep, "Find word" },
  ["<c-o>"] = { telescope.buffers, "Show buffers" },
  ["<leader>q"] = { "<cmd>:Bdelete<cr>", " Close buffer, not window", noremap = true },
  ["<leader>/"] = {
    function()
      telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        previewer = false,
      })
    end,
    "Find word in current buffer",
  },
  -- File explorer shortcuts
  ["<c-n>"] = { "<cmd>NvimTreeToggle<cr>", "Open file explorer", noremap = true },
  -- Open nvim config
  ["<leader>ev"] = { "<cmd>e $MYVIMRC<cr>", " Open init.lua" },
  ["<leader>sv"] = { "<cmd>lua reload_nvim_conf()<cr>", "累Reload neovim config" },
  -- Navigate between buffers
  ["<c-h>"] = { "<c-w>h", "Navigate to the buffer (left)" },
  ["<c-l>"] = { "<c-w>l", "Navigate to the buffer (right)" },
  ["<c-j>"] = { "<c-w>j", "Navigate to the buffer (down)" },
  ["<c-k>"] = { "<c-w>k", "Navigate to the buffer (top)" },
  -- Jumping
  ["<leader>o"] = { "<c-o>", "Jump: Go to older cursor position", noremap = true },
  ["<leader>i"] = { "<c-i>", "Jump: Go to newer cursor position", noremap = true },
  -- LSP Diagnostics
  ["<leader>dp"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic message" },
  ["<leader>dn"] = { vim.diagnostic.goto_next, "Go to next diagnostic message" },
  ["<leader>dm"] = { vim.diagnostic.open_float, "Open floating diagnostic message" },
  ["<leader>dl"] = { vim.diagnostic.setloclist, " Show diagnostics list" },
}

local i_defaults = {
  ["<c-s>"] = { "<cmd>w<cr>", "Save changes", nowait = true, silent = true },
}

local v_defaults = {
  -- Line navigation
  ["<s-j>"] = { ":m '>+1<CR>gv=gv", " Move one line down" },
  ["<s-k>"] = { ":m '<-2<CR>gv=gv", " Move one line up" },
}

local x_defaults = {
  -- General
  ["<leader>p"] = { '"_dP', " Paste without losing the last copied text" },
}

local default_mappings = {
  n = n_defaults,
  i = i_defaults,
  v = v_defaults,
  x = x_defaults,
}

local function register_mappings_for_mode(mode)
  return function(mappings)
    for k, v in pairs(mappings) do
      v.mode = mode
      mappings[k] = v
    end
    wk.register(mappings, { mode = mode })
  end
end

for mode, _ in pairs(default_mappings) do
  local default_mappings_in_mode = default_mappings[mode]
  local register = register_mappings_for_mode(mode)
  register(default_mappings_in_mode)
end

local whickey_options = {
  spelling = {
    enabled = true,
    suggestions = 20,
  },
}

wk.setup(whickey_options)

vim.cmd [[ nmap <C-/> gcc ]]
vim.cmd [[ nmap <C-_> gcc ]]
vim.cmd [[ vmap <C-/> gc ]]
vim.cmd [[ vmap <C-_> gc ]]