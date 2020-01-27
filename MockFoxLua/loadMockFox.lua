--loadMockFox.lua
--Initialize MockFox

luaPrintIHLog=true--tex echo InfCore.Log to print. TODO shift somewhere else DEBUGNOW

--tex TODO: shift mockfox/host settings to their own module/out of global
isMockFox=true

--tex should have already been set by lua host
if foxGamePath==nil then
  print("ERROR: foxGamePath==nil")
  return
end

if foxLuaPath==nil then
  print("ERROR: foxLuaPath==nil")
  return
end

if mockFoxPath==nil then
  print("ERROR: mockFoxPath==nil")
  return
end

--tex TODO: append trailing slash to paths if need be

--tex set up package.path like MGS_TPP initial package path
local defaultPackagePaths={
  [[.\?.lua]],
  foxGamePath..[[lua\?.lua]],
  foxGamePath..[[lua\?\init.lua]],
  foxGamePath..[[?.lua]],
  foxGamePath..[[?\init.lua]],
  foxGamePath..[[mod\?.lua]],
  foxGamePath..[[mod\modules\?.lua]],
}

if package.path==nil then
  package.path=""
  for i,path in ipairs(defaultPackagePaths)do
    package.path=package.path..path..";"
  end
  print("MockFox initial package.path="..package.path)
end
package.cpath = package.cpath or ""

package.path=package.path..";"..mockFoxPath.."/?.lua"

--tex MoonSharp doesnt set/use package path
if luaHostType=="MoonSharp" then
  table.insert(defaultPackagePaths,mockFoxPath.."/?.lua")
  SetModulePaths(defaultPackagePaths)
end

MockUtil=require"MockUtil"

dofile(mockFoxPath.."/MockFoxEngine.lua")

--tex WORKAROUND fox luas not being in working path
LoadFile=loadfile
loadfile=function(path)
  if isMockFox then
    return LoadFile(foxLuaPath..path)
  else
    return LoadFile(path)
  end
end

DoFile=dofile
dofile=function(path)
  if isMockFox then
    return DoFile(foxLuaPath..path)
  else
    return DoFile(path)
  end
end

vars=require"vars"

print("loadMockFox done")

