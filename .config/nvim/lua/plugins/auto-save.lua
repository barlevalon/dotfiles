return {
	"okuuva/auto-save.nvim",
	opts = {
		condition = function(buf)
			local fn = vim.fn

			-- don't save for special-buffers
			if fn.getbufvar(buf, "&buftype") ~= "" then
				return false
			end
			return true
		end,
	},
}
