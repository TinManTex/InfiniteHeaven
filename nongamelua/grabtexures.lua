--grabtextures.lua
--tex for given lists of unhashed and hashed texture pathnames (output from fmdltool for a fmdl), copy textures from an input extracted pftx path and extracted texture dat (assumption textures needed in one dat)
--to outputpftx path and outputdat path
--if user wants to work with the textures they can manually combine the two in order for ftex tool to work (since it needs all ftex parts)

local this={}
local InfUtil=this

local open=io.open

luaHostType="LDT"

local hashNamesFilePath=[[D:\Projects\MGS\!SubMods\ModelSwaps\pfs\pfs0_main0_def.fmdl_textureHashes_unmatchedHashes.txt]]
local namesFilePath=[[D:\Projects\MGS\!SubMods\ModelSwaps\pfs\qar_dictionary_matchedStrings.txt]]
local extractedPftxPath=[[D:\Projects\MGS\!SubMods\ModelSwaps\pfs\pfs packs\mis_com_mafr_pftxs]]
local extractedTextureDatPath=[[J:\GameData\MGS\!master\texture0_dat]]
local outputPftxTextures=[[D:\Projects\MGS\!SubMods\ModelSwaps\pfs\textures\pftx\]]
local outputDatTextures=[[D:\Projects\MGS\!SubMods\ModelSwaps\pfs\textures\dat\]]

function this.Split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

function this.GetLines(fileName)
  --return InfCore.PCall(function(fileName)
  local lines
  local file,openError=open(fileName,"r")
  if file then
    if not openError then
      --tex lines crashes with no error, dont know what kjp did to io
      --      for line in file:lines() do
      --        if line then
      --          table.insert(lines,line)
      --        end
      --      end

      lines=file:read("*all")
    end
    file:close()
    if lines then
      if luaHostType=="LDT" then--DEBUGNOW KLUDGE differences in line end between implementations
        lines=InfUtil.Split(lines,"\n")
      else
        lines=InfUtil.Split(lines,"\r\n")
      end
      if lines[#lines]=="" then
        lines[#lines]=nil
      end
    end
  end
  return lines
    --end,fileName)
end

--TODO: get dir extractedPftxPath > extractedPftxPaths --tex os level only considers the extension to be the last . , but we are looking for <name>.1.ftex,<name>.2.ftex ...


local allTextureNames={}
local textureNames=this.GetLines(hashNamesFilePath)
for i,name in ipairs(textureNames)do
  table.insert(allTextureNames,name)
end
local textureNames=this.GetLines(namesFilePath)
for i,name in ipairs(textureNames)do
  table.insert(allTextureNames,name)
end

local foundTextures={}
local notFoundTextures={}



local cmd=[[dir /s /b "]]..extractedPftxPath..[[\*.*" > "]]..outputPftxTextures.."extractedpftxfiles.txt"..[["]]
print(cmd)
os.execute(cmd)

--local extractedFiles=this.GetLines(outputPftxTextures.."extractedpftxfiles.txt")
--local textureNames=this.GetLines(hashNamesFilePath)
--print(#textureNames.." texurenames")
--for i,name in ipairs(textureNames)do
--  for i,filePath in ipairs(extractedFiles) do
--    --if find(filePath,name) then os.exec copy filePath outputPftxTextures
--    if string.find(filePath,name..[[.]]) then
--      print(filePath)
--      foundTextures[name]=true
--      local cmd="copy "..filePath.." "..outputDatTextures
--    end
--  end
--end
--
--local notFoundTextures={}
--for i,name in ipairs(textureNames)do
--  if not foundTextures[name] then
--    notFoundTextures[name]=true
--  end
--end

local cmd=[[dir /s /b "]]..extractedTextureDatPath..[[\*.*" > "]]..outputDatTextures.."extracteddatfiles.txt"..[["]]
os.execute(cmd)

local extractedFiles=this.GetLines(outputDatTextures.."extracteddatfiles.txt")

for i,name in ipairs(allTextureNames)do
  for i,filePath in ipairs(extractedFiles) do
    --if find(filePath,name) then os.exec copy filePath outputPftxTextures
    local filePath=string.gsub(filePath,"\\","/")
    if string.find(filePath,name..[[.]]) then
      print(filePath)
      foundTextures[name]=true
      local cmd="copy "..filePath.." "..outputDatTextures
      print(cmd)
      --os.execute(cmd)
    end
  end
end

for i,name in ipairs(allTextureNames)do
  if not foundTextures[name] then
    notFoundTextures[name]=true
  end
end

local notFoundCount=0
print("not found:")
for name,bool in pairs(notFoundTextures)do
  notFoundCount=notFoundCount+1
  print(name)
end
print("not found:"..notFoundCount)
