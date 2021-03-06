minetest.register_on_joinplayer(function(player)
    minetest.after(0, player.hud_set_hotbar_itemcount, player, 16)
end)

local function do_pingkick ( )
    for i, player in pairs(minetest.get_connected_players()) do
        if player ~= nil then
            local pname = player:get_player_name()
            if pname ~= nil then
                local pinfo = minetest.get_player_information(pname)
                if pinfo ~= nil then
                    local ping = math.floor((pinfo.avg_rtt / 2) * 1000)
                    if ping > 200 then
                        minetest.kick_player(pname, "You were kicked for high ping. This server is in LONDON, try a server closer to you or fix your internet connection")
                        minetest.chat_send_all( pname .. " was kicked for high ping (" .. ping .. ")")
                    end
                    if ping > 180 then
                        minetest.chat_send_player(pname, "WARNING:" .. pname .. "You are far away, your ping is high (" .. ping .. ", you may get kicked....")
                    end
                end
            end
        end
	end
    minetest.after(60, do_pingkick)
end
minetest.after(60, do_pingkick)

minetest.register_chatcommand("ping", {
    privs = {server = true},
    params = "",
    description = "Get ip & ping of players",
    func = function(player_name, param)
		for i, player in pairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if name then
				local ping = minetest.get_player_information(name).avg_rtt / 2
				ping = math.floor(ping * 1000)
				minetest.chat_send_player(player_name, "     "..name.." IP:"..minetest.get_player_information(name).address.."  Ping: "..ping.."ms")
			end
		end
	end
})

minetest.register_chatcommand("wit", {
    privs = {server = true},
    params = "",
    description = "Get itemstring of wielded item",
    func = function(player_name, param)
	local player = minetest.get_player_by_name(player_name)
	minetest.chat_send_player(player_name, player:get_wielded_item():to_string())
	return
    end
})

minetest.register_chatcommand("eday", {
    privs = {settime = true},
    params = "<player_name>",
    description = "Eternal Day (It never gets dark.)",
    func = function(player_name, param)
        minetest.set_timeofday(0.5)
        minetest.setting_set("time_speed","0")
    end
})

-- minetest.register_chatcommand("info", {
--     params = "<player_name>",
--     description = "Get network information of player",
--     privs = {server = true},
--     func = function(player_name, param)
--     	if not param then
--     	    minetest.chat_send_player(player_name, "Player " .. param .. " was not found")
--             return
--         end
--         playerInfo = minetest.get_player_information(param)
--         minetest.chat_send_player(player_name, param ..
--             " - IP address - " .. playerInfo["address"])
--         minetest.chat_send_player(player_name, param ..
--             " - Avg rtt - " .. playerInfo["avg_rtt"])
--         minetest.chat_send_player(player_name, param ..
--             " - Connection uptime (seconds) - " .. playerInfo["connection_uptime"])
--         return
--     end
-- })

rainbow={}
rainbow.config={}
rainbow.config.away_radius=16
rainbow.config.away_radius_max=24
rainbow.modpath = minetest.get_modpath("rainbow")

stairsplus:register_alias_force_all("moreblocks", "obsidian", "rainbow", "stone_black")
stairsplus:register_alias_force_all("moreblocks", "goldblock", "rainbow", "clayblock_gold")
stairsplus:register_alias_force_all("moreblocks", "steelblock", "rainbow", "clayblock_white")
stairsplus:register_alias_force_all("moreblocks", "copperblock", "rainbow", "clayblock_orange")
stairsplus:register_alias_force_all("moreblocks", "bronzeblock", "rainbow", "clayblock_orange")
stairsplus:register_alias_force_all("moreblocks", "diamondblock", "rainbow", "clayblock_cyan")
stairsplus:register_alias_force_all("moreblocks", "meselamp", "rainbow", "lightblock_gold")
stairsplus:register_alias_force_all("moreblocks", "mese", "rainbow", "stoneblock_yellow")



