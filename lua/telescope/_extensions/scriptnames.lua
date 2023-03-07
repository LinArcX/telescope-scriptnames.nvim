local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function prepare_output_table()
  local scripts = vim.api.nvim_cmd({ cmd = "scriptnames" }, { output = true })
  local lines = vim.split(scripts, "\r?\n")
  return lines
end

local function show_script_names(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Script Names",
      finder = finders.new_table({
        results = prepare_output_table(),
        entry_maker = function(entry)
          local fname = entry:gsub("%s*%d+:%s", "")
          return {
            value = entry,
            ordinal = entry,
            display = entry,
            filename = fname,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      previewer = conf.file_previewer(opts),
    })
    :find()
end

local function run()
  show_script_names()
end

return require("telescope").register_extension({
  exports = {
    -- Default when to argument is given, i.e. :Telescope scriptnames
    scriptnames = run,
  },
})
