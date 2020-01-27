--DictionaryAttack.lua
local this={}

local nl="\r"
function this.WriteStringTable(fileName,strings)
  local file=io.open(fileName,"w")
  --file:write(table.concat(strings,nl))
  for i,string in ipairs(strings)do
    file:write(string,nl)
  end
  file:close()
end

--local InfInspect=dofile([["D:\Projects\MGS\!InfiniteHeaven\!modlua\nonmgscelua\InfInspect.lua"]])--DEBUGNOW

--luaHostType="LDT"

function this.Split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

function this.GetLines(fileName)

  local lines
  local file,openError=io.open(fileName,"r")
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
        lines=this.Split(lines,"\n")
      else
        lines=this.Split(lines,"\r\n")
      end
      if lines[#lines]=="" then
        lines[#lines]=nil
      end
    end
  end
  return lines
end


local function BreakIntoWordsByOrder(path,delim)
  local wordsUnique={}
  print(path)
  local file=io.open(path,"r")
  for line in file:lines() do
    local split=this.Split(line,delim)
    for i,word in ipairs(split) do
      wordsUnique[i]=wordsUnique[i] or {}
      wordsUnique[i][word]=true
    end
  end
  file:close()

  local wordsFinal={}
  for i,words in ipairs(wordsUnique)do
    wordsFinal[i]=wordsFinal[i] or {}
    for word,bool in pairs(words)do
      table.insert(wordsFinal[i],word)
    end
    table.sort(wordsFinal[i])
  end

  return wordsFinal
end

--tex to keep GenerateString simple and only have it churn through string lists
--we generate number words prior
function this.GenerateNumWords(numFormat,maxNum)
  print("Generating "..maxNum.." numWords")
  local numWords={}
  for i=0,maxNum do
    numWords[#numWords+1]=string.format(numFormat,i)
  end
  return numWords
end

local alphabet={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
local numbers={'0','1','2','3','4','5','6','7','8','9'}
local characters={'_','-'}
local charSet={}
for i,char in ipairs(alphabet)do
  charSet[#charSet+1]=char
  charSet[#charSet+1]=string.lower(char)
end
for i,char in ipairs(numbers)do
  charSet[#charSet+1]=char
end
for i,char in ipairs(characters)do
  charSet[#charSet+1]=char
end

--tex recursively builds a string using a table of lists words, with the table index being depth/word number in string
function this.GenerateString_r(maxDepth,words,wordDelim,currentString,currentDepth,strings,recurseState,batchCount,fileCount,fileName,outPath)
  local startIndex=1--DEBUGNOW recurseState[currentDepth] or 1
  currentDepth=currentDepth+1
  --tex adds string from each depth (which otherwise wouldnt) as well as final string
  strings[#strings+1]=currentString
      
--  if batchCount>0 and (#strings>batchCount) then
--    fileCount=fileCount+1
--    local recurseStateString=" recurseState: "
--    for i,currentIndex in ipairs(recurseState)do
--      --DEBUGNOW recurseStateString=recurseStateString.." "..tostring(recurseState[currentDepth])
--    end
--    print("Gen"..fileName..fileCount..recurseStateString)
--    print(#strings)
--    local file=io.open(outPath.."GEN"..fileName..fileCount..".txt","w")
--    file:write(table.concat(strings,nl))
--    --    for i,string in ipairs(strings)do
--    --      file:write(string,nl)
--    --    end
--    file:close()
--    strings={}
--  end
  
  if currentDepth>maxDepth then
  else
    local wordTable=words
    if type(wordTable[1])=="table" then
      wordTable=words[currentDepth]
    end

    for i=startIndex,#wordTable do
      local word=wordTable[i]
      --tex cant add directly to currentString since we are looping
      --instead we build a new currentString using the last recursion levels
      local partialString
      if currentDepth==1 then
        partialString=word
      else
        partialString=currentString..wordDelim..word
      end
      this.GenerateString_r(maxDepth,words,wordDelim,partialString,currentDepth,strings,recurseState,batchCount,fileCount,fileName,outPath)
      recurseState[currentDepth]=i--tex save off current index to allow resume
    end
  end
end

--local wordNum=1
--for word1Num,word1 in ipairs(words[wordNum]) do
--  local word1String=word1
--  wordNum=2
--  for word2Num,word2 in ipairs(words[wordNum]) do
--    local word2String=word1String..wordDelim..word2
--    wordNum=3
--    for word3Num,word3 in ipairs(words[wordNum]) do
--      local word3String=word2String..wordDelim..word3
--      wordNum=4
--      for word4Num,word4 in ipairs(words[wordNum]) do
--        local word4String=word3String..wordDelim..word4
--        strings[#strings+1]=word4String
--      end
--    end
--  end
--end

local function Prepend(path,prefix,outpath)
  print("Prepend "..path.." "..prefix)
  local wordsUnique={}
  local file=io.open(path,"r")
  for line in file:lines() do
    wordsUnique[line]=true
  end
  file:close()

  local strings={}
  for word,bool in pairs(wordsUnique)do
    table.insert(strings,prefix..word)
  end
  table.sort(strings)

  local nl="\r"
  local file=io.open(outpath,"w")
  --file:write(table.concat(strings,nl))
  for i,string in ipairs(strings)do
    file:write(string,nl)
  end
  file:close()
end


function this.GenerateFromFormat(fmt,count)
  local strings={}
  for i=0,count do
    strings[#strings+1]=string.format(fmt,i)
  end
  return strings
end


--LoadWords
local words={}
--for i=1,maxWords do
--  --words[i]={}
--  local path=wordsPath..fileName..i..".txt"
----  local file=io.open(path,"r")
----  for line in file:lines() do
----    table.insert(words[i],"-"..line.."|")
----  end
----  file:close()
--
--  words[i]=this.GetLines(path)
--end

--local ins=InfInspect.Inspect(words)--DEBUGNOW
--print(ins)

--SKL_nnn_<dict words>
--dict words count usually 2 (SKL_704_EYERROOT_HLP)
--but dict words may be object name + word (SKL_030_cran001_vrtn002_HLP)
local sklGenFormat={
  "word",
  "word",--{numFormat="%03d",maxNum=999},
  "word",
  {"AVAT_"},--PATCH
  --"word",
  wordDelim="_",
}
local fileName="SKLnames"
local stringGenFormat=sklGenFormat

local meshGenFormat={
  "word",
  {numFormat="%02d",maxNum=99},
  wordDelim="_",
}
local meshGenFormat={
  "word",
  "word",
  "word",
  wordDelim="_",
}
--local fileName="MESHnames"
--local stringGenFormat=meshGenFormat

local inPath=[[D:\Projects\MGS\!ToolOutput\]]..fileName..[[.txt]]
local outpath=[[D:\Projects\MGS\!ToolOutput\]]

words=BreakIntoWordsByOrder(inPath,stringGenFormat.wordDelim)

for i,wordInfo in ipairs(stringGenFormat)do
  if type(wordInfo)=="table"then
    if wordInfo.numFormat then
      words[i]=this.GenerateNumWords(wordInfo.numFormat,wordInfo.maxNum)
    else
      for j,addString in ipairs(wordInfo)do
        table.insert(words[i],addString)
        table.insert(words[i],string.lower(addString))
      end
    end
  else
    --if i>1 then--DEBUGNOW
    if wordInfo=="word" then
      for j,word in ipairs(alphabet)do
        table.insert(words[i],word)
      end
      local wordsLower={}
      for j,word in ipairs(words[i])do
        wordsLower[#wordsLower+1]=string.lower(word)
      end
      for j=0,9 do
        table.insert(words[i],j)
      end
      for j,word in ipairs(wordsLower)do
        table.insert(words[i],word)
      end
    end
    --end
  end
end

print("generating strings")
local maxWords=#stringGenFormat
local strings={}
local recurseState={}
local maxStringsPerFile=100000
local linesDone=0

this.GenerateString_r(maxWords,words,stringGenFormat.wordDelim,"",0,strings,recurseState)
print(#strings.." strings generated")

local file=io.open(outpath.."GEN"..fileName..".txt","w")
--file:write(table.concat(strings,nl))
for i,string in ipairs(strings)do
  file:write(string,nl)
end
file:close()
--]]

--local inPath=[[D:\Projects\MGS\!ToolOutput\fmdl_dictionary.txt]]
--local outPath=[[D:\Projects\MGS\!ToolOutput\fmdl_dictionaryMESH.txt]]
--local prefix="MESH_"
--Prepend(inPath,prefix,outPath)--DEBUGNOW

print("generating strings")
local fileCount=0
local fileName="Brute"
local strings={}
local maxWords=3
local words=charSet
this.GenerateString_r(maxWords,words,"","",0,strings,recurseState,maxStringsPerFile,fileCount,fileName,outpath)
print(#strings.." strings generated")

local file=io.open(outpath.."GEN"..fileName..".txt","w")
file:write(table.concat(strings,nl))
--for i,string in ipairs(strings)do
--  file:write(string,nl)
--end
file:close()



--DEBUGNOW
--
local animalsTable={
  Goat={type="TppGoat",locatorFormat="anml_goat_%02d",routeFormat="rt_anml_goat_%02d",nightRouteFormat="rt_anml_goat_n%02d",isHerd=true,isDead=false},
  Wolf={type="TppWolf",locatorFormat="anml_wolf_%02d",routeFormat="rt_anml_wolf_%02d",nightRouteFormat="rt_anml_wolf_n%02d",isHerd=true,isDead=false},
  Nubian={type="TppNubian",locatorFormat="anml_nubian_%02d",routeFormat="rt_anml_nubian_%02d",nightRouteFormat="rt_anml_nubian_n%02d",isHerd=true,isDead=false},
  Jackal={type="TppJackal",locatorFormat="anml_jackal_%02d",routeFormat="rt_anml_jackal_%02d",nightRouteFormat="rt_anml_jackal_n%02d",isHerd=true,isDead=false},
  Zebra={type="TppZebra",locatorFormat="anml_Zebra_%02d",routeFormat="rt_anml_Zebra_%02d",nightRouteFormat="rt_anml_Zebra_n%02d",isHerd=true,isDead=false},
  Bear={type="TppBear",locatorFormat="anml_bear_%02d",routeFormat="rt_anml_bear_%02d",nightRouteFormat="rt_anml_bear_n%02d",isHerd=false,isDead=false},
  BuddyPuppy={type="TppBuddyPuppy",locatorFormat="anml_BuddyPuppy_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false},
  MotherDog={type="TppJackal",locatorFormat="anml_MotherDog_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=true},
  Rat={type="TppRat",locatorFormat="anml_rat_%02d",routeFormat="rt_anml_rat_%02d",nightRouteFormat="rt_anml_rat_%02d",isHerd=false,isDead=false},
  NoAnimal={type="NoAnimal",locatorFormat="anml_NoAnimal_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false}
}

local outPath=[[D:\Projects\MGS\!ToolOutput\]]
local count = 50
for anml,formats in pairs(animalsTable) do
  local strings = this.GenerateFromFormat(formats.locatorFormat,count)
  this.WriteStringTable(outPath..anml.."_locator_strings.txt",strings)
  local strings = this.GenerateFromFormat(formats.nightRouteFormat,count)
  this.WriteStringTable(outPath..anml.."_nightRouteFormat_strings.txt",strings)
  local strings = this.GenerateFromFormat(formats.routeFormat,count)
  this.WriteStringTable(outPath..anml.."_routeFormat_strings.txt",strings)

end

local count=100
local lrrpRoute="rp_%02dto%02d"
local lrrpTravelName="lrrp_%02dto%02d"
local strings={}
for i=0,count do
  for j=0,count do
    strings[#strings+1]=string.format(lrrpRoute,i,j)
    strings[#strings+1]=string.format(lrrpTravelName,i,j)
  end
end

this.WriteStringTable(outPath.."lrrpStrings.txt",strings)

print("done")

return this
