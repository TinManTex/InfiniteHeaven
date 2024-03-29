--https://github.com/bungle/lua-resty-tsort
--[[
Copyright (c) 2016, Aapo Talvensaari
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

--[[usage
local tsort = require "resty.tsort"

local graph = tsort.new()

graph:add('a', 'b')
graph:add('b', 'c')
graph:add('0', 'a')

graph:sort()

-- Output:
--graph = {
--   "0",
--   "a",
--   "b",
--   "c"
-- }
--]]

--also see an alternative topological sort lib: https://github.com/starius/toposort/

local setmetatable = setmetatable
local pairs = pairs
local type = type
local function visit(k, n, m, s)
    if m[k] == 0 then return 1 end
    if m[k] == 1 then return end
    m[k] = 0
    local f = n[k]
    for i=1, #f do
        if visit(f[i], n, m, s) then return 1 end
    end
    m[k] = 1
    s[#s+1] = k
end
local tsort = {}
tsort.__index = tsort
function tsort.new()
    return setmetatable({ n = {} }, tsort)
end
function tsort:add(...)
    local p = { ... }
    local c = #p
    if c == 0 then return self end
    if c == 1 then
        p = p[1]
        if type(p) == "table" then
            c = #p
        else
            p = { p }
        end
    end
    local n = self.n
    for i=1, c do
        local f = p[i]
        if n[f] == nil then n[f] = {} end
    end
    for i=2, c, 1 do
        local f = p[i]
        local t = p[i-1]
        local o = n[f]
        o[#o+1] = t
    end
    return self
end
function tsort:sort()
    local n  = self.n
    local s = {}
    local m  = {}
    for k in pairs(n) do
        if m[k] == nil then
            if visit(k, n, m, s) then
                return nil, "There is a circular dependency in the graph. It is not possible to derive a topological sort."
            end
        end
    end
    return s
end
return tsort