return {
	-- Pre-install all theme plugins so they're available for hot-reloading
	-- without needing to clone on every theme switch.
	-- Covers both stock omarchy themes and custom themes.

	-- Stock omarchy themes
	{ "ribru17/bamboo.nvim", lazy = true, priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
	{ "neanias/everforest-nvim", lazy = true, priority = 1000 },
	{ "kepano/flexoki-neovim", lazy = true, priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", lazy = true, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },
	{ "tahayvr/matteblack.nvim", lazy = true, priority = 1000 },
	{ "loctvl842/monokai-pro.nvim", lazy = true, priority = 1000 },
	{ "EdenEast/nightfox.nvim", lazy = true, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = true, priority = 1000 },
	{ "bjarneo/ethereal.nvim", lazy = true, priority = 1000 },
	{ "bjarneo/hackerman.nvim", lazy = true, priority = 1000 },
	{ "xero/miasma.nvim", lazy = true, priority = 1000 },
	{ "bjarneo/vantablack.nvim", lazy = true, priority = 1000 },
	{ "bjarneo/white.nvim", lazy = true, priority = 1000 },

	-- Custom themes
	{ "bjarneo/aether.nvim", branch = "v2", name = "aether", lazy = true, priority = 1000 },
	{ "somerocketeer/bauhaus.nvim", name = "bauhaus-nvim", lazy = true, priority = 1000 },
	{ "everviolet/nvim", name = "evergarden", lazy = true, priority = 1000 },
}
