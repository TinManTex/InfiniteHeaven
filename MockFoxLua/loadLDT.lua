----loadLDT.lua

--tex MockFox host stuff
luaHostType="LDT"

foxGamePath="C:/GamesSD/MGS_TPP/"
foxLuaPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/Data1Lua/"--tex path of tpps scripts (qar luas) -- IH
--foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified
mockFoxPath="D:/Projects/MGS/!InfiniteHeaven/!modlua/MockFoxLua/"--tex path of MockFox scripts

package.path=nil--KLUDGE have mockfox default package path code run, will kill existing / LDT provided package.path
package.cpath=mockFoxPath.."?.dll"--tex for bit.dll TODO: build equivalent cpath.
--

dofile(mockFoxPath.."/loadMockFox.lua")
--GOTCHA dofile,loadfile redirected to DoFile,LoadFile, see loadMockFox WORKAROUND

DoFile(foxLuaPath.."/init.lua")

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

--DEBUGNOW
--tex TEST
InfCore.PrintInspect(EntityClassDictionary.GetCategoryList(),"GetCategoryList")
InfCore.PrintInspect(EntityClassDictionary.GetClassNameList("Locator"),"GetCategoryList('Locator')")

InfCore.PrintInspect(File.GetFileListTable(),"GetFileListTable")
InfCore.PrintInspect(File.GetReferenceCount(),"GetReferenceCount")

InfCore.PrintInspect(Fox.StrCode32('bleh'),'str32 bleh')
InfCore.PrintInspect(Fox.PathFileNameCode32('bleh'),'path32 bleh')
InfCore.PrintInspect(Fox.PathFileNameCode32('Tpp/start.lua'),'path32 /Tpp/start.lua')

--DEBUGNOW
