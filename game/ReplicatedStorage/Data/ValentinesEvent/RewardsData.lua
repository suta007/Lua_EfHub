-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-14 18:40:54
-- Luau version 6, Types version 3
-- Time taken: 0.001647 seconds

local Types = require(game:GetService("ReplicatedStorage").Modules.GiveServiceCommon).Types
return {
	Rewards = {
		{
			Items = { Types.Cosmetic:Use("Heart Bench", 1) },
			ImageId = "rbxassetid://128917754594343",
			ItemName = "Heart Bench",
			Price = 30,
		},
		{
			Items = { Types.Seed:Use("Pink Rose", 1) },
			ImageId = "rbxassetid://140635830048990",
			ItemName = "Pink Rose",
			Price = 100,
		},
		{
			Items = { Types.Cosmetic:Use("Valentine Arch", 1) },
			ImageId = "rbxassetid://97219704562929",
			ItemName = "Valentine Arch",
			Price = 250,
		},
		{
			Items = { Types.Pet:Use("Pink Panda", 1) },
			ImageId = "rbxassetid://103412834589201",
			ItemName = "Pink Panda",
			Price = 600,
		},
		{
			Items = { Types.Pet:Use("Red Rose Fox", 1) },
			ImageId = "rbxassetid://100539117208884",
			ItemName = "Red Rose Fox",
			Price = 3000,
		},
	},
}

-- game:GetService("ReplicatedStorage").GameEvents.ValentinesEvent.GiveHeartstruckFruits
-- game:GetService("ReplicatedStorage").GameEvents.ValentinesEvent.ClaimValentineReward
