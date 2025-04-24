-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Catppuccin Frappuccino'
-- config.color_scheme = 'Gruvbox Dark'

config.font = wezterm.font_with_fallback {
	'Maple Mono NF',
	'FiraCode Nerd Font',
	'JetBrains Mono',
	'Courier New'
}
config.font_size = 22.0
config.line_height = 1
config.default_cursor_style = 'BlinkingBlock'

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 35000

-- Enable the scrollbar.
-- It will occupy the right window padding space.
-- If right padding is set to 0 then it will be increased
-- to a single cell width
config.enable_scroll_bar = true

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font { family = 'Roboto', weight = 'Bold' },

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 16.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = '#333353',

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = '#335333',
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = '#775737',
	},
}

-- and finally, return the configuration to wezterm
return config
