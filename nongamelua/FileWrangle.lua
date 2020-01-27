-- FileWrangle.lua
-- REF files database mess of files.txt
local this={}

--REF
--master/
--  data1.dat
--  chunk{0-4}.dat
--  texture{0-4}.dat
--master/0
--  /00.dat
--  /01.dat
--master/1/MGSVTUPDATEV0110/0/
--  /00.dat
--  /01.dat
--
--mgo/
--  chunk0.dat
--  texture0.dat

local dataPathRoot=[[J:\GameData\MGS_TPP_1100]]
local extractPathRoot=[[J:\GameData\MGS_EXTRACT]]
local tppPath="\master"
local mgoPath="\mgo"


local basePath=[[J:\GameData\MGS\!!masternew\]]
local outputPath=[[D:\Projects\MGS\]]

--TODO: get all filetypes
--break down by: game (gz,tpp,mgo)
--by archive? data1, cunkN, fpk, fpkd ? thats getting too granular, will be able to pull that together once have full file info

--fileTypes=archive,asset,data ?

--Atv = note on file type from Atvaarks github
local extensionTools={
  bnd="foxTool",--Atv - Graph Bounder Data
  clo="foxTool",--Atv - Sim Cloth Setting
  dat="gzsTool",--,qarTool--Qar archive
  des="foxTool",--Atv - Destruction
  evf="foxTool",--Atv - Event
  ffnt="ffntTool",--Atv - Bitmap font
  fox2="foxTool",--Atv - Scene
  fpk="gzsTool",--,fpkTool--Archive, fox package (?)
  fpkd="gzsTool",--,fpkTool--Archive, fox package data(?)
  fsd="foxTool",--Atv - Facial Settings Dats
  ftex="ftexTool",--Fox texture
  ftexs="ftexTool",--Fox texture ?
  json="textEditor",--JavaScript Object Notation
  lad="foxTool",--Atv - Lip Adjust Data
  lng="langTool",--Language localization strings
  lng2="langTool",--Language localization strings
  lua="scriptEditor",--Lua script
  mtar="mtarTool",--Motion archive
  parts="foxTool",--Parts definition, xml - Model Description,FoxTargetDescription(s),PhysicsDescription,SoundDescription,SimDescription,EffectDescription(s) - references other assets and data
  pftxs="gzsTool",--Texture archive, package fox textures (?)
  ph="foxTool",--Atv - Physics Object Description
  phsd="foxTool",--Atv - Physics Sound Parameter
  sbp="gzsTool",--Sound archive, sound bank package
  sdf="foxTool",--Atv - Sound Data File Info
  sim="foxTool",--Atv - Simulation Object
  sub="subpTool",--Subtitles
  subp="subpTool",--Subtitles, subtitle package (?)
  tgt="foxTool",--Atv - Geometry Target Description
  vdp="foxTool",--Atv - Vehicle Driving Parameter
  veh="foxTool",--Atv - Vehicle
  vfxlf="foxTool",--Atv - Visual Effects Lense Flare
}
--xml="texteditor",--tex output by various tools as intemediary between their formats TODO: does GZ have any pure xml files?

--REF
--in mtars
--.gani: MGSV's animation format.
--.trk: Description of all main animation tracks for an Mtar Type 2 file.
--.chnk: A chunk of data with an unknown purpose belonging to an Mtar Type 2 file.
--.exchnk: An extra chunk of animation tied to a .gani file from an Mtar Type 2 file. If the .gani file is swapped this should be brought along with it.
--.enchnk: A chunk of animation at the bottom of an Mtar Type 2 file. Tied to a .gani file. Should be brought along with a swapped .gani file.

--REF
--init.lua
--AssetConfiguration.RegisterExtensionInfo{
--  extensions={"bnk","col","demo","demox","dfrm","evb","fclo","fcnp","fdes","fmdl","fmdlb","info","fpk","fpkd","frdv","frig","fstb","ftex","ftexs","gani","lani","mtar","mtard","caar","geom","gskl","nav","nav2","sani","sand","mog","fv2","cani","fmtt","lpsh","ffnt","fova","pftxs","frl","frld","frt","atsh","pcsp","uia","uif","uilb","uigb","fnt","rdf","nta","subp","lba","ladb","lng"},
--  categories={"Target"}
--}
--AssetConfiguration.RegisterExtensionInfo{extensions={"sad","evfl"},categories={"Language"}}
--AssetConfiguration.RegisterExtensionInfo{extensions={"sbp","stm","mas","wem","fsm"},categories={"Target","Language"}}
--start.lua
--AssetConfiguration.RegisterExtensionInfo{extensions={"tetl","tmss","tmsl","tlsp","tmsu","tmsf","twpf","adm","tevt","vpc","ends","spch","mbl"},categories={"Target"}}


