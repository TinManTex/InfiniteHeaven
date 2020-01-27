local this={}

function this.DoTests()
  print("MockFoxTests.DoTests")

  --TEST
  local file,error=io.open('c:/doesnotexist.txt','r')
  print(error)


  --DEBUGNOW
  --tex TEST
  --InfCore.PrintInspect(EntityClassDictionary.GetCategoryList(),"GetCategoryList")
  --InfCore.PrintInspect(EntityClassDictionary.GetClassNameList("Locator"),"GetCategoryList('Locator')")
  --
  --InfCore.PrintInspect(File.GetFileListTable(),"GetFileListTable")
  --InfCore.PrintInspect(File.GetReferenceCount(),"GetReferenceCount")

  --InfCore.PrintInspect(Fox.StrCode32('bleh'),'str32 bleh')
  --InfCore.PrintInspect(Fox.PathFileNameCode32('bleh'),'path32 bleh')
  --InfCore.PrintInspect(Fox.PathFileNameCode32('Tpp/start.lua'),'path32 /Tpp/start.lua')
  
  --TEST
  local langId="langId"
  local langId2="langId2"
  local param1=5
  local param2=6

  TppUiCommand.AnnounceLogViewJoinLangId(langId,langId2,param1,param2,0,0,true)


  local langId="langId"
  local langId2="langId2"
  local param1=5
  local param2=6

  TppUiCommand.AnnounceLogViewJoinLangId(langId,langId2,param1,param2,0,0,true)

   print("MockFoxTests.DoTests done")
end

return this