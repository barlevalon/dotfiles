local dn = function()
	require("dark_notify").run()
end
return {
	"cormacrelf/dark-notify",
	enabled = false,
	config = dn,
	init = dn,
}
