local dn = function()
  require("dark_notify").run()
end
return {
  "cormacrelf/dark-notify",
  config = dn,
  init = dn,
}
