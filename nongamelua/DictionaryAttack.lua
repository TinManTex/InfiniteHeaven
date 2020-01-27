local t,tD,math_random,os_time,os_execute,io_open,dL,file,startIdCount={},{},math.random,os.time,os.execute,io.open;file=io_open("newDict.txt");math.randomseed(os_time());math_random()
for line in file:lines() do
   t[#t+1]=line
end
startIdCount=#t
file=io_open("dictList.txt")
for line in file:lines() do
   tD[#tD+1]=line
end
dL=#tD
os_execute[["type nul>lang_dictionary.txt"]]
os_execute[["for /r %G in (*.lng?) do (LangTool.exe "%G")"]]

local function table_count(argTable,argEntry)
   local count=0
   for i=1,#argTable do
      if argEntry==argTable[i] then
         count=count+1
      end
   end
   return count
end


local function table_unique(t1,t2)
   local t3,indice={},#t2
   for i=1,#t1 do
      indice=indice+1
      t2[indice]=t1[i]
   end
   indice=#t3
   for i=1,#t2 do
      if(table_count(t3,t2[i])==0) then
         indice=indice+1
         t3[indice]=t2[i]
      end
   end
   return t3
end


local function runLangTool()
   local m,indice,file={},0,"tempIdComp.txt"
   os_execute[["for /r %G in (*.lng?) do (LangTool.exe "%G")"]]
   os_execute[["findstr /r "LangId" *.xml>tempIdComp.txt"]]
   file=io_open(file)
   for line in file:lines() do
      indice=indice+1
      m[indice]=line
   end
   for i=1,#m do
      m[i]=(m[i]:match(".*LangId=.([a-z,A-Z,0-9,_]*).*"))
   end
   m=table_unique(m,t)
   return m
end


local function bruteForce()
   local string_char,count,file,tASCII,a,b,c,d,e,f,g,indice,s=string.char,0,io_open("lang_dictionary.txt","w"),{"",_};indice=#tASCII
   for i=97,122 do
      indice=indice+1
      tASCII[indice]=string_char(i)
   end
   local prefix="mb_staff_"
   local breakOn="mb_staff_zzzzzzz"
   
   for i=1,indice do a=tASCII[i]
      for i=1,indice do b=tASCII[i]
         for i=1,indice do c=tASCII[i]
            for i=1,indice do d=tASCII[i]
               for i=1,indice do e=tASCII[i]
                  for i=1,indice do f=tASCII[i]
                     for i=1,indice do g=tASCII[i]
                        s=prefix..a..b..c..d..e..f..g
                        file:write(s,"\n")
                        count=count+1
                        if count==14e5 or s==breakOn then
                           count=0
                           file:flush(); file:close()
                           local m=runLangTool()
                           file=io_open("newDict.txt","w")
                           for i=1,#m do
                              file:write(m[i],"\n")
                           end
                           file:flush(); file:close()
                           file=io_open("newDict.txt")
                           t={}
                           for line in file:lines() do
                              t[#t+1]=line
                           end
                           if s=="mb_staff_zzzzzzz" then
                              os.exit(exit)
                           end
                           file=io_open("lang_dictionary.txt","w")
                        end
                     end
                  end
               end
            end
         end
      end
   end
end


local function dictionaryAttack()
   local startOfScript,file=os_time(),io_open("lang_dictionary.txt","w")
   while true do
      if os_time()>=startOfScript+1 then file:flush(); file:close(); break end
      local a,b--,c
      a=tD[math_random(dL)]
      b=tD[math_random(dL)]
      --c=tD[math_random(dL)]
      file:write("mb_staff_"..a.."_"..b,"\n")
   end
end


while true do
   dictionaryAttack()
   --bruteForce()
   local m=runLangTool()
   local file=io_open("newDict.txt", "w")
   for i=1,#m do
      file:write(m[i],"\n")
   end
   file:flush(); file:close()
   file=io_open("newDict.txt")
   t={}
   for line in file:lines() do
      t[#t+1]=line
   end
end



-------
-- LangDictionary.lua
local this={}

local lngFolder=[[J:\GameData\MGS\lng\]]
local langToolFolder=[[D:\Games\[Utils]\[MGSV]\MGSVTOOLS\FoxEngine.TranslationTool v0.2.4\]]
local dictionaryTableFileName="dictionaryTable.lua"
--[[
theres lng and lng2 files

robocopy all master lng to a seperate folder
ROBOCOPY J:\GameData\MGS\!!masternew J:\GameData\lng *.lng /S
robocopy all patch lng to seperate folder

LngToXML
> rename langtool dictionary to .original
> all lng through langtool
--]]

local dictionary={
  hashToKey={},
  keyToHash={},
}

function this.GetLngFileNames()
  local xmlFileNamesFile=lngFolder.."xmlfileNames.txt"

  local extension="*.xml"
  local command=string.format('dir /b /s "%s%s" >"%s"',lngFolder,extension,xmlFileNamesFile)
  print(command)
  os.execute(command)
  
--  local xmlFileNames={}
--  
--  local file,error=io.open(xmlFileNamesFile,"r")
--  if not file then
--    print(error)
--    return nil
--  end
--
--  while true do
--    local line=file:read()
--    if line==nil then break end
--   
--     xmlFileNames[#xmlFileNames+1]=line
--     --print(line)--DEBUG
--  end
--   
--  file:close()
--  
--  return xmlFileNames
end


function this.GetHashesFromXMLs(xmlFileNames,dictionary)
  if xmlFileNames==nil or #xmlFileNames==1 then
    print("xmlFileNames empty")
    return
  end

  if dictionary==nil then
    dictionary={
      hashToKey={},
      keyToHash={},
    }
  end
  
  --for i,fileName in ipairs(xmlFileNames) do
  local fileName=xmlFileNames[1]--DEBUG
    print(fileName)
    local file,error=io.open(fileName,"r")
    if not file then
      print(error)
    else
      while true do
        local line=file:read()
        if line==nil then break end
        
        local s,e=string.find(line,'Key="')
        if e then
          local startIndex=e+1
          local s,e=string.find(line,'"',startIndex)
          local endIndex=s-1
          local hash=string.sub(line,startIndex,endIndex)
          --DEBUG
          --print(line)
          --print(hash)
          if dictionary.hashToKey[hash] then
            print("existing hash in dictionary: "..hash..":"..dictionary.hashToKey[hash])
          end
          
          dictionary.hashToKey[hash]=dictionary.hashToKey[hash] or -1
        end
      end
      file:close()
    end 
  --end
  
  --DEBUG
  local ins=InfInspect.Inspect(dictionary)
  print(ins)
  return dictionary
end

function this.Run()
  local xmlFileNames=this.GetLngFileNames()
 

  

    --local dictionary,error=pcall(InfPersistence.Load("nqh"))--lngFolder..dictionaryTableFileName)
 
  

  --dictionary=this.GetHashesFromXMLs(xmlFileNames,dictionary)
   -- local ins=InfInspect.Inspect(dictionary)
  --print(ins)
  --InfPersistence.Store(lngFolder..dictionaryTableFileName,dictionary)
end

--[[


GetHashes

persistance load hashToKeyName table

for each lng
for each line
startindex= find 'Key="' ??
endindex=find '"'
 hash=start>end
 hashToKeyName[hash]=hashToKeyName[hash] or -1




analysist

list of just the keynames sorted alpha
--]]



---bipbops
--math.randomseed(os.time())
--math.random()
--local file=io.open("newDict.txt")
--local t={}
--for line in file:lines() do
--   t[#t+1]=line
--end
--os.execute[["type nul>lang_dictionary.txt"]]
--os.execute[["for /r %G in (*.lng?) do (LangTool.exe "%G")"]]
--
--local function table_count(argTable,argEntry)
--  local count
--  count=0
--  for _,v in pairs(argTable) do
--    if argEntry==v then
--       count=count+1
--    end
--  end
--  return count
--end
--
--local function table_unique(idTable,fullTable)
--  local newTable
--  newTable={}
--  for _,v in pairs(fullTable) do
--     idTable[#idTable+1]=v
--  end
--  for _,v in ipairs(idTable) do
--    if(table_count(newTable,v)==0) then
--      newTable[#newTable+1]=v
--    end
--  end
--  return newTable
--end
--
--
--local function dictionaryAttack()
--   local startOfScript=os.time()
--   local fileIn=io.open("dictList.txt")
--   local fileOut=io.open("lang_dictionary.txt", "w")
--   local t={}
--   for line in fileIn:lines() do
--      t[#t+1]=line
--   end
--   local d=#t
--
--   while true do
--      if os.time()>=startOfScript+1 then fileOut:flush(); fileOut:close(); break end
--      local a,b --,c
--      a=t[math.random(d)]
--      b=t[math.random(d)]
--      --c=t[math.random(d)]
--      fileOut:write("announce".."_"..a.."_"..b, "\n")
--   end
--end
--
--local function runLangTool()
--   local tC={}
--   local m={}
--   local file="tempIdComp.txt"
--   --os.execute[["for /r %G in (*.lng?) do (LangTool.exe "%G")"]]
--   os.execute[["LangTool.exe tpp_announce_log.eng.lng2"]]
--   os.execute[["LangTool.exe tpp_fob.eng.lng2"]]
--   os.execute[["findstr /r "LangId" *.xml>tempIdComp.txt"]]
--   file=io.open(file)
--   for line in file:lines() do
--      tC[#tC+1]=line
--   end
--   for _,v in pairs(tC) do
--      m[#m+1]=(v:match(".*LangId=.([a-z,A-Z,0-9,_]*).*"))
--   end
--   for i=1,#tC do
--      tC[#tC+1]=nil
--   end
--   m=table_unique(m,t)
--   return m
--end
--
--while true do
--   dictionaryAttack()
--   local m=runLangTool()
--   local file=io.open("newDict.txt", "w")
--   for _,v in pairs(m) do
--      file:write(v,"\n")
--   end
--   file:flush(); file:close()
--   file=io.open("newDict.txt")
--   t={}
--   for line in file:lines() do
--      t[#t+1]=line
--   end
--end

return this