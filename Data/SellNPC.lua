-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 04:26:08
-- Luau version 6, Types version 3
-- Time taken: 0.020591 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CalculatePlantValue_upvr = require(ReplicatedStorage.Modules.CalculatePlantValue)
local Comma_Module_upvr = require(ReplicatedStorage.Comma_Module)
local FoodService_upvr = require(ReplicatedStorage.Modules.FoodService)
local CalculatePetValue_upvr = require(ReplicatedStorage.Modules.CalculatePetValue)
local InventoryService_upvr = require(ReplicatedStorage.Modules.InventoryService)
local InventoryServiceEnums_upvr = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums)
local ItemTypeEnums_upvr = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums)
local Parent = script.Parent
local Parent_2_upvr = Parent.Parent.Parent
local Top_Text_upvr = require(game.ReplicatedStorage.Top_Text)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local function getSellableTools_upvr(arg1, arg2) -- Line 40, Named "getSellableTools"
	--[[ Upvalues[1]:
		[1]: InventoryServiceEnums_upvr (readonly)
	]]
	if arg1 then
		for _, v in pairs(arg1:GetChildren()) do
			if v:IsA("Tool") and (v:FindFirstChild("Item_String") or v:GetAttribute("PET_UUID") or v:HasTag("FoodTool")) or not v:GetAttribute(InventoryServiceEnums_upvr.Favorite) or arg2 or false then
				table.insert({}, v)
			end
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return {}
end
local function _(arg1, arg2, arg3, arg4) -- Line 66, Named "processSale"
	--[[ Upvalues[1]:
		[1]: CalculatePlantValue_upvr (readonly)
	]]
	local var22
	for _, v_2 in arg2 do
		if arg3 then
			var22 += CalculatePlantValue_upvr(v_2)
		end
	end
	if arg4 and 0 < var22 then
		arg4:FireServer()
	end
	return var22
end
local tbl = {"I want to sell my inventory", "I want to sell this", "How much is this worth?", "Nevermind"}
if workspace:GetAttribute("InTutorial") then
	tbl = {"I want to sell my inventory"}
