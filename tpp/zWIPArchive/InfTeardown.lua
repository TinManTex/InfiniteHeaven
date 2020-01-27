--DEBUGWIP
local this={}

local nl=[[\n\r]]--DEBUGWIP "\n\r"
function this.WriteString(filePath,someString)
  local file,error=open(filePath,"w")
  if not file or error then
    return
  end

  file:write(someString,nl)
  file:close()
end


function this.Dump()
  local outDir=[[D:\Projects\MGS\dump\]]

  local dontDump={
    this=true,
    package=true,
    io=true,
  }

  local _G=_G


  for k,v in pairs(_G.package.loaded) do
    local filename=outDir..[[packages\]]..k..'.txt'
    if not dontDump[k] then
      local ins=InfInspect.Inspect(v)
      this.WriteString(filename,ins)
    end
  end
  for k,v in pairs(_G) do
    if not _G['package']['loaded'][k] then
      if type(v) == 'table' then
        local filename=outDir..[[tables\]]..k..'.txt'
        local ins=InfInspect.Inspect(v)
        this.WriteString(filename,ins)
      elseif type(v) == 'function' then
        local filename=outDir..[[functions\]]..k..'.txt'
        local ins=InfInspect.Inspect(v)
        this.WriteString(filename,ins)
      else
        local filename=outDir..k..'.txt'
        local ins=InfInspect.Inspect(v)
        this.WriteString(filename,ins)
      end
    end
  end

end

return this
