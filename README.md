# cjournal.nvim

A minimalist daily journaling plugin for Neovim.

## Features
- **Daily Journaling:** Automatically creates and opens a markdown file named after the current date (`MM-DD.md`).
- **Customizable Templates:** Populates new journal entries with a structured layout.
- **Quick Timestamps:** Insert formatted time headers into your logs with a single keystroke.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  {
    "vernarment/cjournal.nvim",
    lazy = false,
    config = function()
      require("cjournal").setup({
        -- Optional configuration (defaults shown below)
        journal_dir = "~/journal",
        file_format = "%m-%d.md",
        date_format = "%d.%m.%Y",
        timestamp_format = "## %H:%M — ",
        template = {
          "# Journal ${date}",
          "",
          "## Done",
          "",
          "## Books",
          "",
          "## Ideas / Todo",
          "",
        },~/.config/nvim/lua/plugins/cjournal.lua
      })
    end,
  },
}
```

## Showcase
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/438ccf73-6db0-4b02-b010-dbd62328a382" />