rainbow.colours = {
	{"white",      "White",      "#ffffffc0",   "rainbow:daisies",              {50,50},4},
	{"cyan",       "Cyan",       "#00ffffc0",   "rainbow:tulip",                {75,90},5},
	{"magenta",    "Magenta",    "#ff00ffc0",   "rainbow:dianthus",             {45,80},6},
	{"yellow",     "Yellow",     "#ffff00c0",   "rainbow:dandelion",            {10,75},7},
	{"black",      "Black",      "#000000c0",   "default:coal_lump",            {65,65},8},
	{"red",        "Red",        "#ff0000c0",   "rainbow:mushroom_red",         {35,60},9},
	{"green",      "Green",      "#5a8041c0",   "rainbow:junglegrass",          {95,50},10},
	{"blue",       "Blue",       "#0000ffc0",   "rainbow:geranium",             {49,49},11},
	{"pink",       "Pink",       "#ff9090c0",   "rainbow:rose",                 {20,50},12},
	{"brown",      "Brown",      "#a78c45c0",   "rainbow:mushroom_brown",       {65,35},13},
	{"lightgreen", "Light Green","#b5ff81c0",   "rainbow:greenery",             {35,35},14},
	{"violet",     "Violet",     "#900090c0",   "rainbow:violet",               {75,20},15},
	{"grey",       "Grey",       "#909090c0",   "rainbow:",                     {50,50},16},
	{"orange",     "Orange",     "#ff8401c0",   "rainbow:orangeflower",         {20,25},17},
	{"darkgrey",   "Dark Grey",  "#303030c0",   "rainbow:cookieflower",         {90,30},18},
	{"darkbrown",  "Dark Brown", "#5C4033c0",   "",                           {68,38},19},
	{"darkred",    "Dark Red",   "#800000c0",   "",                           {68,38},19},
	{"gold",       "Gold",       "#ffd700c0",   "",                           {68,38},19},
	{"lightblue",  "Light Blue", "#0091ffc0",   "",                           {68,38},19},
	{"darkyellow",  "Dark Yellow", "#ffc30ec0",   "",                           {68,38},19},
	{"darkorange",  "Dark Orange", "#ff5d00c0",   "",                           {68,38},19},
	{"sand",        "Sand",       "#c2c260c0",   "",                           {68,38},19},
    }



rainbow.clut={}
for _, row in ipairs(rainbow.colours) do
    rainbow.clut[row[1]]={row[2],row[3],row[4],row[5]}
end

function rainbow.grow_papyrus(pos, node)
	pos.y = pos.y - 1
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "rainbow:papyrus" and height < 16 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 16 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "rainbow:papyrus"})
	return true
end

minetest.register_abm({
	label = "Grow papyrus",
	nodenames = {"rainbow:papyrus"},
	--neighbors = {"group:dirt"},
	interval = 14,
	chance = 71,
	action = function(...)
		rainbow.grow_papyrus(...)
	end
})

function rainbow.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end

rainbow.nhide = function(nodename)
    local groupz = minetest.registered_nodes[nodename].groups
    groupz.not_in_creative_inventory=1
    minetest.override_item(nodename, {
        groups=groupz
    })
end

local nhide = rainbow.nhide

