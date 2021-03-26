-- DOBUILD: 1
-- InfRequiresStart.lua
--tex simply a debug message for now
local this={}

InfCore.LogFlow"InfRequiresStart - start of TppDefine requires-list"
InfCore.LogFlow"requires list: (this is just documentation, not indicating point of executution)"
InfCore.LogFlow"if you want point of execution/load for the requires files then look in ih_hook at luaL_loadbufferHook"
for i,path in ipairs(Tpp.requires) do
  InfCore.LogFlow(path)
end

return this