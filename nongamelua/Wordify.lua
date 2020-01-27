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
local function BreakIntoWords(path,delim,outpath)

  local file=io.open(path,"r")
  local wordsUnique={}
  for line in file:lines() do
    local split=this.Split(line,delim)
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
  local file=io.open(outpath,"w")
  file:write(table.concat(words,nl))
  file:close()
end

--paths
local inPath=[[D:\GitHub\mgsv-lookup-strings\strings\stringsPaths-culled.txt]]
local outpath=[[D:\Projects\MGS\!ToolOutput\]]..[[wordsPaths.txt]]
BreakIntoWords(inPath,"/",outpath)

--combined object names ex afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas001
local inPath=[[D:\GitHub\mgsv-lookup-strings\strings\multiObjectNames_culled.txt]]
local outpath=[[D:\Projects\MGS\!ToolOutput\]]..[[wordsObjectNames.txt]]
BreakIntoWords(inPath,"|",outpath)


print("done")
