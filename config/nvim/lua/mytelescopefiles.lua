local ts = require("telescope.builtin")
local utils = require("telescope.utils")

return function()
	local root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, vim.fn.expand("%:h"))
	if ret == 0 then
		ts.git_files({
			cwd = root[1],
			git_command = {
				"sh",
				"-c",
				"git ls-files -c --recurse-submodules && git ls-files -o --exclude-standard",
			},
		})
	else
		-- TODO use root if this file is relative to the current one
		ts.find_files()
	end
end
