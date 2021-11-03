--!DoAutoDoc.lua
print"!DoAutoDoc.lua"

print"running loadLDT"
local LoadLDT=dofile('D:/GitHub/MockFox/MockFoxLua//loadLDT.lua')
LoadLDT.Load{
  gameId="tpp",
  --tex MockFox host stuff
  luaHostType="LDT",

  foxGamePath="C:/Games/Steam/SteamApps/common/MGS_TPP/",--tex used to reconstruct package.path to what it looks like in mgstpp, IH uses this to get the game path so it can load files in game folder\mod
  --foxGamePath=[[C:\Projects\MGS\InfiniteHeaven\tpp\mod-gamedir-release\]],
  --foxGamePath=[[C:\Projects\MGS\build\infiniteheaven\autodoc\]],

  foxLuaPath=[[C:\Projects\MGS\build\infiniteheaven\autodoc\]],
  --foxLuaPath="C:/Projects/MGS/InfiniteHeaven/tpp/data1_dat-lua/",--tex path of tpps scripts (qar luas) -- IH
  --foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified

  mockFoxPath="D:/GitHub/MockFox/MockFoxLua/",--tex path of MockFox scripts
}

--package.path=package.path..";./nonmgscelua/?.lua"--for AutoDoc

print"Running AutoDoc"
local projectFolder=[[C:\Projects\MGS\InfiniteHeaven\tpp\]]
local outputFolder=[[C:\Projects\MGS\InfiniteHeaven\tpp\mod-gamedir\docs\]]
local featuresOutputName="Features and Options"

local FeaturesHeader=require"FeaturesHeader"

local InfAutoDoc=require"InfAutoDoc"
InfAutoDoc.AutoDoc(projectFolder,outputFolder,FeaturesHeader,featuresOutputName)

print"done"
