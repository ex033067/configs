require('telescope').setup {
  defaults = {
    preview = {
      hide_on_startup = true
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
        },
      },
    },
    find_files = {
      mappings = {
        i = {
          ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
        },
      },
    },
    live_grep = {
      mappings = {
        i = {
          ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
        },
      },
    },
  },
}
