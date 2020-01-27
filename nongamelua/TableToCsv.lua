--ParameterTableTransform.lua
--tex conversion of various tpp lua tables to/from csv
local this={}

--converts something like { {p00=1,p01,...},{...},...} to {{0,1...},{...},...}
--which can be easilty concat into csv with line per entry
function this.TableEntriesWithParamsToCsv(paramTable)
	local lines={}
	for i,entry in ipairs(paramTable)do
		local line={}
		local pN=0

		local value=entry[paramName]
		--do while value ~=null
		local paramName=string.format('p%02',pN)
		pn=pn+1
		table.insert(lines,)
	end
end

--file:write(table.concat(lines,','))

return this