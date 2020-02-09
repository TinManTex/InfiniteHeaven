--!DoAutoDoc.lua
print"!DoAutoDoc.lua"

print"running loadLDT"
local LoadLDT=dofile('../MockFoxLua/loadLDT.lua')
LoadLDT.Load{
  gameId="ssd",
  --tex MockFox host stuff
  luaHostType="LDT",

  foxGamePath=[[D:\Games\Steam\SteamApps\common\METAL GEAR SURVIVE\]],--tex used to reconstruct package.path to what it looks like in mgstpp, IH uses this to get the game path so it can load files in game folder\mod

  foxLuaPath="C:/Projects/MGS/InfiniteHeaven/ssd/data1_dat-lua/",--tex path of tpps scripts (qar luas) -- IH
  --foxLuaPath=[[J:\GameData\MGS\filetype\lua\data1_dat\]]--tex path of tpps scripts (qar luas) -- unmodified

  mockFoxPath="C:/Projects/MGS/InfiniteHeaven/MockFoxLua/",--tex path of MockFox scripts
}

--package.path=package.path..";./nonmgscelua/?.lua"--for AutoDoc

print"Running AutoDoc"
local projectFolder=[[C:\Projects\MGS\InfiniteHeaven\ssd\]]
local outputFolder=[[C:\Projects\MGS\InfiniteHeaven\ssd\mod-gamedir\docs\]]
local featuresOutputName="Features and Options"

local FeaturesHeader=require"FeaturesHeader-ssd"

local InfAutoDoc=require"InfAutoDoc"
InfAutoDoc.AutoDoc(projectFolder,outputFolder,FeaturesHeader,featuresOutputName)

print"done"
