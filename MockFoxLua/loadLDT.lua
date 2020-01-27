----loadLDT.lua

--tex MockFox host stuff
luaHostType="LDT"

foxGamePath="C:/GamesSD/MGS_TPP/"--DEBUGNOW
--foxGamePath=[[D:\Projects\MGS\MockFox\MockFox\Assets\MockFox\MGS_TPP\]]--DEBUGNOW 

foxLuaPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/Data1Lua/"--tex path of tpps scripts (qar luas) -- IH
--foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified
mockFoxPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/MockFoxLua/"--tex path of MockFox scripts

package.path=nil--KLUDGE have mockfox default package path code run, will kill existing / LDT provided package.path
package.cpath=mockFoxPath.."?.dll"--tex for bit.dll TODO: build equivalent cpath.
--

dofile(mockFoxPath.."/loadMockFox.lua")
--GOTCHA dofile,loadfile redirected to DoFile,LoadFile, see loadMockFox WORKAROUND


DoFile(foxLuaPath.."/init.lua")
--tex DEBUGNOW
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

--tex InfCore.allLoaded is set true at end of start.lua, so in theory it should be an indicator that mockfox is fine and you can use it
--however due to IH having to use PCalls to get any kind of error feedback from runtime there may be some soft errors, so just keep an eye out for ERROR in the log.
if not InfCore or not InfCore.allLoaded then
  print"ERROR: MockFox did not complete loading"
  return
end

