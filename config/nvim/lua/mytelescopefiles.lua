local ts = require("telescope.builtin")
local utils = require("telescope.utils")

return function()
	local dir = vim.fn.expand("%:h")
	if dir == "" or not vim.fn.exists(dir) then
		dir = vim.fn.getcwd()
	end
	local root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, dir)
	root = root[1]
	if ret == 0 then
		ts.git_files({
			cwd = root,
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
