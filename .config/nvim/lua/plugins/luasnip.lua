return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")
		
		-- Load friendly snippets
		require("luasnip.loaders.from_vscode").lazy_load()
		
		-- Keep your snippet navigation keymaps
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				return "<Tab>"
			end
		end, { silent = true, expr = true })
		
		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				return "<S-Tab>"
			end
		end, { silent = true, expr = true })
	end,
}