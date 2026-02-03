-- Load all coding-related plugins
-- This init.lua aggregates plugins from the coding/ subdirectory

return {
  require("plugins.coding.blink_cmp"),
  require("plugins.coding.copilot"),
  require("plugins.coding.nvim_autopairs"),
  require("plugins.coding.autoclose"),
  require("plugins.coding.lazygit"),
  require("plugins.coding.trouble"),
  require("plugins.coding.todo_comments"),
  require("plugins.coding.treesitter"),
  require("plugins.coding.claude"),
  require("plugins.coding.tailwind_fold"),
}
