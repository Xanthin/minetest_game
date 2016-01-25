beds = {}
beds.player = {}
beds.pos = {}
beds.spawn = {}

-- Intllib
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s,a,...)
			if a==nil then
				return s
			end
			a={a,...}
			return s:gsub("(@?)@(%(?)(%d+)(%)?)",
				function(e,o,n,c)
					if e==""then
						return a[tonumber(n)]..(o==""and c or"")
					else
						return"@"..o..n..c
					end
				end)
		end
end
beds.intllib = S

beds.formspec = "size[8,15;true]" ..
	"bgcolor[#080808BB; true]" ..
	"button_exit[2,12;4,0.75;leave;" .. S("Leave Bed") .. "]"

local modpath = minetest.get_modpath("beds")

-- Load files

dofile(modpath .. "/functions.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/beds.lua")
dofile(modpath .. "/spawns.lua")
