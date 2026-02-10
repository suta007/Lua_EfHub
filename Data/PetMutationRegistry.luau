-- game:GetService("ReplicatedStorage").Data.PetRegistry.PetMutationRegistry
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 23:06:00
-- Luau version 6, Types version 3
-- Time taken: 0.022685 seconds

local var156_upvw
local function _(arg1) -- Line 723, Named "NormalizeOdds"
	--[[ Upvalues[1]:
		[1]: var156_upvw (read and write)
	]]
	local var161 = 0
	for _, v in arg1 do
		var161 += v.Chance
	end
	var156_upvw = var161
end
function RollRandomMutation(arg1) -- Line 740
	--[[ Upvalues[1]:
		[1]: var156_upvw (read and write)
	]]
	for i_2, v_2 in arg1 do
		if 0 + v_2.Chance >= Random.new():NextNumber() * (var156_upvw or 1) then
			return i_2
		end
	end
	return nil
end
local tbl = {}
local var165
for i_3, v_3 in var165 do
	({})[v_3.EnumId] = i_3
	;({})[i_3] = v_3.EnumId
	if v_3.AvaliableFromMutationMachine then
		tbl[i_3] = v_3
	end
end
var165 = 0
for _, v_4 in tbl do
	var165 += v_4.Chance
end
var156_upvw = var165
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
;({}).PetMutationToEnum = {}
-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
;({}).EnumToPetMutation = {}
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
;({}).MachineMutationTypes = tbl
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
;({}).PetMutationRegistry = {
	Shocked = {
		EnumId = 'a';
		Boosts = {};
		Passives = {"Shocked Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 10;
		ValueMulti = 100;
		Color = Color3.fromRGB(255, 255, 100);
	};
	Golden = {
		EnumId = 'b';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.1;
		}};
		Passives = {"Golden Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 20;
		ValueMulti = 100;
		Color = Color3.fromRGB(255, 225, 0);
	};
	Rainbow = {
		EnumId = 'c';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.2;
		}};
		Passives = {"Rainbow Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 10;
		ValueMulti = 100;
		Color = Color3.fromRGB(4, 175, 236);
	};
	Shiny = {
		EnumId = 'd';
		Boosts = {{
			BoostType = "PET_XP_BOOST";
			BoostAmount = 0.3;
		}};
		Passives = {"Shiny Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 100;
		ValueMulti = 10;
		Color = Color3.fromRGB(145, 207, 221);
	};
	Windy = {
		EnumId = 'e';
		Boosts = {};
		Passives = {"Windy Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 30;
		ValueMulti = 2;
		Color = Color3.fromRGB(162, 185, 209);
	};
	Frozen = {
		EnumId = 'f';
		Boosts = {{}};
		Passives = {"Frozen Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 30;
		ValueMulti = 10;
		Color = Color3.fromRGB(108, 184, 255);
	};
	Inverted = {
		EnumId = 'g';
		Boosts = {{
			BoostType = "PET_XP_BOOST";
			BoostAmount = 0.5;
		}};
		Passives = {"Inverted Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 50;
		ValueMulti = 10;
		Color = Color3.fromRGB(128, 128, 128);
	};
	Rideable = {
		EnumId = 'h';
		Boosts = {{}};
		Passives = {};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(255, 255, 255);
	};
	Mega = {
		EnumId = 'i';
		Boosts = {{
			BoostType = "SIZE_MODIFICATION";
			BoostAmount = 2;
		}};
		Passives = {"Mega Pet Mutation", "Mega Pet Mutation Bonus"};
		AvaliableFromMutationMachine = true;
		Chance = 20;
		ValueMulti = 1;
		Color = Color3.fromRGB(255, 90, 90);
	};
	Tiny = {
		EnumId = 'j';
		Boosts = {{
			BoostType = "SIZE_MODIFICATION";
			BoostAmount = -0.9;
		}};
		Passives = {"Tiny Pet Mutation", "Tiny Pet Mutation Bonus"};
		AvaliableFromMutationMachine = true;
		Chance = 20;
		ValueMulti = 1;
		Color = Color3.fromRGB(173, 216, 230);
	};
	IronSkin = {
		EnumId = 'k';
		Boosts = {{}};
		Passives = {"IronSkin Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(206, 206, 206);
	};
	Radiant = {
		EnumId = 'l';
		Boosts = {{}};
		Passives = {"Radiant Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 10;
		ValueMulti = 100;
		Color = Color3.fromRGB(248, 108, 38);
	};
	Normal = {
		EnumId = 'm';
		Boosts = {};
		Passives = {};
		AvaliableFromMutationMachine = false;
		ValueMulti = 1;
		Color = Color3.fromRGB(255, 255, 255);
	};
	Ascended = {
		EnumId = 'n';
		Boosts = {};
		Passives = {"Ascended Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 1;
		ValueMulti = 100;
		Color = Color3.fromRGB(247, 245, 184);
	};
	Tranquil = {
		EnumId = 'o';
		Boosts = {};
		Passives = {"Tranquil Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(94, 247, 247);
	};
	Corrupted = {
		EnumId = 'p';
		Boosts = {};
		Passives = {"Corrupted Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(176, 23, 26);
	};
	Fried = {
		EnumId = 'q';
		Boosts = {};
		Passives = {"Fried Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 15;
		Color = Color3.fromRGB(170, 99, 0);
	};
	Aromatic = {
		EnumId = 'r';
		Boosts = {};
		Passives = {"Aromatic Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(162, 145, 57);
	};
	Silver = {
		EnumId = 's';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.05;
		}};
		Passives = {"Silver Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 10;
		Color = Color3.fromRGB(222, 222, 222);
	};
	GiantBean = {
		EnumId = 't';
		Boosts = {{
			BoostType = "SIZE_MODIFICATION";
			BoostAmount = 1.5;
		}};
		Passives = {"GiantBean Pet Mutation", "GiantBean Pet Mutation Bonus"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(102, 153, 51);
	};
	Glimmering = {
		EnumId = 'u';
		Boosts = {};
		Passives = {"Glimmering Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(255, 135, 245);
	};
	Luminous = {
		EnumId = 'v';
		Boosts = {};
		Passives = {"Luminous Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(85, 170, 255);
	};
	Nutty = {
		EnumId = 'w';
		Boosts = {};
		Passives = {"Nutty Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(154, 109, 69);
	};
	Dreadbound = {
		EnumId = 'x';
		Boosts = {};
		Passives = {"Dreadbound Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(140, 45, 175);
	};
	Soulflame = {
		EnumId = 'y';
		Boosts = {{
			BoostType = "PET_XP_BOOST";
			BoostAmount = 0.6;
		}};
		Passives = {"Soulflame Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(255, 85, 40);
	};
	Spectral = {
		EnumId = 'z';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.08;
		}};
		Passives = {"Spectral Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(90, 200, 255);
	};
	Nightmare = {
		EnumId = 'A';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.22;
		}, {
			BoostType = "SIZE_MODIFICATION";
			BoostAmount = 1.25;
		}};
		Passives = {"Nightmare Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(255, 0, 100);
	};
	Tethered = {
		EnumId = 'B';
		Boosts = {};
		Passives = {"Tethered Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(210, 171, 136);
	};
	Aurora = {
		EnumId = 'H';
		Boosts = {{}};
		Passives = {"Aurora Pet Mutation"};
		AvaliableFromMutationMachine = true;
		Chance = 10;
		ValueMulti = 10;
		Color = Color3.fromRGB(165, 105, 255);
	};
	JUMBO = {
		EnumId = 'I';
		Boosts = {{
			BoostType = "SIZE_MODIFICATION";
			BoostAmount = 1.8;
		}, {
			BoostType = "PET_XP_BOOST";
			BoostAmount = 0.5;
		}};
		Passives = {"JUMBO Pet Mutation", "JUMBO Pet Mutation Bonus"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 10;
		Color = Color3.fromRGB(255, 170, 0);
	};
	Oxpecker = {
		EnumId = 'J';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.01;
		}};
		Passives = {"Oxpecker Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 1;
		Color = Color3.fromRGB(170, 0, 0);
	};
	Giraffe = {
		EnumId = 'K';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.03;
		}};
		Passives = {"Giraffe Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 5;
		Color = Color3.fromRGB(255, 215, 0);
	};
	Rhino = {
		EnumId = 'L';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.045;
		}};
		Passives = {"Rhino Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 10;
		Color = Color3.fromRGB(211, 211, 211);
	};
	Crocodile = {
		EnumId = 'M';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.06;
		}};
		Passives = {"Crocodile Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 15;
		Color = Color3.fromRGB(85, 170, 0);
	};
	Lion = {
		EnumId = 'N';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.07;
		}};
		Passives = {"Lion Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 20;
		Color = Color3.fromRGB(255, 255, 102);
	};
	Forger = {
		EnumId = 'O';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.07;
		}};
		Passives = {"Forger Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 10;
		Color = Color3.fromRGB(150, 150, 150);
	};
	HyperHunger = {
		EnumId = 'P';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.3;
		}};
		Passives = {"HyperHunger Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(255, 255, 0);
	};
	Nocturnal = {
		EnumId = 'Q';
		Boosts = {{}};
		Passives = {"Nocturnal Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 15;
		Color = Color3.fromRGB(85, 85, 255);
	};
	Peppermint = {
		EnumId = 'R';
		Boosts = {{}};
		Passives = {"Peppermint Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 25;
		Color = Color3.fromRGB(255, 134, 134);
	};
	SpiritSparkle = {
		EnumId = "SS";
		Boosts = {{}};
		Passives = {"Spirit Sparkle Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 25;
		Color = Color3.fromRGB(217, 244, 255);
	};
	ChristmasRally = {
		EnumId = 'S';
		Boosts = {{}};
		Passives = {"Christmas Rally Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 10;
		Color = Color3.fromRGB(0, 200, 0);
	};
	MerryNursery = {
		EnumId = 'T';
		Boosts = {{}};
		Passives = {"Merry Nursery Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 20;
		Color = Color3.fromRGB(255, 215, 0);
	};
	JollyDecorator = {
		EnumId = 'U';
		Boosts = {{}};
		Passives = {"Jolly Decorator Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 50;
		Color = Color3.fromRGB(200, 0, 0);
	};
	GiantGolem = {
		EnumId = 'V';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.2;
		}, {
			BoostType = "SIZE_MODIFICATION";
			BoostAmount = 1.5;
		}};
		Passives = {"Giant Golem Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(120, 180, 255);
	};
	Fiery = {
		EnumId = 'W';
		Boosts = {};
		Passives = {"Fiery Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(255, 128, 0);
	};
	Venom = {
		EnumId = 'X';
		Boosts = {{
			BoostType = "PASSIVE_BOOST";
			BoostAmount = 0.3;
		}};
		Passives = {"Venom Pet Mutation"};
		AvaliableFromMutationMachine = false;
		Chance = 0;
		ValueMulti = 100;
		Color = Color3.fromRGB(149, 0, 255);
	};
}
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
;({}).RollRandomMutation = RollRandomMutation
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
return {}
