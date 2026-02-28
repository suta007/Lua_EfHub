local v1 = {}
local v2 = {}
local v3 = {
	["SprinklerMakerThingy"] = {
		["Capacity"] = 1,
		["MachineType"] = "SprinklerMakerThingy",
	},
	["EventWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "EventWorkbench",
	},
}
v2.Slots = v3
v1["Work Bench"] = v2
local v4 = {}
local v5 = {
	["GearEventWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "GearEventWorkbench",
	},
}
v4.Slots = v5
v1.GearEventWorkbench = v4
local v6 = {}
local v7 = {
	["DinoEventWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "DinoEventWorkbench",
	},
}
v6.Slots = v7
v1.DinoEventWorkbench = v6
local v8 = {}
local v9 = {
	["GiantBeanstalkEventWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "GiantBeanstalkEventWorkbench",
	},
}
v8.Slots = v9
v1.GiantBeanstalkEventWorkbench = v8
local v10 = {}
local v11 = {
	["SmithingEventSeedWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "SmithingEventSeedWorkbench",
	},
}
v10.Slots = v11
v1.SmithingEventSeedWorkbench = v10
local v12 = {}
local v13 = {
	["SmithingEventGearWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "SmithingEventGearWorkbench",
	},
}
v12.Slots = v13
v1.SmithingEventGearWorkbench = v12
local v14 = {}
local v15 = {
	["SmithingEventPetWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "SmithingEventPetWorkbench",
	},
}
v14.Slots = v15
v1.SmithingEventPetWorkbench = v14
local v16 = {}
local v17 = {
	["SmithingEventCosmeticWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "SmithingEventCosmeticWorkbench",
	},
}
v16.Slots = v17
v1.SmithingEventCosmeticWorkbench = v16
local v18 = {}
local v19 = {
	["SeedEventWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "SeedEventWorkbench",
	},
}
v18.Slots = v19
v1.SeedEventWorkbench = v18
local v20 = {}
local v21 = {
	["FairyGeniusEventWorkbench"] = {
		["Capacity"] = 1,
		["MachineType"] = "FairyGeniusEventWorkbench",
	},
}
v20.Slots = v21
v1.FairyGeniusEventWorkbench = v20
local v22 = {}
local v23 = {
	["FairyWorldCraftingWorkBench"] = {
		["Capacity"] = 1,
		["MachineType"] = "FairyWorldCraftingWorkBench",
	},
}
v22.Slots = v23
v1.FairyWorldCraftingWorkBench = v22
local v24 = {}
local v25 = {
	["Saw"] = {
		["Capacity"] = 1,
		["MachineType"] = "Saw",
	},
	["Grindstone"] = {
		["Capacity"] = 1,
		["MachineType"] = "Saw",
	},
	["Brewing Potion"] = {
		["Capacity"] = 1,
		["MachineType"] = "Brewing",
	},
}
v24.Slots = v25
v1.Workbench = v24
return v1
