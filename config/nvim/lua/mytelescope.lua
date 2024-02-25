local layout = require("nui.layout")
local popup = require("nui.popup")

local actions = require("telescope.actions")

local tslayout = require("telescope.pickers.layout")

return require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,
				["<c-u>"] = false,
			},
		},

		create_layout = function(picker)
			local border = {
				results = {
					top_left = "┌",
					top = "─",
					top_right = "┬",
					right = "│",
					bottom_right = "",
					bottom = "",
					bottom_left = "",
					left = "│",
				},
				results_patch = {
					minimal = {
						top_left = "┌",
						top_right = "┐",
					},
					horizontal = {
						top_left = "┌",
						top_right = "┬",
					},
					vertical = {
						top_left = "├",
						top_right = "┤",
					},
				},
				prompt = {
					top_left = "├",
					top = "─",
					top_right = "┤",
					right = "│",
					bottom_right = "┘",
					bottom = "─",
					bottom_left = "└",
					left = "│",
				},
				prompt_patch = {
					minimal = {
						bottom_right = "┘",
					},
					horizontal = {
						bottom_right = "┴",
					},
					vertical = {
						bottom_right = "┘",
					},
				},
				preview = {
					top_left = "┌",
					top = "─",
					top_right = "┐",
					right = "│",
					bottom_right = "┘",
					bottom = "─",
					bottom_left = "└",
					left = "│",
				},
				preview_patch = {
					minimal = {},
					horizontal = {
						bottom = "─",
						bottom_left = "",
						bottom_right = "┘",
						left = "",
						top_left = "",
					},
					vertical = {
						bottom = "",
						bottom_left = "",
						bottom_right = "",
						left = "│",
						top_left = "┌",
					},
				},
			}

			local results = popup({
				focusable = false,
				border = {
					style = border.results,
					text = {
						top = picker.results_title,
						top_align = "center",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal",
				},
			})

			local prompt = popup({
				enter = true,
				border = {
					style = border.prompt,
					text = {
						top = picker.prompt_title,
						top_align = "center",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal",
				},
			})

			local preview = popup({
				focusable = false,
				border = {
					style = border.preview,
					text = {
						top = picker.preview_title,
						top_align = "center",
					},
				},
			})

			local box_by_kind = {
				vertical = layout.Box({
					layout.Box(preview, { grow = 1 }),
					layout.Box(results, { grow = 1 }),
					layout.Box(prompt, { size = 3 }),
				}, { dir = "col" }),
				horizontal = layout.Box({
					layout.Box({
						layout.Box(results, { grow = 1 }),
						layout.Box(prompt, { size = 3 }),
					}, { dir = "col", size = "50%" }),
					layout.Box(preview, { size = "50%" }),
				}, { dir = "row" }),
				minimal = layout.Box({
					layout.Box(results, { grow = 1 }),
					layout.Box(prompt, { size = 3 }),
				}, { dir = "col" }),
			}

			local function get_box()
				local height, width = vim.o.lines, vim.o.columns
				local box_kind = "horizontal"
				if width < 100 then
					box_kind = "vertical"
					if height < 40 then
						box_kind = "minimal"
					end
				elseif width < 120 then
					box_kind = "minimal"
				end
				return box_by_kind[box_kind], box_kind
			end

			local function prepare_layout_parts(layout, box_type)
				layout.results = tslayout.Window(results)
				results.border:set_style(border.results_patch[box_type])

				layout.prompt = tslayout.Window(prompt)
				prompt.border:set_style(border.prompt_patch[box_type])

				if box_type == "minimal" then
					layout.preview = nil
				else
					layout.preview = tslayout.Window(preview)
					preview.border:set_style(border.preview_patch[box_type])
				end
			end

			local box, box_kind = get_box()
			local layout = layout({
				relative = "editor",
				position = "50%",
				size = {
					height = "60%",
					width = "90%",
				},
			}, box)

			layout.picker = picker
			prepare_layout_parts(layout, box_kind)

			local layout_update = layout.update
			function layout:update()
				local box, box_kind = get_box()
				prepare_layout_parts(layout, box_kind)
				layout_update(self, box)
			end

			return tslayout(layout)
		end,
	},
})