local tools={
  gzsTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\GzsTool\GzsTool.exe]],
    url=[[https://github.com/Atvaark/GzsTool]],
    dictionaryUrl=[[https://github.com/emoose/MGSV-QAR-Dictionary-Project]],
    --TODO: what is fpk_dictionary for?
  },
  foxTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\FoxTool\FoxTool.exe]],
    url=[[https://github.com/Atvaark/FoxTool]],
    --TODO: foxtool has a dictionary, what for?
  },
  langTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\FoxEngine.TranslationTool.v0.2.4\LangTool.exe]],
    url=[[https://github.com/Atvaark/FoxEngine.TranslationTool]],
    dictionaryUrl=[[https://github.com/cstBipBop/MGSV-Lang-Dictionary-Project]],
  },
  subpTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\FoxEngine.TranslationTool.v0.2.4\SubpTool.exe]],
    url=[[https://github.com/Atvaark/FoxEngine.TranslationTool]],
  },
  ffntTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\FoxEngine.TranslationTool.v0.2.4\FfntTool.exe]],
    url=[[https://github.com/Atvaark/FoxEngine.TranslationTool]],
  },
  ftexTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\FtexTool.v0.3.2\FtexTool.exe]],
    url=[[https://github.com/Atvaark/FtexTool]],
  },
  mtarTool={
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\MtarTool.v0.2\MtarTool.exe]],
    url=[[https://github.com/BobDoleOwndU/MtarTool]],
    --dictionaryUrl=[[]],
  },
  qarTool={--MGSV QAR Tool, Sergeanur
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\MGSV_QAR_Tool.v1.3.3\MGSV_QAR_Tool.exe]],
    url=[[http://forum.xentax.com/viewtopic.php?f=10&t=12407&p=124477#p124477]],
    dictionaryUrl=[[https://github.com/emoose/MGSV-QAR-Dictionary-Project]],
  },
  fpkTool={--MGSV FPK Tool, Sergeanur
    toolPath=[[D:\Projects\MGS\MGSVTOOLS\MGSV_FPK_Tool.v1.2\MGSV_FPK_Tool.exe]],
    url=[[http://forum.xentax.com/viewtopic.php?f=10&t=12407&p=110644#p110644]],
    dictionaryUrl=[[https://github.com/emoose/MGSV-QAR-Dictionary-Project]],
  },
}

local function GetFilesOfType(basePath,outputPath,extension)
  local dirsFileName=outputPath..extension.."FileDirs.txt"
  local fileNamesCountTxtPath=outputPath..extension.."FileNamesCount.txt"

  local searchPattern="*."..extension

  local command=string.format([[dir /s /b %s%s > %s]],basePath,searchPattern,dirsFileName)
  print(command)
  os.execute(command)

  local fileDirs={}

  local dirsFile,error=io.open(dirsFileName,"r")
  if dirsFile then
    while true do
      local line=dirsFile:read()
      if line==nil then break end
      table.insert(fileDirs,line)
    end
    dirsFile:close()
  end


  local fileNameCounts={}
  local fileNamesAndPaths={}
  for i,filePath in ipairs(fileDirs)do
    local split=Util.Split(filePath,"\\")
    local fileName=split[#split]
    fileNameCounts[fileName]=fileNameCounts[fileName] or 0
    fileNameCounts[fileName]=fileNameCounts[fileName]+1
    table.remove(split,#split)
    fileNamesAndPaths[fileName]=table.concat(split)
  end


  local fileNames={}
  for fileName,count in pairs(fileNameCounts)do
    table.insert(fileNames,fileName)
  end




  table.sort(fileNames)

  --   local ins=InfInspect.Inspect(fileNameCounts)
  --  print(ins)

  local fileNameCountsTxt={}
  for i,fileName in ipairs(fileNames)do
    local fileNameCountTxt=fileName.."="..fileNameCounts[fileName]
    print(fileNameCountTxt)
    table.insert(fileNameCountsTxt,fileNameCountTxt)
  end

  local f=io.open(fileNamesCountTxtPath,"w")
  f:write(table.concat(fileNameCountsTxt,"\n"))
  f:close()

  --  local f=io.open(fileNamesTxtPath,"w")
  --  for i,fileName in ipairs(fileNames)do
  --    print(fileName)
  --    f:write(fileName,"\n")
  --  end
  --  f:close()
end

--tex copies files in file list into a root folder/removes all folder structure
function this.CopyCrush(destination,extension,fileList)
  --REF destination J:\GameData\MGS\filetypecrushed\
  local command=string.format([[mkdir %s%s]],destination,extension)
  print(command)
  os.execute(command)

  print("copying "..#fileList.." files")
  for i,filePath in ipairs(fileList)do
    local command=string.format([[copy %s %s%s]],filePath,destination,extension)
    print(command)
    os.execute(command)
  end
end

function this.RunTool(toolPath,fileList)
  print("running "..toolPath.." on"..#fileList.." files")
  for i,filePath in ipairs(fileList)do
    local command=string.format([[%s %s]],toolPath,filePath)
    print(command)
    os.execute(command)
  end
end

return this
