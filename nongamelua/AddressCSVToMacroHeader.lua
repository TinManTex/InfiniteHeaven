--AddressCSVToMacroHeader.lua

--REF entry
--{name="<function name>",
--using_default=true,--no address, IHHook is using an actual code implementation
--minimal_hook=true,--a function that's actually currently used by ihhook in a functional way. ie the rest of the addresses can be ignored if you need to get an update out quick by just finding a few addresses.
----SYNC: -^- must update as you use more functions in ihhook, so dont know of approach viablity in long term
--note="some other note",--will append as comment to end of line
--}

--lua api
local functionEntries={
  --lua
  {name="lua_newstate",},
  {name="lua_close",},
  {name="lua_newthread",},

  {name="lua_atpanic",},

  {name="lua_gettop", noAddress="USING_CODE",},
  {name="lua_settop",},
  {name="lua_pushvalue",},
  {name="lua_remove",},
  {name="lua_insert",},
  {name="lua_replace",},
  {name="lua_checkstack",},
  {name="lua_xmove",},

  {name="lua_isnumber",},
  {name="lua_isstring",},
  {name="lua_iscfunction",},
  {name="lua_isuserdata", noAddress="USING_CODE",},
  {name="lua_type",},
  {name="lua_typename",},

  {name="lua_equal",  note="tex: lua implementation goes a bit deeper than I'm happy with to use at the moment. No calls in lua distro, so may be hard to find, or have been culled by compilation" },
  {name="lua_rawequal",},
  {name="lua_lessthan",},
  {name="lua_tonumber",},
  {name="lua_tointeger",minimal_hook=true,},
  {name="lua_toboolean",},
  {name="lua_tolstring",minimal_hook=true,},
  {name="lua_objlen",},
  {name="lua_tocfunction",},
  {name="lua_touserdata",},
  {name="lua_tothread",},
  {name="lua_topointer",},

  {name="lua_pushnil",minimal_hook=true,},
  {name="lua_pushnumber",},
  {name="lua_pushinteger",minimal_hook=true,},
  {name="lua_pushlstring",},
  {name="lua_pushstring",minimal_hook=true,},
  {name="lua_pushvfstring",},
  {name="lua_pushfstring",},
  {name="lua_pushcclosure",},
  {name="lua_pushboolean",minimal_hook=true,},
  {name="lua_pushlightuserdata",},
  {name="lua_pushthread",},

  {name="lua_gettable",},
  {name="lua_getfield",minimal_hook=true,},
  {name="lua_rawget",},
  {name="lua_rawgeti",note="via MACRO lua_getref",},
  {name="lua_createtable",minimal_hook=true,},
  {name="lua_newuserdata",},
  {name="lua_getmetatable",},
  {name="lua_getfenv",},

  {name="lua_settable",},
  {name="lua_setfield",minimal_hook=true,},
  {name="lua_rawset",},
  {name="lua_rawseti",minimal_hook=true,},
  {name="lua_setmetatable",},
  {name="lua_setfenv",},

  {name="lua_call",},
  {name="lua_pcall",},
  {name="lua_cpcall",},
  {name="lua_load",},

  {name="lua_dump",},

  {name="lua_yield", noAddress="USING_CODE",},
  {name="lua_resume",},
  {name="lua_status", noAddress="USING_CODE", note="tex DEBUGNOW hmm, address range. ida finds this as sig though, but the prior functions have entries in .pdata which put them in the same range (0x14cdb)",},

  {name="lua_gc",},
  {name="lua_error",},

  {name="lua_next",},
  {name="lua_concat",},

  {name="lua_getallocf", noAddress="NO_USE",note="tex don't really want to mess with allocator function anyway, DEBUGNOW no calls in lua distro, so may be hard to find, or have been culled by compilation" },
  {name="lua_setallocf", noAddress="NO_USE",note="tex don't really want to mess with allocator function anyway"},


  {name="lua_setlevel", noAddress="NO_USE",note="tex: labeled by lua as a hack to be removed in lua 5.2",},

  {name="lua_getstack",},
  {name="lua_getinfo",},
  {name="lua_getlocal",},
  {name="lua_setlocal",},
  {name="lua_getupvalue",},
  {name="lua_setupvalue",},

  {name="lua_sethook",},
  {name="lua_gethook",},
  {name="lua_gethookmask",},
  {name="lua_gethookcount",},
  --lua<


  --lauxlib.h
  {name="luaI_openlib", minimal_hook=true,},
  {name="luaL_register", noAddress="USING_CODE",},
  {name="luaL_getmetafield",},
  {name="luaL_callmeta",},
  {name="luaL_typerror",},
  {name="luaL_argerror",},
  {name="luaL_checklstring",},
  {name="luaL_optlstring",},
  {name="luaL_checknumber",},
  {name="luaL_optnumber", noAddress="USING_CODE",},

  {name="luaL_checkinteger",},
  {name="luaL_optinteger",},

  {name="luaL_checkstack",},
  {name="luaL_checktype",},
  {name="luaL_checkany",},

  {name="luaL_newmetatable",},
  {name="luaL_checkudata",},

  {name="luaL_where",},
  {name="luaL_error",},

  {name="luaL_checkoption",},

  {name="luaL_ref", noAddress="USING_CODE", note="tex: Unsure on this address, see lauxlib_Creathooks CREATEHOOK(luaL_ref) for more info",},
  {name="luaL_unref", noAddress="USING_CODE",},

  {name="luaL_loadfile",},
  {name="luaL_loadbuffer",},
  {name="luaL_loadstring", noAddress="USING_CODE",},

  {name="luaL_newstate",},

  {name="luaL_gsub",},

  {name="luaL_findtable",},
  --...
  {name="luaL_buffinit",},
  {name="luaL_prepbuffer",},
  {name="luaL_addlstring",},
  {name="luaL_addstring", noAddress="USING_CODE",},
  {name="luaL_addvalue",},
  {name="luaL_pushresult",},
  --lauxlib.h<

  --luaLib.h>
  {name="luaopen_base",},
  {name="luaopen_table",},
  {name="luaopen_io",},
  {name="luaopen_os",},
  {name="luaopen_string",},
  {name="luaopen_math",},
  {name="luaopen_debug",},
  {name="luaopen_package",},
  {name="luaL_openlibs",},
--luaLib.h<

}--functionEntries

