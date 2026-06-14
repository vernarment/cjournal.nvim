# cjournal.nvim

A minimal daily journaling plugin for Neovim.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

{
  "vernarment/cjournal.nvim",
  config = function()
    require("cjournal").setup({
      journal_dir = "~/Documents/my_journal", -- ur folder
      template = {                           -- customize
        "# Journal ${date}",
        "",
        "## Done:",
        "",
        "## Books:",
        "",
        "Ideas",
      }
    })
  end
}

## Keymaps

* `<leader>jn` — Open/Create today's journal.
* `<leader>jt` — Insert current timestamp (e.g., `## 15:30 — `) and enter Insert mode.
