local telescope = require('telescope')
local builtin = require('telescope.builtin')
local telescope_last = 0

telescope.setup({
    pickers = {
        find_files = {
            hidden = true
        }
    }
})

function TelescopeResume()
  if telescope_last == 0 then
    telescope_last = 1
    builtin.live_grep()
  else
    builtin.resume()
  end
end

