local stuff_string = minetest.setting_get("initial_stuff") or
		"default:pick_steel,default:axe_steel,default:shovel_steel," ..
		"default:torch 99,default:cobble 99"

give_initial_stuff = {
	items = {}
}

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

function give_initial_stuff.give(player)
	minetest.log("action",
			S("Giving initial stuff to player @1", player:get_player_name()))
	local inv = player:get_inventory()
	for _, stack in ipairs(give_initial_stuff.items) do
		inv:add_item("main", stack)
	end
end

function give_initial_stuff.add(stack)
	give_initial_stuff.items[#give_initial_stuff.items + 1] = ItemStack(stack)
end

function give_initial_stuff.clear()
	give_initial_stuff.items = {}
end

function give_initial_stuff.add_from_csv(str)
	local items = str:split(",")
	for _, itemname in ipairs(items) do
		give_initial_stuff.add(itemname)
	end
end

function give_initial_stuff.set_list(list)
	give_initial_stuff.items = list
end

function give_initial_stuff.get_list()
	return give_initial_stuff.items
end

give_initial_stuff.add_from_csv(stuff_string)
if minetest.setting_getbool("give_initial_stuff") then
	minetest.register_on_newplayer(give_initial_stuff.give)
end