end
local tbl_4 = {
	[tbl[1]] = function() -- Line 104
		--[[ Upvalues[6]:
			[1]: getSellableTools_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: CalculatePlantValue_upvr (readonly)
			[4]: Comma_Module_upvr (readonly)
			[5]: Top_Text_upvr (readonly)
			[6]: Parent_2_upvr (readonly)
		]]
		local tbl_5 = {}
		local _, pairs_result2_6, pairs_result3_4 = pairs(getSellableTools_upvr(LocalPlayer_upvr.Character))
		local var75
		for _, v_3 in var75, pairs_result2_6, pairs_result3_4 do
			table.insert(tbl_5, v_3)
		end
		var75 = pairs(getSellableTools_upvr(LocalPlayer_upvr.Backpack))
		local pairs_result1_2, pairs_result2_3, pairs_result3_7 = pairs(getSellableTools_upvr(LocalPlayer_upvr.Backpack))
		for _, v_4 in pairs_result1_2, pairs_result2_3, pairs_result3_7 do
			table.insert(tbl_5, v_4)
		end
		pairs_result1_2 = 0
		for i_5, v_5 in pairs(tbl_5) do
			pairs_result1_2 += CalculatePlantValue_upvr(v_5)
		end
		task.wait(0.5)
		if 0 < pairs_result1_2 then
			v_5 = Comma_Module_upvr.Comma(tostring(pairs_result1_2))
			i_5 = "\xA2</font>"
			i_5 = "Here is <font color='#FFFF00'>"..v_5..i_5
			v_5 = true
			Top_Text_upvr.NpcText(Parent_2_upvr, i_5, v_5)
			v_5 = game.ReplicatedStorage
			i_5 = v_5.GameEvents
			local Sell_Inventory_2 = i_5.Sell_Inventory
			i_5 = 0
			v_5 = tbl_5
			for _, v_6 in v_5 do
				i_5 += CalculatePlantValue_upvr(v_6)
			end
			if Sell_Inventory_2 then
				v_5 = 0
				if v_5 < i_5 then
					v_5 = Sell_Inventory_2:FireServer
					v_5()
				end
			end
			i_5 = 0.3
			v_5 = 0.4
			task.wait(math.random(i_5, v_5))
		else
			i_5 = true
			Top_Text_upvr.NpcText(Parent_2_upvr, "Nothing to buy...", i_5)
		end
		task.wait(1.5)
	end;
	[tbl[2]] = function() -- Line 130
		--[[ Upvalues[11]:
			[1]: getSellableTools_upvr (readonly)
			[2]: LocalPlayer_upvr (readonly)
			[3]: InventoryServiceEnums_upvr (readonly)
			[4]: Top_Text_upvr (readonly)
			[5]: Parent_2_upvr (readonly)
			[6]: ItemTypeEnums_upvr (readonly)
			[7]: CalculatePetValue_upvr (readonly)
			[8]: InventoryService_upvr (readonly)
			[9]: FoodService_upvr (readonly)
			[10]: CalculatePlantValue_upvr (readonly)
			[11]: Comma_Module_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local tbl_3 = {}
		task.wait(0.5)
		local var154
		for i_7, v_7 in getSellableTools_upvr(LocalPlayer_upvr.Character, true), nil do
			local var155
			if v_7:GetAttribute(InventoryServiceEnums_upvr.Favorite) then
				var155 = Top_Text_upvr
				var155 = Parent_2_upvr
				var155.NpcText(var155, "I won't buy favorited items.", true)
				var155 = math.random(0.7, 0.8)
				task.wait(var155)
			else
				local attribute_2 = v_7:GetAttribute(InventoryServiceEnums_upvr.ITEM_TYPE)
				var155 = 0
				if attribute_2 == ItemTypeEnums_upvr.Pet then
					var155 = CalculatePetValue_upvr(v_7)
					table.insert({}, v_7)
				elseif attribute_2 == ItemTypeEnums_upvr.Food then
					var155 = FoodService_upvr:CalculateFoodValue(v_7:GetAttribute(InventoryServiceEnums_upvr.ITEM_UUID), InventoryService_upvr:GetToolData(v_7))
					table.insert({}, v_7)
				else
					var155 = math.round(CalculatePlantValue_upvr(v_7))
					table.insert(tbl_3, v_7)
				end
				var154 += var155
			end
		end
		if 0 < var154 then
			v_7 = Comma_Module_upvr.Comma(tostring(var154))
			i_7 = "\xA2</font>"
			i_7 = "Here is <font color='#FFFF00'>"..v_7..i_7
			v_7 = true
			Top_Text_upvr.NpcText(Parent_2_upvr, i_7, v_7)
			if 0 < #tbl_3 then
				v_7 = game.ReplicatedStorage
				i_7 = v_7.GameEvents
				local Sell_Item_2 = i_7.Sell_Item
				i_7 = 0
				v_7 = tbl_3
				for _, v_8 in v_7 do
					i_7 += CalculatePlantValue_upvr(v_8)
				end
				if Sell_Item_2 then
					v_7 = 0
					if v_7 < i_7 then
						v_7 = Sell_Item_2:FireServer
						v_7()
					end
				end
			end
			i_7 = nil
			for _, v_9 in {}, nil, i_7 do
				game.ReplicatedStorage.GameEvents.SellPet_RE:FireServer(v_9)
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			end
			i_7 = nil
			for _, v_10 in {}, nil, i_7 do
				game.ReplicatedStorage.GameEvents.SellFood_RE:FireServer(v_10)
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			end
			i_7 = 0.3
			task.wait(math.random(i_7, 0.4))
		elseif not true then
			i_7 = true
			Top_Text_upvr.NpcText(Parent_2_upvr, "Nothing to buy...", i_7)
		end
	end;
}
local SellingStockClientService_upvr = require(ReplicatedStorage.Modules.SellingStockClientService)
tbl_4[tbl[3]] = function() -- Line 184
	--[[ Upvalues[12]:
		[1]: getSellableTools_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: InventoryServiceEnums_upvr (readonly)
		[4]: ItemTypeEnums_upvr (readonly)
		[5]: CalculatePetValue_upvr (readonly)
		[6]: InventoryService_upvr (readonly)
		[7]: FoodService_upvr (readonly)
		[8]: CalculatePlantValue_upvr (readonly)
		[9]: SellingStockClientService_upvr (readonly)
		[10]: Comma_Module_upvr (readonly)
		[11]: Top_Text_upvr (readonly)
		[12]: Parent_2_upvr (readonly)
	]]
	task.wait(0.5)
	local var167
	for i_11, v_11 in pairs(getSellableTools_upvr(LocalPlayer_upvr.Character, true)) do
		local attribute = v_11:GetAttribute(InventoryServiceEnums_upvr.ITEM_TYPE)
		if attribute == ItemTypeEnums_upvr.Pet then
		else
			if attribute == ItemTypeEnums_upvr.Food then
			end
			local Item_String = v_11:FindFirstChild("Item_String")
			if Item_String then
			end
		end
	end
	if 0 < math.ceil((var167 + CalculatePetValue_upvr(v_11) + FoodService_upvr:CalculateFoodValue(v_11:GetAttribute(InventoryServiceEnums_upvr.ITEM_UUID), InventoryService_upvr:GetToolData(v_11)) + CalculatePlantValue_upvr(v_11)) * SellingStockClientService_upvr:GetCurrentStockMultiplier(Item_String.Value)) then
		v_11 = Comma_Module_upvr.Comma
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		v_11 = v_11(tostring(math.ceil((var167 + CalculatePetValue_upvr(v_11) + FoodService_upvr:CalculateFoodValue(v_11:GetAttribute(InventoryServiceEnums_upvr.ITEM_UUID), InventoryService_upvr:GetToolData(v_11)) + CalculatePlantValue_upvr(v_11)) * SellingStockClientService_upvr:GetCurrentStockMultiplier(Item_String.Value))))
		i_11 = "\xA2</font>"
		i_11 = "I'd value it at <font color='#FFFF00'>"..v_11..i_11
		v_11 = true
		Top_Text_upvr.NpcText(Parent_2_upvr, i_11, v_11)
		i_11 = 1.3
		v_11 = 1.8
		task.wait(math.random(i_11, v_11))
	else
		Top_Text_upvr.NpcText(Parent_2_upvr, "I don't see anything...", true)
	end
end
tbl_4[tbl[4]] = function() -- Line 222
	task.wait(0.5)
end
require(ReplicatedStorage.Modules.NPCDialogueController):Start({
	ProximityPrompt = Parent;
	SpeakingNPC = Parent_2_upvr;
	PromptList = tbl;
	OperationMap = tbl_4;
	IntroLines = {"Got anything to sell?"};
	ExitLine = "Goodbye!";
	RootPart = Parent.Parent;
	DeactivationDistance = 20;
	OnDialogueEnded = function() -- Line 237, Named "OnDialogueEnded"
	end;
	OnDialogueStarted = function() -- Line 240, Named "OnDialogueStarted"
	end;
})









-- Remote สำหรับขายของ (อ้างอิงชื่อตาม Decompiled Code เดิม + rspy)
local Sell_Inventory = GameEvents:WaitForChild("Sell_Inventory") -- ขายเหมา
local Sell_Item      = GameEvents:WaitForChild("Sell_Item")      -- ขายชิ้นเดียว (พืช)
local SellPet_RE     = GameEvents:FindFirstChild("SellPet_RE")   -- ขายสัตว์เลี้ยง
local SellFood_RE    = GameEvents:FindFirstChild("SellFood_RE")  -- ขายอาหาร