--BuildLookupStrings.lua

--DEBUGNOW assumption, not running from an already modded package.path
local nonmgsvluaPath=[[D:\Projects\MGS\!InfiniteHeaven\!modlua\nonmgscelua]]
package.path=package.path..";"..nonmgsvluaPath..[[\?.lua]]

local InfUtil=require"InfUtil"
local InfFileUtil=require"InfFileUtil"

local this={}

local nl="\n"--tex LDT uses unix line ending. else "\r\n"

--tex take txt file of string lines and tableize them
function this.BuildLookupTablesFromText()
  print"BuildDictionaryTables"

  local outputPath=[[D:\Projects\MGS\!InfiniteHeaven\!modlua\ExternalLua\modules\]]--tex straight into IH dev dir

  local files={
    lang_dictionary={
      filePath=[[D:\Projects\MGS\MGSVTOOLS\FoxEngine.TranslationTool.v0.2.4\lang_dictionary.txt]],
      info='dictionary project 2017-08-09',
      modulePrefix='IHStringsDict',
    },
    qar_dictionary={
      filePath=[[D:\Projects\MGS\MGSVTOOLS\GzsTool\qar_dictionary.txt]],
      info='from gzstool release 0.5.3',
      modulePrefix='IHStringsDict',
    },
    fpk_dictionary={
      filePath=[[D:\Projects\MGS\MGSVTOOLS\GzsTool\fpk_dictionary.txt]],
      info='from gzstool release 0.5.3',
      modulePrefix='IHStringsDict',
    },
    mtar_dictionary={
      filePath=[[D:\Projects\MGS\MGSVTOOLS\MtarTool\mtar_dictionary.txt]],
      info='from mtartool release 0.2.6',
      modulePrefix='IHStringsDict',
    },
    --
    MgsGroundZeroes={
      filePath=[[D:\Projects\MGS\tools-other\Strings\MgsGroundZeroesStringsCulledRound2.txt]],
      info='from string scrape of MgsGroundZeroes exe',
      modulePrefix='IHStringsExe',
    },
  }

  local stringTables={}

  for name,fileInfo in pairs(files)do
    local filePath=fileInfo.filePath
    --print(filePath)
    local file=io.open(filePath,"r")
    if file==nil then
      print("cant find "..filePath)
    else
      print("loading "..name)
      stringTables[name]={}

      local skip={
        [["]],
        [[']],
        "{",
        "}",
        [[\]],--tex escapes and breaks
        [[\t]],
      }
      for line in file:lines() do
        local skipLine=false
        for i,skipChar in ipairs(skip)do
          if string.find(line,skipChar) then
            skipLine=true
            break
          end
        end
        if string.sub(line,1,1)==" " then
          skipLine=true
        end
        if not skipLine then
          stringTables[name][line]=true--tex use line as key to cull duplicates
        end
      end
      file:close()
    end
  end
  
  local stringTablesUnique={}
  for name,strings in pairs(stringTables)do
    stringTablesUnique[name]={}
    for str,bool in pairs(strings)do
      table.insert(stringTablesUnique[name],str)
    end
    table.sort(stringTablesUnique[name])
  end

  for name,strings in pairs(stringTablesUnique)do

    local modulePrefix=files[name].modulePrefix
    local fileName=modulePrefix..name..'.lua'
    print("writing "..fileName)
    local fileTable={
      '--'..fileName,
      '--GENERATED from '..name..' '..files[name].info,
      '--via BuildLookupStrings.BuildLookupTablesFromText',
    }

    table.insert(fileTable,"local this={}")
    table.insert(fileTable,"this.lookupStrings={")
    for i,str in ipairs(strings)do
      table.insert(fileTable,'"'..str..'",')
    end
    table.insert(fileTable,"}")
    table.insert(fileTable,"return this")

    local filePath=outputPath..fileName
    local file,error=io.open(filePath,"w")
    if not file or error then
      print("ERROR openwrite "..filePath)
      return
    end

    file:write(table.concat(fileTable,nl))
    file:close()
  end

  print("BuildDictionaryTables done")
end

local modulesPath=[[D:\GitHub\mgsv-lookup-strings\GameDir\mod\modules]]
--DEBUGNOW split into own module and put in lookup strings repo i guess
--cmd dir /b modulesPath > "D:\GitHub\mgsv-lookup-strings\fileNames.txt"
local stringTables={
  "IHStringsExe.lua",
  "IHStringsExeMgsGroundZeroes.lua",
  "IHStringsExtensions.lua",
  "IHStringsFox2Scrape.lua",
  "IHStringsFox2ScrapeAfgh.lua",
  "IHStringsFox2ScrapeLy.lua",
  "IHStringsFox2ScrapeLz.lua",
  "IHStringsFox2ScrapeMafr.lua",
  "IHStringsFox2ScrapeMtbs.lua",
  "IHStringsFox2ScrapePaths.lua",
  "IHStringsFox2ScrapeTrap.lua",
  "IHStringsGameObjectNames.lua",
  "IHStringsLua.lua",
  "IHStringsManual.lua",
--tex IHStrings<dictionary> are already derived from plain text so they can use that
}

function this.WriteStringTablesToTxt()
  print("WriteStringsToTxt")
  local outputPath=[[D:\GitHub\mgsv-lookup-strings]]

  package.path=package.path..";"..modulesPath..[[\?.lua]]
  for i,moduleName in ipairs(stringTables)do
    moduleName=InfUtil.StripExt(moduleName)
    print("Loading "..moduleName)
    local module=require(moduleName)
    if not module then
      print("WARNING Could not find "..moduleName)
    else
      if not module.lookupStrings then
        print("WARNING Could not find .lookupStrings table on "..moduleName)
      else
        print("writing "..moduleName..".txt")
        local file,error=io.open(outputPath..[[\]]..moduleName..".txt","w")
        if file then
          file:write(table.concat(module.lookupStrings,"\n"))--tex LDT has unix style line endings, otherwise \r\n
          file:close()
        end
      end
    end
  end
  print("WriteStringsToTxt done")
end




--EXEC
local main=function()
  this.BuildLookupTablesFromText()

  this.WriteStringTablesToTxt()
end

main()


return this
