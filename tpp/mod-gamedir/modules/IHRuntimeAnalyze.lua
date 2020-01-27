local this={}

function this.PostAllModulesLoad()
	--this.RuntimeAnalyzeClasses()
end

function this.RuntimeAnalyzeClasses()
  --REF comments are just copy of definitions from mockfox I used for reference when writing code
  --most of the rest of the comments is the log output coppied so this also acts as documentation

  InfCore.Log("IHTearDown.RuntimeAnalyzeClasses:")
  local function PrintInfo(object,objectName)
    InfCore.Log("PrintInfo "..objectName..":")
    InfCore.PrintInspect(object,objectName.." Inspect")
    InfCore.PrintInspect(getmetatable(object),objectName.." Inspect metatable")
    InfCore.Log(objectName.." tostring:"..tostring(object))
  end
  --[[

  --InfCore.PrintInspect(Application,"Application")

  --  --InfCore.PrintInspect(getmetatable(Application),"Application metatable")--tex same

  --  --  Application=<1>{

  --  --    AddGame = <function 1>,

  --  --    GetGame = <function 2>,

  --  --    GetGames = <function 3>,

  --  --    GetInstance = <function 4>,

  --  --    GetMainGame = <function 5>,

  --  --    GetScene = <function 6>,

  --  --    RemoveGame = <function 7>,

  --  --    SetMainGame = <function 8>,

  --  --    __call = <function 9>,

  --  --    __index = <function 10>,

  --  --    __newindex = <function 11>,

  --  --    _className = "Application",

  --  --    <metatable> = <table 1>

  --  --  }

  --  InfCore.Log"---"

  local application=Application:GetInstance()

  PrintInfo(application,"application")

  --  application=<userdata 1>

  --  application metatable={

  --    __index = <function 1>,

  --    __newindex = <function 2>,

  --    __tostring = <function 3>

  --  }

  --  application:Application: 0x000000001CD663D0

  InfCore.Log"---"

  local games=application:GetGames()

  PrintInfo(games,"games")

  --  games={

  --    MainGame = <userdata 1>

  --  }

  --  games metatable=nil

  --  games:table: 00000000F8A45880

  InfCore.Log"---"

  --  Game = {

  --    CreateBucket = "<function>",

  --    CreateScene = "<function>",

  --    DeleteBucket = "<function>",

  --    DeleteScene = "<function>",

  --    ExportDataRelationGraph = "<function>",

  --    GetBucket = "<function>",

  --    GetMainBucket = "<function>",

  --    GetScene = "<function>",

  --    PostDataBodyRecreation = "<function>",

  --    PostDataBodyReset = "<function>",

  --    SetMainBucket = "<function>",

  --    SetName = "<function>",

  --    __call = "<function>",

  --    __index = "<function>",

  --    __newindex = "<function>",

  --    _className = "Game"

  --  },



  local mainGame=application:GetGame"MainGame"

  PrintInfo(mainGame,"mainGame")

  --  mainGame=<userdata 1>

  --  mainGame metatable={

  --    __index = <function 1>,

  --    __newindex = <function 2>,

  --    __tostring = <function 3>

  --  }

  --  mainGame:Game: 0x00000000067E21D0

  InfCore.Log"---"

  --  Bucket = {

  --    AddActor = "<function>",

  --    GetEditableDataBodySet = "<function>",

  --    GetEditableDataSet = "<function>",

  --    GetEditableDataSetPath = "<function>",

  --    GetScene = "<function>",

  --    LoadDataSetFile = "<function>",

  --    LoadEditableDataSet = "<function>",

  --    LoadProjectFile = "<function>",

  --    RecreateDataBody = "<function>",

  --    RemoveActor = "<function>",

  --    RemoveAll = "<function>",

  --    SaveEditableDataSet = "<function>",

  --    UnloadDataSetFile = "<function>",

  --    __index = "<function>",

  --    __newindex = "<function>",

  --    _className = "Bucket"

  --  },

  local mainBucket=mainGame:GetMainBucket()

  PrintInfo(mainBucket,"mainBucket")



  local editableDataSet=mainBucket:GetEditableDataSet()-- returns NULL

  PrintInfo(editableDataSet,"editableDataSet")



  --  local dataSetPath="/Assets/tpp/level/mission2/heli/common/heli_common_asset.fox2"

  --  local dataSet=mainBucket:LoadDataSetFile(dataSetPath)--"ERROR Load DataSet file failed!"

  --  PrintInfo(dataSet,"dataSet")



  InfCore.Log"---"

  local mainScene=application:GetScene"MainScene"

  PrintInfo(mainScene,"mainScene")

  --  mainScene=<userdata 1>

  --  mainScene metatable={

  --    __index = <function 1>,

  --    __newindex = <function 2>,

  --    __tostring = <function 3>

  --  }

  --  mainScene:Scene: 0x000000001CE134D0

  InfCore.Log"---"

  --

  --

  --

  --  -- InfCore.PrintInspect(mainGame.ExportDataRelationGraph())--expects entity

  --

  --



  --

  --  --

  InfCore.PrintInspect(mainScene:GetActorList(),"mainScene:GetActorList")

--]]
  --  ----
  --
  InfCore.Log"==="
  --REF
  --  Data = {
  --    GetDataBody = "<function>",
  --    GetDataBodyOnEditing = "<function>",
  --    GetDataBodyWithReferrer = "<function>",
  --    GetDataSet = "<function>",
  --    IsReference = "<function>",
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "Data"
  --  },

  --tex in helispace \chunk3_dat\Assets\tpp\pack\mission2\heli\h40050\h40050_area_fpkd\Assets\tpp\level\mission2\heli\h40050\h40050_sequence.fox2 (or equivalent h40010,h40020 fox2) is loaded
  --it has a DataIdentifier named HelispaceLocatorIdentifier
  --DataIdentifier have key / nameInfArchive paths to other Data / Entities, this is what DataIdentifier.GetDataWithIdentifier used to return a Data entity.
  local identifier="HelispaceLocatorIdentifier"
  --  local locatorName="BuddyQuietLocator"
  local key="BuddyDDogLocator"
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  PrintInfo(data,"data")
  --OUTPUT
  --PrintInfo data:
  --data Inspect=<userdata 1>
  --data Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --data tostring:Locator: 0x000000011624FF40

  InfCore.PrintInspect(data:GetClassName(),"data:GetClassName()")
  --data:GetClassName()="Locator"
  InfCore.PrintInspect(data:GetPropertyList(),"data:GetPropertyList()")
  --data:GetPropertyList()={ "name", "referencePath", "parent", "transform", "shearTransform", "pivotTransform", "inheritTransform", "visibility", "selection", "worldMatrix", "worldTransform", "size" }
  InfCore.PrintInspect(data:GetPropertyInfo("name"),"data:GetPropertyInfo('name')")
  --data:GetPropertyInfo('name')={
  --  arraySize = 1,
  --  container = "StaticArray",
  --  dynamic = false,
  --  export = "RW",
  --  name = "name",
  --  storage = "Instance",
  --  type = "String"
  --}
  --tex as you can see the properties of entites can be accessed with dot notation
  InfCore.PrintInspect(data.name,"data.name")
  --data.name="BuddyDDogLocator"
  InfCore.PrintInspect(data.referencePath,"data.referencePath")
  --data.referencePath="BuddyDDogLocator"


  --InfCore.PrintInspect(data.worldTransform)
  --InfCore.PrintInspect(data.worldTransform.translation)
  --InfCore.PrintInspect(data.worldTransform.translation:GetX())
  --
  --InfCore.PrintInspect(data.worldTransform:GetClassName())
  --InfCore.PrintInspect(data.worldTransform.translation:GetClassName())

  InfCore.Log"==="
  --REF
  --  DataBody = {
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "DataBody"
  --  }

  local dataBody=Data.GetDataBody(data)--GetDataBody(Entity someEntity)
  PrintInfo(dataBody,"dataBody")
  --PrintInfo dataBody:
  --dataBody Inspect=<userdata 1>
  --dataBody Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --dataBody tostring:LocatorBody: 0x0000000115937B40

  InfCore.Log"==="
  -- REF
  --  DataSet = {
  --    GetAllDataList = "<function>",
  --    GetBucket = "<function>",
  --    GetData = "<function>",
  --    GetDataList = "<function>",
  --    GetDataSetFile = "<function>",
  --    GetRootTransformData = "<function>",
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "DataSet"
  --  }

  local dataSet=Data.GetDataSet(data)
  PrintInfo(dataSet,"dataSet")
  --PrintInfo dataSet:
  --dataSet Inspect=<userdata 1>
  --dataSet Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --dataSet tostring:DataSet: 0x000000011624F8F0

  local dataList=dataSet:GetDataList()
  InfCore.PrintInspect(dataList,"dataList")
  --dataList={
  --  BuddyDDogLocator = <userdata 1>,
  --  BuddyQuietLocator = <userdata 2>,
  --  HelispaceLocatorIdentifier = <userdata 3>,
  --  TexturePackLoadConditioner0000 = <userdata 4>,
  --  mission_data = <userdata 5>,
  --  player_locator_0000 = <userdata 6>,
  --  player_locator_0001 = <userdata 7>
  --}
  local allDataList=dataSet:GetAllDataList()
  InfCore.PrintInspect(allDataList,"allDataList")
  --allDataList={
  --  BuddyDDogLocator = <userdata 1>,
  --  BuddyQuietLocator = <userdata 2>,
  --  HelispaceLocatorIdentifier = <userdata 3>,
  --  TexturePackLoadConditioner0000 = <userdata 4>,
  --  mission_data = <userdata 5>,
  --  player_locator_0000 = <userdata 6>,
  --  player_locator_0001 = <userdata 7>
  --}
  local missionData=dataSet:GetData("mission_data")
  PrintInfo(missionData,"mission_data")
  --PrintInfo mission_data:
  --mission_data Inspect=<userdata 1>
  --mission_data Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --mission_data tostring:TppSimpleMissionData: 0x000000011624FA20

  local dataSetFile=DataSet.GetDataSetFile(dataSet)
  PrintInfo(dataSetFile,"dataSetFile")
  --PrintInfo dataSetFile:
  --dataSetFile Inspect=<userdata 1>
  --dataSetFile Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --dataSetFile tostring:DataSetFile2: 0x0000000116250380
  InfCore.Log"==="

  --[[

  --

  --  local doop={}

  --     InfCore.PrintInspect(mainGame.ExportDataRelationGraph(mainGame,doop))--expects Game, arg1 must be a table -- returns nil

  --

  --  InfCore.Log"--------------"

  --

  --  local navWorld=Nav.GetWorld()

  --  InfCore.PrintInspect(navWorld,"navWorld")

  --  InfCore.Log("navWorld="..tostring(navWorld))

  --  InfCore.PrintInspect(getmetatable(navWorld),"navWorld metatable")

  --

  --

  --  local nclDaemon=NclDaemon.GetInstance()

  --  InfCore.PrintInspect(nclDaemon,"nclDaemon")

  --  InfCore.Log("nclDaemon="..tostring(nclDaemon))

  --  InfCore.PrintInspect(getmetatable(nclDaemon),"nclDaemon metatable")

  --  InfCore.PrintInspect(nclDaemon.IsLogin(),"nclDaemon.IsLogin()")

  --

  --  local phDaemon=PhDaemon.GetInstance()

  --  InfCore.PrintInspect(phDaemon,"phDaemon")

  --  InfCore.Log("phDaemon="..tostring(phDaemon))

  --  InfCore.PrintInspect(getmetatable(phDaemon),"phDaemon metatable")

  --  --phDaemon:SetGravity(0.1)





  InfCore.PrintInspect(TppGameSequence.GetGameTitleName(),"GetGameTitleName")

  InfCore.PrintInspect(TppGameSequence.GetPatchVersion(),"GetPatchVersion")

  InfCore.PrintInspect(TppGameSequence.GetShortTargetArea(),"GetShortTargetArea")

  InfCore.PrintInspect(TppGameSequence.GetShortTargetAreaList(),"GetShortTargetAreaList")

  InfCore.PrintInspect(TppGameSequence.GetSpecialVersionName(),"GetSpecialVersionName")

  InfCore.PrintInspect(TppGameSequence.GetTargetArea(),"GetTargetArea")

  InfCore.PrintInspect(TppGameSequence.GetTargetPlatform(),"GetTargetPlatform")

  InfCore.PrintInspect(TppGameSequence.IsMaster(),"IsMaster")



  --GetGameTitleName="TPP"

  --GetPatchVersion=90

  --GetShortTargetArea="ne"

  --GetShortTargetAreaList={ "jp", "ne" }

  --GetSpecialVersionName="unknown"

  --GetTargetArea="NorthAmericaEurope"

  --GetTargetPlatform="Steam"

  --IsMaster=true



  --    NclDaemon = {

  --    GetInstance = "<function>",

  --    IsLogin = "<function>",



  --  navWorld=<userdata 1>

  --navWorld=NavWorldDesc: 0x0000000076016EC0

  --navWorld metatable={

  --  __index = <function 1>,

  --  __newindex = <function 2>,

  --  __tostring = <function 3>

  --}

  --

  --InfCore.PrintInspect(Fox.StrCode32('bleh'), 'str32 bleh')

  --InfCore.PrintInspect(Fox.PathFileNameCode32('bleh'), 'path32 bleh')

  --InfCore.PrintInspect(Fox.PathFileNameCode32('/Tpp/start.lua'), 'path32 /Tpp/start.lua')











  --  local cameraSelector=CameraSelector.GetMainInstance()

  --  InfCore.PrintInspect(cameraSelector,"cameraSelector")--cameraSelector=<userdata 1>

  --  InfCore.Log("cameraSelector:"..tostring(cameraSelector))--cameraSelector:CameraSelector: 0x00000000067E22B0

  --

  --  --tex calling GetRenderName with . instead of : 'ERROR:C:\GamesSD\MGS_TPP\mod\modules\IHTearDown.lua:23: bad argument #1 to 'GetRenderName' (Entity expected, got no value)'

  --  InfCore.PrintInspect(cameraSelector:GetRenderName(),"GetRenderName")--GetRenderName="MainRender"

  --  InfCore.PrintInspect(cameraSelector:GetViewportName(),"GetViewportName")--GetViewportName="MainViewport"

  --

  --  local dump=cameraSelector:DumpActiveCamera()--nil

  --  InfCore.PrintInspect(dump,"dump")

  --  local dump=CameraSelector.DumpActiveCamera()--nil

  --  InfCore.PrintInspect(dump,"dump2")









  --local globalsByType=this.GetGlobalsByType()

  --InfCore.PrintInspect(globalsByType)



  --local keysByType=this.GetModuleKeysByType(globalsByType.table)



  --local plainTextModules=this.GetPlainTextModules(globalsByType.table)

  --InfCore.PrintInspect(plainTextModules,"plainTextModules")--DEBUG



  InfCore.Log("---")

  --DEBUGNOW



  local gameDefaultData=TppDefaultParameter.GetDataFromGroupName("TppEnemyCombatDefaultParameter")

  PrintInfo(gameDefaultData,"gameDefaultData")



  InfCore.Log("---")

  --]]
end


return this