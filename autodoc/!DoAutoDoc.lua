--!DoAutoDoc.lua
local mockFoxPath="D:/GitHub/MockFox/MockFoxLua/"--tex path of MockFox scripts
local foxGamePath="C:/Games/Steam/SteamApps/common/MGS_TPP/"--tex used to reconstruct package.path to what it looks like in mgstpp, IH uses this to get the game path so it can load files in game folder\mod"
local foxLuaPath=[[C:\Projects\MGS\build\infiniteheaven\autodoc\]]--tex path of tpps scripts (qar luas) -- IH

print"!DoAutoDoc.lua"

print"running loadLDT"
local LoadLDT=dofile(mockFoxPath..'loadLDT.lua')
LoadLDT.Load{
  gameId="tpp",
  --tex MockFox host stuff
  luaHostType="LDT",

  foxGamePath=foxGamePath,
  --foxGamePath=[[C:\Projects\MGS\InfiniteHeaven\tpp\mod-gamedir-release\]],
  --foxGamePath=[[C:\Projects\MGS\build\infiniteheaven\autodoc\]],

  foxLuaPath=foxLuaPath,
  --foxLuaPath="C:/Projects/MGS/InfiniteHeaven/tpp/data1_dat-lua/",
  --foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified

  mockFoxPath=mockFoxPath,
}

--package.path=package.path..";./nonmgscelua/?.lua"--for AutoDoc

print"Running AutoDoc"
local profilesFolder=[[C:\Projects\MGS\InfiniteHeaven\tpp\gamedir-ih\mod\]]
local docsFolder=[[C:\Projects\MGS\InfiniteHeaven\tpp\gamedir-ih\mod\docs\Infinite Heaven\]]
local featuresOutputName="Features and Options"

local FeaturesHeader=require"FeaturesHeader"

local InfAutoDoc=require"InfAutoDoc"
InfAutoDoc.AutoDoc(docsFolder,profilesFolder,FeaturesHeader,featuresOutputName)

print"done"
