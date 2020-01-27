----loadLDT.lua

--tex MockFox host stuff
luaHostType="LDT"

foxGamePath="C:/GamesSD/MGS_TPP/"--tex used to reconstruct package.path to what it looks like in mgstpp, IH uses this to get the game path so it can load files in game folder\mod

foxLuaPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/Data1Lua/"--tex path of tpps scripts (qar luas) -- IH
--foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified DEBUGNOW
mockFoxPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/MockFoxLua/"--tex path of MockFox scripts

package.path=nil--KLUDGE have mockfox default package path code run, will kill existing / LDT provided package.path
package.cpath=mockFoxPath.."?.dll"--tex for bit.dll TODO: build equivalent cpath.
--

dofile(mockFoxPath.."/loadMockFox.lua")
--GOTCHA dofile,loadfile redirected to DoFile,LoadFile, see loadMockFox WORKAROUND


DoFile(foxLuaPath.."/init.lua")
print("init.lua done")

--tex IH from trying to continue if it has this showstopper
if InfCore and InfCore.modDirFail then
  return
end

do
  local chunk,err=LoadFile(foxLuaPath.."/Tpp/start.lua")
  if err then
    print(err)
  else
    local co=coroutine.create(chunk)
    repeat
      local ok,ret=coroutine.resume(co)
      if not ok then
        error(ret)
      end
    until coroutine.status(co)=="dead"
  end
end

local MockFoxTests=require"MockFoxTests"
MockFoxTests.DoTests()

--tex InfCore.allLoaded is set true at end of start.lua, so in theory it should be an indicator that mockfox is fine and you can use it
--however due to IH having to use PCalls to get any kind of error feedback from runtime there may be some soft errors, so just keep an eye out for ERROR in the log.
--tex bit of a kludge, InfInspect is first IH module loaded, and will remain pretty much untouched, so using it as an indicator that mockfox is trying to load IH
if InfInspect and not InfCore then
  print"ERROR: MockFox did not complete loading"
  return
end

if InfCore and not InfCore.allLoaded then
  print"ERROR: MockFox did not complete loading"
  return
end