-- --nhide("default:dirt")
-- --nhide("default:dirt_with_snow")
-- --nhide("default:dirt_with_grass")
-- --nhide("default:dirt_with_dry_grass")
-- --nhide("default:sand")
-- --nhide("default:stone")
-- nhide("default:sandstone")
-- nhide("default:desert_stone")
-- nhide("default:stone_block")
-- nhide("default:sandstone_block")
-- nhide("default:desert_stone_block")
-- --nhide("default:stone_with_coal")
-- --nhide("default:stone_with_iron")
-- --nhide("default:stone_with_diamond")
-- --nhide("default:stone_with_gold")
-- --nhide("default:stone_with_mese")
-- --nhide("default:stone_with_copper")
-- nhide("default:stonebrick")
-- nhide("default:sandstonebrick")
-- nhide("default:desert_stonebrick")
-- --nhide("default:acacia_bush_leaves")
-- --nhide("default:acacia_bush_stem")
-- nhide("default:acacia_leaves")
-- nhide("default:acacia_tree")
-- nhide("default:acacia_wood")
-- nhide("default:acacia_sapling")
-- nhide("default:jungleleaves")
-- nhide("default:jungletree")
-- nhide("default:junglewood")
-- nhide("default:junglesapling")
-- nhide("default:aspen_leaves")
-- nhide("default:aspen_tree")
-- nhide("default:aspen_sapling")
-- nhide("default:aspen_wood")
-- --nhide("default:bush_leaves")
-- --nhide("default:bush_stem")
-- nhide("default:cactus")
-- --nhide("default:clay")
-- nhide("default:clay_lump")
-- nhide("default:cobble")
-- nhide("default:desert_cobble")
-- --nhide("default:coral_orange")
-- --nhide("default:coral_brown")
-- --nhide("default:coral_skeleton")
-- --nhide("default:gravel")
-- --nhide("default:ice")
-- --nhide("default:junglegrass")
-- --nhide("default:grass_1")
-- --nhide("default:desert_sand")
-- --nhide("default:dry_grass_1")
-- nhide("default:glass")
-- --nhide("default:leaves")
-- nhide("default:mossycobble")
-- nhide("default:obsidian")
-- nhide("default:pine_needles")
-- nhide("default:pine_sapling")
-- nhide("default:pine_tree")
-- nhide("default:pine_wood")
-- --nhide("default:sapling")
nhide("default:lava_source")
--nhide("default:water_source")
-- nhide("default:river_water_source")
-- --nhide("default:wood")
-- --nhide("default:tree")
-- --nhide("default:snow")
-- --nhide("default:snowblock")
-- --nhide("default:silver_sand")
-- nhide("default:papyrus")
-- --nhide("default:apple")
-- nhide("default:coal_lump")
-- nhide("default:copper_lump")
-- nhide("default:gold_lump")
-- nhide("default:iron_lump")
-- nhide("default:mese_crystal_fragment")
-- nhide("default:obsidian_shard")
-- nhide("default:diamond")
-- nhide("default:dry_shrub")
-- nhide("default:flint")

-- Aliases for map generators

