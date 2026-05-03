return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0e1417',
				base01 = '#0e1417',
				base02 = '#99a1a5',
				base03 = '#99a1a5',
				base04 = '#effaff',
				base05 = '#f8fcff',
				base06 = '#f8fcff',
				base07 = '#f8fcff',
				base08 = '#ff9ebd',
				base09 = '#ff9ebd',
				base0A = '#91dcff',
				base0B = '#a4ffae',
				base0C = '#c4ecff',
				base0D = '#91dcff',
				base0E = '#a4e2ff',
				base0F = '#a4e2ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#99a1a5',
				fg = '#f8fcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#91dcff',
				fg = '#0e1417',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#99a1a5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#c4ecff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#a4e2ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#91dcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#91dcff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#c4ecff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a4ffae',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#effaff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#effaff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#99a1a5',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
