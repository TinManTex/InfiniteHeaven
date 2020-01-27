--TODO combine with extensionorder
local this={}

--tex gets all file extensions and counts
--requires a dir /b /s > somefile.txt of all files
--see also Tools\gatherextensionlist
--it's better to break down by archive eg:data1,chunks,fpks,fpkds
function this.ExtensionShit()
  --extensionshit
  local basePath=[[J:\GameData\MGS\]]
  local inFile=basePath.."AllFileList.txt"
  local outFile=basePath.."allextensions.txt"

  local file=io.open(inFile,"r")
  if file==nil then
    print("cant find "..inFile)
    return
  end
  local extensions={}
  -- read the lines in table 'lines'

  for line in file:lines() do
    local last=InfUtil.FindLast(line,".")
    local ext=""
    if last then
      ext=string.sub(line,last,#line)
    end

    print(ext)
    if not extensions[ext] then
      extensions[ext]=0
    end
    extensions[ext]=extensions[ext]+1
  end
  file:close()

  local extensionsList={}
  for ext,count in pairs(extensions)do
    table.insert(extensionsList,ext)
  end

  table.sort(extensionsList)

  local nl='\n'

  local file=io.open(outFile,"w")
  for i,ext in ipairs(extensionsList)do
    file:write(ext..":"..extensions[ext]..nl)
  end
  file:close()
end

reurn this