local noAddressLegend=[[

// NOT_FOUND - default for a lapi we want to use, and should actually have found the address in prior exes, but aren't in the current exported address list
// NO_USE - something we dont really want to use for whatever reason - TODO addt to getllocf,setallocf, actually give reason why not (dont want to mess with allocator function)
// USING_CODE - using the default lapi code implementation instead of hooking
]]

--enum
local functionNameToEntry={}
for i,entry in ipairs(functionEntries)do
  functionNameToEntry[entry.name]=entry
end

--util
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end
--util<

--REF input: csv exported by ghidra - functions window > right click > export
--Label Location  Function Signature
--luaX_token2str  141a2d380 thunk undefined luaX_token2str()
--luaX_token2str  14c21d1b0 undefined luaX_token2str()
--..
--read csv
--IN: IO (csvPath)
--OUT:
--{
--  <functionName>={address=address,isThunk=isThunk},
--  ...
--}
function ReadCSV(csvPath)
  print("ReadCSV: "..csvPath)
  local csvEntries={}

  local csvLines=lines_from(csvPath)
  for i=2,#csvLines do--tex skip first line as its column names
    local csvLine=csvLines[i]
    csvLine=csvLine:sub(2,csvLine:len()-1)
    local csvValues=split(csvLine,'","')
    local functionName=csvValues[1]
    local address=csvValues[2]
    local functionSignature=csvValues[3]

    local isThunk=functionSignature:find("thunk")
    csvEntries[functionName]={address=address,isThunk=isThunk}
  end--for csvLines

  return csvEntries
end--ReadCSV

function ProcessCSVEntries(csvEntries,functionEntries)
  local outLines={}
  local notFoundCount=0
  for i,entry in ipairs(functionEntries)do
    local outLine
    --DEBUGNOW is no non-thunk then do we want to use thunk?
    local csvEntry=csvEntries[entry.name]

    --DEBUGNO just find the missing addresses
    if not csvEntry then
      if not entry.noAddress then
        print(entry.name.." NOT FOUND")
      end
    end

    local address=entry.noAddress and entry.noAddress or "NOT_FOUND" --tex known reason for not having an address
    if csvEntry and not entry.noAddress then
      address="0x"..csvEntry.address
    elseif not entry.noAddress then
      notFoundCount=notFoundCount+1
    end

    outLine='HOOKPTR('..entry.name..', '..address..');'

    if entry.noAddress then
      outLine="//"..outLine --tex comment out
    end

    if address=="NOT_FOUND" then
      outLine="//"..outLine --tex comment out
      outLine=outLine.."//DEBUGNOW NOT_FOUND"
    end
    
    if entry.minimal_hook then
      outLine=outLine.."//MINIMAL_HOOK "
    end
    
    if entry.note then
      outLine=outLine.."//"..entry.note
    end

    table.insert(outLines,outLine)
  end

  print(notFoundCount.." addresses out of "..#functionEntries.." missing")--DEBUGNOW

  return outLines
end


--REF output
--lua_Addresses.h
--
--HOOKPTR(lua_newstate, 0x14bd561b0);
--HOOKPTR(lua_close, 0x141a21660);
--HOOKPTR(lua_newthread, 0x14bcdc650);
--write .h file
function WriteH(outLines,hDestPath,header)
  print("WriteH: "..hDestPath)

  --tex inserting to top, so reverse order
  for i=#header,1, -1 do
    table.insert(outLines,1,header[i])
  end
  local outFile=io.open(hDestPath,"w")

  outFile:write(table.concat(outLines,'\n'))
end--WriteH
--exec>

local csvSourcePath=[[D:\GitHub\IHHook\mgstpp-adresses-1.0.15.3.csv]]
local hDestPath=[[D:\GitHub\IHHook\IHHook\lua\lua_AddressesGEN.h]]

local header={
  "#pragma once",
  [[#include <lua.h>]],
  [[#include <lualib.h>]],
  [[#include <lauxlib.h>]],
  [[#include "../HookMacros.h"]],
  "//GENERATED: by AddressCSVToMacroHeader.lua",
  "//using "..csvSourcePath,
  noAddressLegend,
}

local csvEntries=ReadCSV(csvSourcePath)
local outLines=ProcessCSVEntries(csvEntries,functionEntries)
WriteH(outLines,hDestPath,header)

--exec<


































