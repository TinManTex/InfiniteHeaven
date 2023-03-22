-- DOBUILD: 1
-- InfRequiresStart.lua
-- tex is first entry of Tpp .requires list
-- is really only just to log when .requires is actually doing stuff
local this={}

InfCore.LogFlow"Load InfRequiresStart - start of TppDefine requires-list"
InfCore.LogFlow"requires list: (this is just documentation, not indicating point of executution)"
InfCore.LogFlow"if you want point of execution/load for the requires files then look in IHHook at lua_loadHook"
--tex Note: this wont catch InfMain at end since that's pushed into _requireList instead and only done after Tpp .requires loading anyhoo (see InfInitMain)
for i,path in ipairs(Tpp.requires) do
  InfCore.LogFlow(path)
end

return this