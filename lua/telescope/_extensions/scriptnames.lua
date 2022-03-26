local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function prepare_output_table()
  local lines = {}
  local scripts = vim.api.nvim_command_output("scriptnames")

  for script in scripts:gmatch("[^\r\n]+") do
      table.insert(lines, script)
  end
  return lines
end

local function show_script_names(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Script Names",
    finder = finders.new_table {
      results = prepare_output_table()
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

local function run()
  show_script_names()
end

return require("telescope").register_extension({
  exports = {
    -- Default when to argument is given, i.e. :Telescope scriptnames
    env = run,
  },
})