--
--[[
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_snowblock", "default:snowblock")
minetest.register_alias("mapgen_snow", "default:snow")
minetest.register_alias("mapgen_ice", "default:ice")
minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_jungletree", "default:jungletree")
minetest.register_alias("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias("mapgen_junglegrass", "default:junglegrass")
minetest.register_alias("mapgen_pine_tree", "default:pine_tree")
minetest.register_alias("mapgen_pine_needles", "default:pine_needles")
minetest.register_alias("mapgen_dirt", "rainbow:dirt_brown")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_sandstone", "rainbow:stone_brown")
minetest.register_alias("mapgen_desert_stone", "rainbow:stone_orange")
minetest.register_alias("mapgen_desert_sand", "rainbow:sand_orange")
minetest.register_alias("mapgen_cobble", "rainbow:cobble_grey")
minetest.register_alias("mapgen_dirt_with_grass", "rainbow:dirt_green")
minetest.register_alias("mapgen_dirt_with_snow", "rainbow:dirt_white")
minetest.register_alias("mapgen_stair_cobble", "moreblocks:stair_cobble_grey")
minetest.register_alias("mapgen_stair_desert_stone", "moreblocks:stair_stone_orange")
minetest.register_alias("mapgen_sandstonebrick", "rainbow:stonebrick_brown")
minetest.register_alias("mapgen_stair_sandstonebrick", "stairs:stair_sandstonebrick_brown")

minetest.register_alias("default:glass","rainbow:glass_white")
minetest.register_alias("default:obsidian_glass","rainbow:glass_black")

minetest.register_alias("default:coral_skeleton","rainbow:coral_white")
minetest.register_alias("default:coral_orange","rainbow:coral_orange")
minetest.register_alias("default:coral_brown","rainbow:coral_brown")

minetest.register_alias("default:wood","rainbow:wood_orange")
minetest.register_alias("default:dirt_with_grass","rainbow:dirt_green")
minetest.register_alias("default:dirt_with_dry_grass","rainbow:dirt_orange")
minetest.register_alias("default:dirt_with_snow","rainbow:dirt_white")
minetest.register_alias("default:sand","rainbow:sand_brown")
minetest.register_alias("default:desert_sand","rainbow:sand_orange")
minetest.register_alias("default:silver_sand","rainbow:sand_white")
minetest.register_alias("default:dirt","rainbow:dirt_brown")
minetest.register_alias("default:clay","rainbow:clay_yellow")
minetest.register_alias("default:stone","rainbow:stone_grey")
minetest.register_alias("default:cobble", "rainbow:cobble_grey")
minetest.register_alias("default:gravel", "rainbow:gravel_grey")
minetest.register_alias("default:mossycobble", "rainbow:cobble_green")
minetest.register_alias("default:stonebrick","rainbow:stonebrick_grey")
minetest.register_alias("default:stone_block","rainbow:stoneblock_grey")
minetest.register_alias("default:desert_stone","rainbow:stone_orange")
minetest.register_alias("default:desert_cobble","rainbow:cobble_orange")
minetest.register_alias("default:sandstone","rainbow:stone_brown")
minetest.register_alias("default:ice","rainbow:ice_white")
minetest.register_alias("default:snowblock","rainbow:snowblock_white")
minetest.register_alias("default:snow","rainbow:snow_white")
minetest.register_alias("default:wool","rainbow:wool_white")

minetest.register_alias("ethereal:redwood_leaves","rainbow:redwood_leaves")
minetest.register_alias("ethereal:redwood_trunk","rainbow:redwood_trunk")
--]]

minetest.register_alias("rainbow:art_applejack", "art:babydiana_applejack")
minetest.register_alias("rainbow:art_prettygirl", "art:babydiana_prettygirl")
minetest.register_alias("rainbow:art_purity", "art:babydiana_purity")
minetest.register_alias("rainbow:art_zonetan", "art:babydiana_zonetan")

minetest.register_alias("darkage:box","xdecor:barrel")
minetest.register_alias("default:fence_wood","rainbow:fence_black")
minetest.register_alias("default:junglewood","rainbow:wood_black")
minetest.register_alias("default:wood","rainbow:wood_black")
minetest.register_alias("homedecor:armchair_red","rainbow:cushion_red")
minetest.register_alias("homedecor:chair_black","ts_furniture:rainbow_wood_black_chair")
minetest.register_alias("homedecor:curtain_white","rainbow:curtain_sand")
minetest.register_alias("homedecor:table_lamp_blue_max","homedecor:oil_lamp")
minetest.register_alias("homedecor:table_mahogany","ts_furniture:rainbow_wood_black_table")
minetest.register_alias("homedecor:wood_table_small_square","ts_furniture:rainbow_wood_black_small_table")
minetest.register_alias("lrfurn:armchair_black","rainbow:cushion_black")
minetest.register_alias("moreblocks:slope_wood","rainbow:slope_wood_black")
minetest.register_alias("mymeshnodes:cylinder_default_wood","rainbow:wood_black")
minetest.register_alias("mymeshnodes:lslope_default_wood","rainbow:slope_wood_black")
minetest.register_alias("stairs:slab_wood","rainbow:slab_wood_black")
minetest.register_alias("stairs:stair_junglewood","rainbow:stair_wood_black")
minetest.register_alias("stairs:stair_wood","rainbow:stair_wood_black")




minetest.register_alias("default:stone","rainbow:stone_grey")
minetest.register_alias("default:desert_stone", "rainbow:stone_darkred")

minetest.register_alias("ethereal:mushroom","rainbow:mushroom")
minetest.register_alias("ethereal:mushroom_pore","rainbow:mushroom_pore")
minetest.register_alias("ethereal:mushroom_trunk","rainbow:mushroom_trunk")
minetest.register_alias("ethereal:fiery_dirt_top","rainbow:dirt_red")
minetest.register_alias("flowers:waterlily","rainbow:waterlily")
minetest.register_alias("flowers:mushroom_red","rainbow:mushroom_red")
minetest.register_alias("flowers:mushroom_brown","rainbow:mushroom_brown")
minetest.register_alias("mapgen_stone", "rainbow:stone_grey")
minetest.register_alias("default:mossycobble", "rainbow:cobble_green")
minetest.register_alias("default:cobble", "rainbow:cobble_grey")
minetest.register_alias("handle_schematics:dig_here","default:air")
minetest.register_alias("mapgen_water_source", "rainbow:pink_water_source")
minetest.register_alias("mapgen_river_water_source", "rainbow:red_water_source")

minetest.register_alias("castle:workbench","homedecor:tool_cabinet")

minetest.register_alias("stairs:slab_pine_wood","rainbow:slab_wood_white")
minetest.register_alias("stairs:stair_pine_wood","rainbow:stair_wood_white")
minetest.register_alias("stairs:stair_aspen_wood","rainbow:stair_wood_white")
minetest.register_alias("stairs:stair_acacia_wood","rainbow:stair_wood_darkred")
minetest.register_alias("stairs:stair_sandstonebrick","rainbow:stair_stonebrick_sand")
minetest.register_alias("stairs:stair_stonebrick","rainbow:stair_stonebrick_grey")
minetest.register_alias("default:sandstonebrick","rainbow:stonebrick_sand")
minetest.register_alias("default:stonebrick","rainbow:stonebrick_grey")
minetest.register_alias("default:sandstone","rainbow:stone_sand")
minetest.register_alias("default:desertstone","rainbow:stone_darkred")
minetest.register_alias("default:acacia_wood","rainbow:wood_darkred")
minetest.register_alias("castle:pillars_sandstonebrick_top","rainbow:column_top_stoneblock_sand")
minetest.register_alias("castle:pillars_sandstonebrick_middle","rainbow:column_middle_stoneblock_sand")
minetest.register_alias("castle:pillars_sandstonebrick_bottom","rainbow:column_bottom_stoneblock_sand")
minetest.register_alias("homedecor:table","ts_furniture:rainbow_wood_darkbrown_table")



minetest.register_alias("stairs:stair_darkage_stone_brick","rainbow:fancybrick_grey")
minetest.register_alias("stairs:slope_pine_wood","rainbow:slope_wood_white")
minetest.register_alias("stairs:slope_pine_wood_half","rainbow:slope_wood_white_half")
minetest.register_alias("stairs:slope_pine_wood_half_raised","rainbow:slope_wood_white_half_raised")
minetest.register_alias("stairs:slope_pine_wood_inner","rainbow:slope_wood_white_inner")
minetest.register_alias("stairs:slope_pine_wood_inner_cut_half","rainbow:slope_wood_white_inner_half")
minetest.register_alias("stairs:slope_pine_wood_inner_cut_half_raised","rainbow:slope_wood_white_inner_half_raised")
minetest.register_alias("stairs:slope_pine_wood_outer","rainbow:slope_wood_white_outer")
minetest.register_alias("stairs:slope_pine_wood_outer_half_raised","rainbow:slope_wood_white_outer_half_raised")
minetest.register_alias("moreblocks:slab_pine_wood","rainbow:slab_wood_white")
minetest.register_alias("moreblocks:stair_pine_wood","rainbow:stair_wood_white")
minetest.register_alias("moreblocks:stair_aspen_wood","rainbow:stair_wood_white")
minetest.register_alias("moreblocks:stair_darkage_stone_brick","rainbow:fancybrick_grey")
minetest.register_alias("moreblocks:slope_pine_wood","rainbow:slope_wood_white")
minetest.register_alias("moreblocks:slope_pine_wood_half","rainbow:slope_wood_white_half")
minetest.register_alias("moreblocks:slope_pine_wood_half_raised","rainbow:slope_wood_white_half_raised")
minetest.register_alias("moreblocks:slope_pine_wood_inner","rainbow:slope_wood_white_inner")
minetest.register_alias("moreblocks:slope_pine_wood_inner_cut_half","rainbow:slope_wood_white_inner_half")
minetest.register_alias("moreblocks:slope_pine_wood_inner_cut_half_raised","rainbow:slope_wood_white_inner_half_raised")
minetest.register_alias("moreblocks:slope_pine_wood_outer","rainbow:slope_wood_white_outer")
minetest.register_alias("moreblocks:slope_pine_wood_outer_half_raised","rainbow:slope_wood_white_outer_half_raised")
minetest.register_alias("prefab:concrete","rainbow:render_grey")
minetest.register_alias("stained_glass:6_5_7","rainbow:coolglass_cyan")
minetest.register_alias("stained_glass:7_4_7","rainbow:coolglass_blue")
minetest.register_alias("stained_glass:10_3_6","rainbow:coolglass_darkred")



--minetest.register_alias("default:papyrus","rainbow:papyrus")

dofile(rainbow.modpath .. "/nodes.lua")
dofile(rainbow.modpath .. "/mapgen.lua")
dofile(rainbow.modpath .. "/goaway.lua")

WATER_ALPHA = minetest.registered_nodes["rainbow:white_water_source"].alpha
WATER_VISC = minetest.registered_nodes["rainbow:white_water_source"].liquid_viscosity



