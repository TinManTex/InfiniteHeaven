--DEBUGNOW
local this={}

function this.Split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

--BreakIntoWords
local inputFile=[[D:\GitHub\mgsv-lookup-strings\GzsTool\qar_dictionary.txt]]
local inputFile=[[D:\GitHub\mgsv-lookup-strings\MtarTool\mtar_dictionary.txt]]
local file=io.open(inputFile,"r")
local wordsUnique={}
-- read the lines in table 'lines'
for line in file:lines() do
  local split=this.Split(line,"/")
  for i,word in ipairs(split) do
    wordsUnique[word]=true
  end
end
file:close()

local words={}
for word,bool in pairs(wordsUnique)do
  words[#words+1]=word
end
table.sort(words)

local nl="\r"
local fileName=[[D:\Projects\MGS\!ToolOutput\]]..[[qar_dictionary_words.txt]]
local fileName=[[D:\Projects\MGS\!ToolOutput\]]..[[mtar_dictionary_words.txt]]
local file=io.open(fileName,"w")
file:write(table.concat(words,nl))
file:close()
