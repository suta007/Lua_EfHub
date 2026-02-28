--game:GetService("ReplicatedStorage").Data.CraftingData.CraftingRecipeRegistry

local v1 = game:GetService("ReplicatedStorage")
require(v1.Data.CraftingData.CraftingTypeRegistry)
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Basic Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v4[1] = v5
local v6 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Advanced Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v4[2] = v6
local v7 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v4[3] = v7
v3.Inputs = v4
local v8 = {}
local v9 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Lightning Rod",
		["Quantity"] = 1,
	},
}
v8[1] = v9
v3.Outputs = v8
v3.TimeToCraft = 2700
v3.PurchaseID = 3265946758
v3.RobuxPrice = 179
v3.LayoutOrder = 5
v3.MachineTypes = { "GearEventWorkbench" }
v3.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 500000,
}
v2["Lightning Rod"] = v3
local v10 = {}
local v11 = {}
local v12 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Basic Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v11[1] = v12
local v13 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Advanced Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v11[2] = v13
local v14 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v11[3] = v14
v10.Inputs = v11
local v15 = {}
local v16 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Tanning Mirror",
		["Quantity"] = 1,
	},
}
v15[1] = v16
v10.Outputs = v15
v10.TimeToCraft = 2700
v10.PurchaseID = 3311159836
v10.RobuxPrice = 219
v10.LayoutOrder = 6
v10.MachineTypes = { "GearEventWorkbench" }
v10.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 500000,
}
v2["Tanning Mirror"] = v10
local v17 = {}
local v18 = {}
local v19 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v18[1] = v19
local v20 = {
	["ItemType"] = "Harvest Tool",
	["ItemData"] = {
		["ItemName"] = "Harvest Tool",
		["AcceptAllTypes"] = false,
	},
}
v18[2] = v20
v17.Inputs = v18
local v21 = {}
local v22 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Reclaimer",
		["Quantity"] = 3,
	},
}
v21[1] = v22
v17.Outputs = v21
v17.TimeToCraft = 1500
v17.PurchaseID = 3309686533
v17.RobuxPrice = 199
v17.LayoutOrder = 8
v17.MachineTypes = { "GearEventWorkbench" }
v17.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 500000,
}
v2.Reclaimer = v17
local v23 = {}
local v24 = {}
local v25 = {
	["ItemType"] = "Recall Wrench",
	["ItemData"] = {
		["ItemName"] = "Recall Wrench",
		["AcceptAllTypes"] = false,
	},
}
v24[1] = v25
local v26 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Apple",
		["AcceptAllTypes"] = false,
	},
}
v24[2] = v26
v23.Inputs = v24
local v27 = {}
local v28 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Event Lantern",
		["Quantity"] = 30,
	},
}
v27[1] = v28
v23.Outputs = v27
v23.TimeToCraft = 10
v23.PurchaseID = 3388358462
v23.RobuxPrice = 39
v23.LayoutOrder = 10
v23.MachineTypes = { "GearEventWorkbench" }
v23.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 350000,
}
v2["Event Lantern"] = v23
local v29 = {}
local v30 = {}
local v31 = {
	["ItemType"] = "SprayBottle",
	["ItemData"] = {
		["ItemName"] = "Cleaning Spray",
		["AcceptAllTypes"] = false,
	},
}
v30[1] = v31
local v32 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Orange Tulip",
		["AcceptAllTypes"] = false,
	},
}
v30[2] = v32
local v33 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v30[3] = v33
local v34 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Mango",
		["AcceptAllTypes"] = false,
	},
}
v30[4] = v34
v29.Inputs = v30
local v35 = {}
local v36 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Mutation Spray Glimmering",
		["Quantity"] = 1,
	},
}
v35[1] = v36
v29.Outputs = v35
v29.TimeToCraft = 900
v29.PurchaseID = 3388357651
v29.RobuxPrice = 159
v29.LayoutOrder = 12
v29.DisplayInCrafting = false
v29.MachineTypes = { "GearEventWorkbench" }
v29.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Mutation Spray Glimmering"] = v29
local v37 = {}
local v38 = {}
local v39 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v38[1] = v39
local v40 = {
	["ItemType"] = "Food",
	["ItemData"] = {
		["ItemName"] = "Corndog",
		["Quantity"] = 1,
	},
}
v38[2] = v40
local v41 = {
	["ItemType"] = "PetBoost",
	["ItemData"] = {
		["ItemName"] = "Small Treat",
		["AcceptAllTypes"] = false,
	},
}
v38[3] = v41
local v42 = {
	["ItemType"] = "PetBoost",
	["ItemData"] = {
		["ItemName"] = "Small Toy",
		["AcceptAllTypes"] = false,
	},
}
v38[4] = v42
v37.Inputs = v38
local v43 = {}
local v44 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Pet Pouch",
		["Quantity"] = 1,
	},
}
v43[1] = v44
v37.Outputs = v43
v37.TimeToCraft = 1800
v37.PurchaseID = 3369521127
v37.RobuxPrice = 89
v37.LayoutOrder = 118
v37.MachineTypes = { "GearEventWorkbench" }
v37.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 50000000,
}
v2["Pet Pouch"] = v37
local v45 = {}
local v46 = {}
local v47 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v46[1] = v47
local v48 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Coconut",
		["AcceptAllTypes"] = false,
	},
}
v46[2] = v48
local v49 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Coconut",
		["AcceptAllTypes"] = false,
	},
}
v46[3] = v49
v45.Inputs = v46
local v50 = {}
local v51 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Small Toy",
		["Quantity"] = 3,
	},
}
v50[1] = v51
v45.Outputs = v50
v45.TimeToCraft = 600
v45.PurchaseID = 3329526448
v45.RobuxPrice = 139
v45.LayoutOrder = 113
v45.MachineTypes = { "GearEventWorkbench" }
v45.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Small Toy"] = v45
local v52 = {}
local v53 = {}
local v54 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v53[1] = v54
local v55 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Dragon Fruit",
		["AcceptAllTypes"] = false,
	},
}
v53[2] = v55
local v56 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Blueberry",
		["AcceptAllTypes"] = false,
	},
}
v53[3] = v56
v52.Inputs = v53
local v57 = {}
local v58 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Small Treat",
		["Quantity"] = 3,
	},
}
v57[1] = v58
v52.Outputs = v57
v52.TimeToCraft = 600
v52.PurchaseID = 3329527534
v52.RobuxPrice = 89
v52.LayoutOrder = 115
v52.MachineTypes = { "GearEventWorkbench" }
v52.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Small Treat"] = v52
local v59 = {}
local v60 = {}
local v61 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Coconut",
		["AcceptAllTypes"] = false,
	},
}
v60[1] = v61
local v62 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Dragon Fruit",
		["AcceptAllTypes"] = false,
	},
}
v60[2] = v62
local v63 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Mango",
		["AcceptAllTypes"] = false,
	},
}
v60[3] = v63
local v64 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v60[4] = v64
v59.Inputs = v60
local v65 = {}
local v66 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Tropical Mist Sprinkler",
		["Quantity"] = 1,
	},
}
v65[1] = v66
v59.Outputs = v65
v59.TimeToCraft = 3600
v59.PurchaseID = 3306484251
v59.RobuxPrice = 229
v59.LayoutOrder = 10
v59.MachineTypes = { "GearEventWorkbench" }
v59.DisplayInCrafting = false
v2["Tropical Mist Sprinkler"] = v59
local v67 = {}
local v68 = {}
local v69 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Grape",
		["AcceptAllTypes"] = false,
	},
}
v68[1] = v69
local v70 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Blueberry",
		["AcceptAllTypes"] = false,
	},
}
v68[2] = v70
local v71 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Strawberry",
		["AcceptAllTypes"] = false,
	},
}
v68[3] = v71
local v72 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v68[4] = v72
v67.Inputs = v68
local v73 = {}
local v74 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Berry Blusher Sprinkler",
		["Quantity"] = 1,
	},
}
v73[1] = v74
v67.Outputs = v73
v67.TimeToCraft = 3600
v67.PurchaseID = 3306484242
v67.RobuxPrice = 229
v67.LayoutOrder = 20
v67.MachineTypes = { "GearEventWorkbench" }
v67.DisplayInCrafting = false
v2["Berry Blusher Sprinkler"] = v67
local v75 = {}
local v76 = {}
local v77 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Pepper",
		["AcceptAllTypes"] = false,
	},
}
v76[1] = v77
local v78 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Ember Lily",
		["AcceptAllTypes"] = false,
	},
}
v76[2] = v78
local v79 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Cacao",
		["AcceptAllTypes"] = false,
	},
}
v76[3] = v79
local v80 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Master Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v76[4] = v80
v75.Inputs = v76
local v81 = {}
local v82 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Spice Spritzer Sprinkler",
		["Quantity"] = 1,
	},
}
v81[1] = v82
v75.Outputs = v81
v75.TimeToCraft = 3600
v75.PurchaseID = 3306484232
v75.RobuxPrice = 229
v75.LayoutOrder = 30
v75.MachineTypes = { "GearEventWorkbench" }
v75.DisplayInCrafting = false
v2["Spice Spritzer Sprinkler"] = v75
local v83 = {}
local v84 = {}
local v85 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Watermelon",
		["AcceptAllTypes"] = false,
	},
}
v84[1] = v85
local v86 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Watermelon",
		["AcceptAllTypes"] = false,
	},
}
v84[2] = v86
local v87 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Watermelon",
		["AcceptAllTypes"] = false,
	},
}
v84[3] = v87
local v88 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Master Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v84[4] = v88
v83.Inputs = v84
local v89 = {}
local v90 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Sweet Soaker Sprinkler",
		["Quantity"] = 1,
	},
}
v89[1] = v90
v83.Outputs = v89
v83.TimeToCraft = 3600
v83.PurchaseID = 3306484252
v83.RobuxPrice = 229
v83.LayoutOrder = 40
v83.MachineTypes = { "GearEventWorkbench" }
v83.DisplayInCrafting = false
v2["Sweet Soaker Sprinkler"] = v83
local v91 = {}
local v92 = {}
local v93 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Orange Tulip",
		["AcceptAllTypes"] = false,
	},
}
v92[1] = v93
local v94 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v92[2] = v94
local v95 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Advanced Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v92[3] = v95
local v96 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Basic Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v92[4] = v96
v91.Inputs = v92
local v97 = {}
local v98 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Flower Froster Sprinkler",
		["Quantity"] = 1,
	},
}
v97[1] = v98
v91.Outputs = v97
v91.TimeToCraft = 3600
v91.PurchaseID = 3306484243
v91.RobuxPrice = 229
v91.LayoutOrder = 50
v91.MachineTypes = { "GearEventWorkbench" }
v91.DisplayInCrafting = false
v2["Flower Froster Sprinkler"] = v91
local v99 = {}
local v100 = {}
local v101 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v100[1] = v101
local v102 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v100[2] = v102
local v103 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Mushroom",
		["AcceptAllTypes"] = false,
	},
}
v100[3] = v103
local v104 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Advanced Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v100[4] = v104
v99.Inputs = v100
local v105 = {}
local v106 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Stalk Sprout Sprinkler",
		["Quantity"] = 1,
	},
}
v105[1] = v106
v99.Outputs = v105
v99.TimeToCraft = 3600
v99.PurchaseID = 3306484241
v99.RobuxPrice = 229
v99.LayoutOrder = 60
v99.MachineTypes = { "GearEventWorkbench" }
v99.DisplayInCrafting = false
v2["Stalk Sprout Sprinkler"] = v99
local v107 = {}
local v108 = {}
local v109 = {
	["ItemType"] = "SprayBottle",
	["ItemData"] = {
		["ItemName"] = "Cleaning Spray",
		["AcceptAllTypes"] = false,
	},
}
v108[1] = v109
local v110 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Cacao",
		["AcceptAllTypes"] = false,
	},
}
v108[2] = v110
v107.Inputs = v108
local v111 = {}
local v112 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Mutation Spray Choc",
		["Quantity"] = 1,
	},
}
v111[1] = v112
v107.Outputs = v111
v107.TimeToCraft = 720
v107.PurchaseID = 3306484247
v107.RobuxPrice = 179
v107.LayoutOrder = 70
v107.MachineTypes = { "GearEventWorkbench" }
v107.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 200000,
}
v107.DisplayInCrafting = false
v2["Mutation Spray Choc"] = v107
local v113 = {}
local v114 = {}
local v115 = {
	["ItemType"] = "SprayBottle",
	["ItemData"] = {
		["ItemName"] = "Cleaning Spray",
		["AcceptAllTypes"] = false,
	},
}
v114[1] = v115
local v116 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v114[2] = v116
v113.Inputs = v114
local v117 = {}
local v118 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Mutation Spray Chilled",
		["Quantity"] = 1,
	},
}
v117[1] = v118
v113.Outputs = v117
v113.TimeToCraft = 300
v113.PurchaseID = 3317772898
v113.RobuxPrice = 189
v113.LayoutOrder = 80
v113.DisplayInCrafting = false
v113.MachineTypes = { "GearEventWorkbench" }
v113.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 500000,
}
v2["Mutation Spray Chilled"] = v113
local v119 = {}
local v120 = {}
local v121 = {
	["ItemType"] = "SprayBottle",
	["ItemData"] = {
		["ItemName"] = "Cleaning Spray",
		["AcceptAllTypes"] = false,
	},
}
v120[1] = v121
local v122 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bee Balm",
		["AcceptAllTypes"] = false,
	},
}
v120[2] = v122
v119.Inputs = v120
local v123 = {}
local v124 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Mutation Spray Pollinated",
		["Quantity"] = 1,
	},
}
v123[1] = v124
v119.Outputs = v123
v119.TimeToCraft = 300
v119.PurchaseID = 3306484250
v119.RobuxPrice = 179
v119.LayoutOrder = 80
v119.MachineTypes = { "GearEventWorkbench" }
v119.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 25,
}
v119.DisplayInCrafting = false
v2["Mutation Spray Pollinated"] = v119
local v125 = {}
local v126 = {}
local v127 = {
	["ItemType"] = "SprayBottle",
	["ItemData"] = {
		["ItemName"] = "Cleaning Spray",
		["AcceptAllTypes"] = false,
	},
}
v126[1] = v127
local v128 = {
	["ItemType"] = "Lightning Rod",
	["ItemData"] = {
		["ItemName"] = "Lightning Rod",
		["AcceptAllTypes"] = false,
	},
}
v126[2] = v128
v125.Inputs = v126
local v129 = {}
local v130 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Mutation Spray Shocked",
		["Quantity"] = 1,
	},
}
v129[1] = v130
v125.Outputs = v129
v125.TimeToCraft = 1800
v125.PurchaseID = 3306484253
v125.RobuxPrice = 199
v125.LayoutOrder = 90
v125.MachineTypes = { "GearEventWorkbench" }
v125.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v125.DisplayInCrafting = false
v2["Mutation Spray Shocked"] = v125
local v131 = {}
local v132 = {}
local v133 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Bee Crate",
		["AcceptAllTypes"] = false,
	},
}
v132[1] = v133
v131.Inputs = v132
local v134 = {}
local v135 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Honey Crafters Crate",
		["Quantity"] = 1,
	},
}
v134[1] = v135
v131.Outputs = v134
v131.TimeToCraft = 1800
v131.PurchaseID = 3306484248
v131.RobuxPrice = 179
v131.LayoutOrder = 100
v131.MachineTypes = { "GearEventWorkbench" }
v131.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 12,
}
v131.DisplayInCrafting = false
v2["Honey Crafters Crate"] = v131
local v136 = {}
local v137 = {}
local v138 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Bee Egg",
		["AcceptAllTypes"] = false,
	},
}
v137[1] = v138
v136.Inputs = v137
local v139 = {}
local v140 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Anti Bee Egg",
		["Quantity"] = 1,
	},
}
v139[1] = v140
v136.Outputs = v139
v136.TimeToCraft = 7200
v136.PurchaseID = 3306484244
v136.RobuxPrice = 149
v136.LayoutOrder = 110
v136.MachineTypes = { "GearEventWorkbench" }
v136.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 25,
}
v2["Anti Bee Egg"] = v136
local v141 = {}
local v142 = {}
local v143 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Anti Bee Egg",
		["AcceptAllTypes"] = false,
	},
}
v142[1] = v143
local v144 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Legacy Sunflower",
		["AcceptAllTypes"] = false,
	},
}
v142[2] = v144
local v145 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Purple Dahlia",
		["AcceptAllTypes"] = false,
	},
}
v142[3] = v145
v141.Inputs = v142
local v146 = {}
local v147 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Pack Bee",
		["Quantity"] = 1,
	},
}
v146[1] = v147
v141.Outputs = v146
v141.TimeToCraft = 14400
v141.PurchaseID = 3306484257
v141.RobuxPrice = 799
v141.LayoutOrder = 120
v141.MachineTypes = { "GearEventWorkbench" }
v141.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 250,
}
v2["Pack Bee"] = v141
local v148 = {}
local v149 = {}
local v150 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Sugar Apple",
		["AcceptAllTypes"] = false,
	},
}
v149[1] = v150
local v151 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Buttercup",
		["AcceptAllTypes"] = false,
	},
}
v149[2] = v151
local v152 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Basic Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v149[3] = v152
v148.Inputs = v149
local v153 = {}
local v154 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Silver Ingot",
		["Quantity"] = 1,
	},
}
v153[1] = v154
v148.Outputs = v153
v148.TimeToCraft = 60
v148.PurchaseID = 3460380386
v148.RobuxPrice = 29
v148.LayoutOrder = 130
v148.MachineTypes = { "GearEventWorkbench" }
v148.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 150000,
}
v2["Silver Ingot"] = v148
local v155 = {}
local v156 = {}
local v157 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Giant Pinecone",
		["AcceptAllTypes"] = false,
	},
}
v156[1] = v157
local v158 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v156[2] = v158
local v159 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Advanced Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v156[3] = v159
v155.Inputs = v156
local v160 = {}
local v161 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Gold Ingot",
		["Quantity"] = 1,
	},
}
v160[1] = v161
v155.Outputs = v160
v155.TimeToCraft = 60
v155.PurchaseID = 3460381002
v155.RobuxPrice = 33
v155.LayoutOrder = 140
v155.MachineTypes = { "GearEventWorkbench" }
v155.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 300000,
}
v2["Gold Ingot"] = v155
local v162 = {}
local v163 = {}
local v164 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Pig",
		["AcceptAllTypes"] = false,
	},
}
v163[1] = v164
local v165 = {
	["ItemType"] = "Food",
	["ItemData"] = {
		["ItemName"] = "Sushi",
		["Quantity"] = 1,
	},
}
v163[2] = v165
local v166 = {
	["ItemType"] = "Lightning Rod",
	["ItemData"] = {
		["ItemName"] = "Lightning Rod",
		["AcceptAllTypes"] = false,
	},
}
v163[3] = v166
local v167 = {
	["ItemType"] = "PetBoost",
	["ItemData"] = {
		["ItemName"] = "Medium Toy",
		["AcceptAllTypes"] = false,
	},
}
v163[4] = v167
v162.Inputs = v163
local v168 = {}
local v169 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Silver Piggy",
		["Quantity"] = 1,
	},
}
v168[1] = v169
v162.Outputs = v168
v162.TimeToCraft = 1800
v162.PurchaseID = 3460381175
v162.RobuxPrice = 419
v162.LayoutOrder = 150
v162.MachineTypes = { "GearEventWorkbench" }
v162.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 150000000,
}
v2["Silver Piggy"] = v162
local v170 = {}
local v171 = {}
local v172 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Silver Piggy",
		["AcceptAllTypes"] = false,
	},
}
v171[1] = v172
local v173 = {
	["ItemType"] = "Food",
	["ItemData"] = {
		["ItemName"] = "Pizza",
		["Quantity"] = 1,
	},
}
v171[2] = v173
local v174 = {
	["ItemType"] = "Tanning Mirror",
	["ItemData"] = {
		["ItemName"] = "Tanning Mirror",
		["AcceptAllTypes"] = false,
	},
}
v171[3] = v174
local v175 = {
	["ItemType"] = "PetBoost",
	["ItemData"] = {
		["ItemName"] = "Medium Treat",
		["AcceptAllTypes"] = false,
	},
}
v171[4] = v175
v170.Inputs = v171
local v176 = {}
local v177 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Golden Piggy",
		["Quantity"] = 1,
	},
}
v176[1] = v177
v170.Outputs = v176
v170.TimeToCraft = 2700
v170.PurchaseID = 3460381429
v170.RobuxPrice = 459
v170.LayoutOrder = 160
v170.MachineTypes = { "GearEventWorkbench" }
v170.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 300000000,
}
v2["Golden Piggy"] = v170
local v178 = {}
local v179 = {}
local v180 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Mythical Egg",
		["AcceptAllTypes"] = false,
	},
}
v179[1] = v180
local v181 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Bug Egg",
		["AcceptAllTypes"] = false,
	},
}
v179[2] = v181
local v182 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Jungle Egg",
		["AcceptAllTypes"] = false,
	},
}
v179[3] = v182
local v183 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Gem Egg",
		["AcceptAllTypes"] = false,
	},
}
v179[4] = v183
v178.Inputs = v179
local v184 = {}
local v185 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Chimera Stone",
		["Quantity"] = 1,
	},
}
v184[1] = v185
v178.Outputs = v184
v178.TimeToCraft = 3600
v178.PurchaseID = 3460382022
v178.RobuxPrice = 199
v178.LayoutOrder = 170
v178.MachineTypes = { "GearEventWorkbench" }
v178.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 500000000,
}
v178.DisplayInCrafting = true
v2["Chimera Stone"] = v178
local v186 = {}
local v187 = {}
local v188 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Flower Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v187[1] = v188
v186.Inputs = v187
local v189 = {}
local v190 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Crafters Seed Pack",
		["Quantity"] = 1,
	},
}
v189[1] = v190
v186.Outputs = v189
v186.TimeToCraft = 1200
v186.PurchaseID = 3306485034
v186.RobuxPrice = 199
v186.LayoutOrder = 130
v186.MachineTypes = { "SeedEventWorkbench" }
v186.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 10,
}
v186.DisplayInCrafting = false
v2["Crafters Seed Pack"] = v186
local v191 = {}
local v192 = {}
local v193 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Rafflesia",
		["AcceptAllTypes"] = false,
	},
}
v192[1] = v193
local v194 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Cauliflower",
		["AcceptAllTypes"] = false,
	},
}
v192[2] = v194
v191.Inputs = v192
local v195 = {}
local v196 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Peace Lily",
		["Quantity"] = 1,
	},
}
v195[1] = v196
v191.Outputs = v195
v191.TimeToCraft = 600
v191.PurchaseID = 3317730044
v191.RobuxPrice = 129
v191.LayoutOrder = 140
v191.MachineTypes = { "SeedEventWorkbench" }
v191.Cost = {
	["CurrencyType"] = "SummerCoins",
	["Amount"] = 3,
}
v191.DisplayInCrafting = false
v2["Peace Lily"] = v191
local v197 = {}
local v198 = {}
local v199 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Peace Lily",
		["AcceptAllTypes"] = false,
	},
}
v198[1] = v199
local v200 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Prickly Pear",
		["AcceptAllTypes"] = false,
	},
}
v198[2] = v200
v197.Inputs = v198
local v201 = {}
local v202 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Aloe Vera",
		["Quantity"] = 1,
	},
}
v201[1] = v202
v197.Outputs = v201
v197.TimeToCraft = 600
v197.PurchaseID = 3317175501
v197.RobuxPrice = 299
v197.LayoutOrder = 143
v197.MachineTypes = { "SeedEventWorkbench" }
v197.Cost = {
	["CurrencyType"] = "SummerCoins",
	["Amount"] = 18,
}
v197.DisplayInCrafting = false
v2["Aloe Vera"] = v197
local v203 = {}
local v204 = {}
local v205 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Aloe Vera",
		["AcceptAllTypes"] = false,
	},
}
v204[1] = v205
local v206 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Prickly Pear",
		["AcceptAllTypes"] = false,
	},
}
v204[2] = v206
local v207 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Banana",
		["AcceptAllTypes"] = false,
	},
}
v204[3] = v207
v203.Inputs = v204
local v208 = {}
local v209 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Guanabana",
		["Quantity"] = 1,
	},
}
v208[1] = v209
v203.Outputs = v208
v203.TimeToCraft = 600
v203.PurchaseID = 3317175618
v203.RobuxPrice = 779
v203.LayoutOrder = 145
v203.MachineTypes = { "SeedEventWorkbench" }
v203.Cost = {
	["CurrencyType"] = "SummerCoins",
	["Amount"] = 30,
}
v203.DisplayInCrafting = false
v2.Guanabana = v203
local v210 = {}
local v211 = {}
local v212 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v211[1] = v212
local v213 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Orange Tulip",
		["AcceptAllTypes"] = false,
	},
}
v211[2] = v213
v210.Inputs = v211
local v214 = {}
local v215 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Manuka Flower",
		["Quantity"] = 1,
	},
}
v214[1] = v215
v210.Outputs = v214
v210.TimeToCraft = 600
v210.PurchaseID = 3306485030
v210.RobuxPrice = 99
v210.LayoutOrder = 140
v210.MachineTypes = { "SeedEventWorkbench" }
v210.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 6,
}
v210.DisplayInCrafting = false
v2["Manuka Flower"] = v210
local v216 = {}
local v217 = {}
local v218 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v217[1] = v218
local v219 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v217[2] = v219
local v220 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Manuka Flower",
		["AcceptAllTypes"] = false,
	},
}
v217[3] = v220
v216.Inputs = v217
local v221 = {}
local v222 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Dandelion",
		["Quantity"] = 1,
	},
}
v221[1] = v222
v216.Outputs = v221
v216.TimeToCraft = 960
v216.PurchaseID = 3306485029
v216.RobuxPrice = 199
v216.LayoutOrder = 150
v216.MachineTypes = { "SeedEventWorkbench" }
v216.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 20,
}
v216.DisplayInCrafting = false
v2.Dandelion = v216
local v223 = {}
local v224 = {}
local v225 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Pumpkin",
		["AcceptAllTypes"] = false,
	},
}
v224[1] = v225
local v226 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Pumpkin",
		["AcceptAllTypes"] = false,
	},
}
v224[2] = v226
local v227 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Dandelion",
		["AcceptAllTypes"] = false,
	},
}
v224[3] = v227
local v228 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Flower Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v224[4] = v228
v223.Inputs = v224
local v229 = {}
local v230 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Lumira",
		["Quantity"] = 1,
	},
}
v229[1] = v230
v223.Outputs = v229
v223.TimeToCraft = 1200
v223.PurchaseID = 3306485023
v223.RobuxPrice = 529
v223.LayoutOrder = 160
v223.MachineTypes = { "SeedEventWorkbench" }
v223.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 40,
}
v223.DisplayInCrafting = false
v2.Lumira = v223
local v231 = {}
local v232 = {}
local v233 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Pink Lily",
		["AcceptAllTypes"] = false,
	},
}
v232[1] = v233
local v234 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Purple Dahlia",
		["AcceptAllTypes"] = false,
	},
}
v232[2] = v234
v231.Inputs = v232
local v235 = {}
local v236 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Honeysuckle",
		["Quantity"] = 1,
	},
}
v235[1] = v236
v231.Outputs = v235
v231.TimeToCraft = 1440
v231.PurchaseID = 3306485032
v231.RobuxPrice = 619
v231.LayoutOrder = 170
v231.MachineTypes = { "SeedEventWorkbench" }
v231.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 80,
}
v231.DisplayInCrafting = false
v2.Honeysuckle = v231
local v237 = {}
local v238 = {}
local v239 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Crocus",
		["AcceptAllTypes"] = false,
	},
}
v238[1] = v239
local v240 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Lavender",
		["AcceptAllTypes"] = false,
	},
}
v238[2] = v240
v237.Inputs = v238
local v241 = {}
local v242 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Bee Balm",
		["Quantity"] = 1,
	},
}
v241[1] = v242
v237.Outputs = v241
v237.TimeToCraft = 900
v237.PurchaseID = 3306485036
v237.RobuxPrice = 179
v237.LayoutOrder = 180
v237.MachineTypes = { "SeedEventWorkbench" }
v237.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 10,
}
v237.DisplayInCrafting = false
v2["Bee Balm"] = v237
local v243 = {}
local v244 = {}
local v245 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v244[1] = v245
local v246 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v244[2] = v246
local v247 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v244[3] = v247
local v248 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Nectarshade",
		["AcceptAllTypes"] = false,
	},
}
v244[4] = v248
v243.Inputs = v244
local v249 = {}
local v250 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Nectar Thorn",
		["Quantity"] = 1,
	},
}
v249[1] = v250
v243.Outputs = v249
v243.TimeToCraft = 1800
v243.PurchaseID = 3306485033
v243.RobuxPrice = 659
v243.LayoutOrder = 190
v243.MachineTypes = { "SeedEventWorkbench" }
v243.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 20,
}
v243.DisplayInCrafting = false
v2["Nectar Thorn"] = v243
local v251 = {}
local v252 = {}
local v253 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Crocus",
		["AcceptAllTypes"] = false,
	},
}
v252[1] = v253
local v254 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v252[2] = v254
local v255 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Dandelion",
		["AcceptAllTypes"] = false,
	},
}
v252[3] = v255
local v256 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Pink Lily",
		["AcceptAllTypes"] = false,
	},
}
v252[4] = v256
v251.Inputs = v252
local v257 = {}
local v258 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Suncoil",
		["Quantity"] = 1,
	},
}
v257[1] = v258
v251.Outputs = v257
v251.TimeToCraft = 2700
v251.PurchaseID = 3306485035
v251.RobuxPrice = 749
v251.LayoutOrder = 200
v251.MachineTypes = { "SeedEventWorkbench" }
v251.Cost = {
	["CurrencyType"] = "Honey",
	["Amount"] = 40,
}
v251.DisplayInCrafting = false
v2.Suncoil = v251
local v259 = {}
local v260 = {}
local v261 = {
	["ItemType"] = "SprayBottle",
	["ItemData"] = {
		["ItemName"] = "Cleaning Spray",
		["AcceptAllTypes"] = false,
	},
}
v260[1] = v261
local v262 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["AcceptAllTypes"] = false,
	},
}
v260[2] = v262
v259.Inputs = v260
local v263 = {}
local v264 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Mutation Spray Amber",
		["Quantity"] = 1,
	},
}
v263[1] = v264
v259.Outputs = v263
v259.TimeToCraft = 3600
v259.PurchaseID = 3322971805
v259.RobuxPrice = 189
v259.LayoutOrder = 90
v259.MachineTypes = { "DinoEventWorkbench" }
v259.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Mutation Spray Amber"] = v259
local v265 = {}
local v266 = {}
local v267 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["AcceptAllTypes"] = false,
	},
}
v266[1] = v267
v265.Inputs = v266
local v268 = {}
local v269 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Ancient Seed Pack",
		["Quantity"] = 2,
	},
}
v268[1] = v269
v265.Outputs = v268
v265.TimeToCraft = 3600
v265.PurchaseID = 3324600388
v265.RobuxPrice = 199
v265.LayoutOrder = 100
v265.MachineTypes = { "DinoEventWorkbench" }
v265.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5500000,
}
v2["Ancient Seed Pack"] = v265
local v270 = {}
local v271 = {}
local v272 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["AcceptAllTypes"] = false,
	},
}
v271[1] = v272
v270.Inputs = v271
local v273 = {}
local v274 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Dino Crate",
		["Quantity"] = 2,
	},
}
v273[1] = v274
v270.Outputs = v273
v270.TimeToCraft = 1800
v270.PurchaseID = 3324601485
v270.RobuxPrice = 179
v270.LayoutOrder = 110
v270.MachineTypes = { "DinoEventWorkbench" }
v270.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5500000,
}
v2["Dino Crate"] = v270
local v275 = {}
local v276 = {}
local v277 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["AcceptAllTypes"] = false,
	},
}
v276[1] = v277
v275.Inputs = v276
local v278 = {}
local v279 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Archaeologist Crate",
		["Quantity"] = 2,
	},
}
v278[1] = v279
v275.Outputs = v278
v275.TimeToCraft = 1800
v275.PurchaseID = 3329654888
v275.RobuxPrice = 179
v275.LayoutOrder = 115
v275.MachineTypes = { "DinoEventWorkbench" }
v275.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5500000,
}
v2["Archaeologist Crate"] = v275
local v280 = {}
local v281 = {}
local v282 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v281[1] = v282
local v283 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bone Blossom",
		["AcceptAllTypes"] = false,
	},
}
v281[2] = v283
v280.Inputs = v281
local v284 = {}
local v285 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["Quantity"] = 1,
	},
}
v284[1] = v285
v280.Outputs = v284
v280.TimeToCraft = 1800
v280.PurchaseID = 3329519291
v280.RobuxPrice = 149
v280.LayoutOrder = 120
v280.IsUnlockable = true
v280.MachineTypes = { "DinoEventWorkbench" }
v280.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5500000,
}
v2["Dinosaur Egg"] = v280
local v286 = {}
local v287 = {}
local v288 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["AcceptAllTypes"] = false,
	},
}
v287[1] = v288
local v289 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bone Blossom",
		["AcceptAllTypes"] = false,
	},
}
v287[2] = v289
v286.Inputs = v287
local v290 = {}
local v291 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Primal Egg",
		["Quantity"] = 1,
	},
}
v290[1] = v291
v286.Outputs = v290
v286.TimeToCraft = 1800
v286.PurchaseID = 3329518200
v286.RobuxPrice = 149
v286.LayoutOrder = 130
v286.IsUnlockable = true
v286.MachineTypes = { "DinoEventWorkbench" }
v286.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5500000,
}
v2["Primal Egg"] = v286
local v292 = {}
local v293 = {}
local v294 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Carrot",
		["AcceptAllTypes"] = false,
	},
}
v293[1] = v294
local v295 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v293[2] = v295
local v296 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v293[3] = v296
v292.Inputs = v293
local v297 = {}
local v298 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Mandrake",
		["Quantity"] = 3,
	},
}
v297[1] = v298
v292.Outputs = v297
v292.TimeToCraft = 300
v292.PurchaseID = 3371045808
v292.RobuxPrice = 199
v292.LayoutOrder = 5
v292.MachineTypes = { "SeedEventWorkbench" }
v2.Mandrake = v292
local v299 = {}
local v300 = {}
local v301 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Beetroot IV",
		["AcceptAllTypes"] = false,
	},
}
v300[1] = v301
local v302 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Blueberry IV",
		["AcceptAllTypes"] = false,
	},
}
v300[2] = v302
local v303 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Pumpkin IV",
		["AcceptAllTypes"] = false,
	},
}
v300[3] = v303
local v304 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Mushroom IV",
		["AcceptAllTypes"] = false,
	},
}
v300[4] = v304
local v305 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Sugar Apple",
		["AcceptAllTypes"] = false,
	},
}
v300[5] = v305
v299.Inputs = v300
local v306 = {}
local v307 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple I",
		["Quantity"] = 1,
	},
}
v306[1] = v307
v299.Outputs = v306
v299.TimeToCraft = 600
v299.PurchaseID = 3420523696
v299.RobuxPrice = 195
v299.LayoutOrder = 10
v299.MachineTypes = { "SeedEventWorkbench" }
v299.DisplayInCrafting = true
v2["Evo Apple I"] = v299
local v308 = {}
local v309 = {}
local v310 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple I",
		["AcceptAllTypes"] = false,
	},
}
v309[1] = v310
local v311 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Apple I",
		["AcceptAllTypes"] = false,
	},
}
v309[2] = v311
local v312 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Apple I",
		["AcceptAllTypes"] = false,
	},
}
v309[3] = v312
local v313 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Burning Bud",
		["AcceptAllTypes"] = false,
	},
}
v309[4] = v313
v308.Inputs = v309
local v314 = {}
local v315 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple II",
		["Quantity"] = 1,
	},
}
v314[1] = v315
v308.Outputs = v314
v308.TimeToCraft = 1200
v308.PurchaseID = 3420524026
v308.RobuxPrice = 349
v308.LayoutOrder = 15
v308.MachineTypes = { "SeedEventWorkbench" }
v308.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 30000000,
}
v308.DisplayInCrafting = true
v2["Evo Apple II"] = v308
local v316 = {}
local v317 = {}
local v318 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple II",
		["AcceptAllTypes"] = false,
	},
}
v317[1] = v318
local v319 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Apple II",
		["AcceptAllTypes"] = false,
	},
}
v317[2] = v319
local v320 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Apple II",
		["AcceptAllTypes"] = false,
	},
}
v317[3] = v320
local v321 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Giant Pinecone",
		["AcceptAllTypes"] = false,
	},
}
v317[4] = v321
v316.Inputs = v317
local v322 = {}
local v323 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple III",
		["Quantity"] = 1,
	},
}
v322[1] = v323
v316.Outputs = v322
v316.TimeToCraft = 1800
v316.PurchaseID = 3420524301
v316.RobuxPrice = 679
v316.LayoutOrder = 20
v316.MachineTypes = { "SeedEventWorkbench" }
v316.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 70000000,
}
v316.DisplayInCrafting = true
v2["Evo Apple III"] = v316
local v324 = {}
local v325 = {}
local v326 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple III",
		["AcceptAllTypes"] = false,
	},
}
v325[1] = v326
local v327 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Apple III",
		["AcceptAllTypes"] = false,
	},
}
v325[2] = v327
local v328 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Evo Apple III",
		["AcceptAllTypes"] = false,
	},
}
v325[3] = v328
local v329 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Elder Strawberry",
		["AcceptAllTypes"] = false,
	},
}
v325[4] = v329
v324.Inputs = v325
local v330 = {}
local v331 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Evo Apple IV",
		["Quantity"] = 1,
	},
}
v330[1] = v331
v324.Outputs = v330
v324.TimeToCraft = 2400
v324.PurchaseID = 3420524565
v324.RobuxPrice = 849
v324.LayoutOrder = 30
v324.MachineTypes = { "SeedEventWorkbench" }
v324.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 100000000,
}
v324.DisplayInCrafting = true
v2["Evo Apple IV"] = v324
local v332 = {}
local v333 = {}
local v334 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Basic Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v333[1] = v334
local v335 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Basic Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v333[2] = v335
local v336 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Grape",
		["AcceptAllTypes"] = false,
	},
}
v333[3] = v336
local v337 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Tomato",
		["AcceptAllTypes"] = false,
	},
}
v333[4] = v337
v332.Inputs = v333
local v338 = {}
local v339 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Olive",
		["Quantity"] = 1,
	},
}
v338[1] = v339
v332.Outputs = v338
v332.TimeToCraft = 900
v332.PurchaseID = 0
v332.RobuxPrice = 129
v332.LayoutOrder = 40
v332.MachineTypes = { "SeedEventWorkbench" }
v332.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 750000,
}
v2["Olive@SeedEventWorkbench"] = v332
local v340 = {}
local v341 = {}
local v342 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Advanced Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v341[1] = v342
local v343 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v341[2] = v343
local v344 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v341[3] = v344
local v345 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v341[4] = v345
v340.Inputs = v341
local v346 = {}
local v347 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Hollow Bamboo",
		["Quantity"] = 1,
	},
}
v346[1] = v347
v340.Outputs = v346
v340.TimeToCraft = 2700
v340.PurchaseID = 0
v340.RobuxPrice = 507
v340.LayoutOrder = 50
v340.MachineTypes = { "SeedEventWorkbench" }
v340.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5000000,
}
v2["Hollow Bamboo@SeedEventWorkbench"] = v340
local v348 = {}
local v349 = {}
local v350 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Master Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v349[1] = v350
local v351 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Master Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v349[2] = v351
local v352 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Burning Bud",
		["AcceptAllTypes"] = false,
	},
}
v349[3] = v352
local v353 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v349[4] = v353
v348.Inputs = v349
local v354 = {}
local v355 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Yarrow",
		["Quantity"] = 1,
	},
}
v354[1] = v355
v348.Outputs = v354
v348.TimeToCraft = 3600
v348.PurchaseID = 0
v348.RobuxPrice = 729
v348.LayoutOrder = 60
v348.MachineTypes = { "SeedEventWorkbench" }
v348.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 18000000,
}
v2["Yarrow@SeedEventWorkbench"] = v348
local v356 = {}
local v357 = {}
local v358 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v357[1] = v358
local v359 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v357[2] = v359
local v360 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v357[3] = v360
local v361 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Mango",
		["AcceptAllTypes"] = false,
	},
}
v357[4] = v361
v356.Inputs = v357
local v362 = {}
local v363 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Twisted Tangle",
		["Quantity"] = 1,
	},
}
v362[1] = v363
v356.Outputs = v362
v356.TimeToCraft = 900
v356.PurchaseID = 3354091176
v356.RobuxPrice = 239
v356.LayoutOrder = 10
v356.MachineTypes = { "SeedEventWorkbench" }
v356.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 50000,
}
v356.DisplayInCrafting = false
v2["Twisted Tangle"] = v356
local v364 = {}
local v365 = {}
local v366 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Orange Tulip",
		["AcceptAllTypes"] = false,
	},
}
v365[1] = v366
local v367 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v365[2] = v367
local v368 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v365[3] = v368
local v369 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Burning Bud",
		["AcceptAllTypes"] = false,
	},
}
v365[4] = v369
v364.Inputs = v365
local v370 = {}
local v371 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Veinpetal",
		["Quantity"] = 1,
	},
}
v370[1] = v371
v364.Outputs = v370
v364.TimeToCraft = 1200
v364.PurchaseID = 3354091526
v364.RobuxPrice = 459
v364.LayoutOrder = 15
v364.MachineTypes = { "SeedEventWorkbench" }
v364.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 650000,
}
v364.DisplayInCrafting = false
v2.Veinpetal = v364
local v372 = {}
local v373 = {}
local v374 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v373[1] = v374
local v375 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v373[2] = v375
local v376 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Corn",
		["AcceptAllTypes"] = false,
	},
}
v373[3] = v376
v372.Inputs = v373
local v377 = {}
local v378 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Horsetail",
		["Quantity"] = 1,
	},
}
v377[1] = v378
v372.Outputs = v377
v372.TimeToCraft = 900
v372.PurchaseID = 3329520820
v372.RobuxPrice = 199
v372.LayoutOrder = 20
v372.MachineTypes = { "SeedEventWorkbench" }
v372.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 15000,
}
v372.DisplayInCrafting = false
v2.Horsetail = v372
local v379 = {}
local v380 = {}
local v381 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Blueberry",
		["AcceptAllTypes"] = false,
	},
}
v380[1] = v381
local v382 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Blueberry",
		["AcceptAllTypes"] = false,
	},
}
v380[2] = v382
local v383 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Blueberry",
		["AcceptAllTypes"] = false,
	},
}
v380[3] = v383
local v384 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Horsetail",
		["AcceptAllTypes"] = false,
	},
}
v380[4] = v384
v379.Inputs = v380
local v385 = {}
local v386 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Lingonberry",
		["Quantity"] = 1,
	},
}
v385[1] = v386
v379.Outputs = v385
v379.TimeToCraft = 900
v379.PurchaseID = 3329520955
v379.RobuxPrice = 209
v379.LayoutOrder = 25
v379.MachineTypes = { "SeedEventWorkbench" }
v379.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 450000,
}
v379.DisplayInCrafting = false
v2.Lingonberry = v379
local v387 = {}
local v388 = {}
local v389 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v388[1] = v389
local v390 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Pumpkin",
		["AcceptAllTypes"] = false,
	},
}
v388[2] = v390
local v391 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Horsetail",
		["AcceptAllTypes"] = false,
	},
}
v388[3] = v391
v387.Inputs = v388
local v392 = {}
local v393 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Amber Spine",
		["Quantity"] = 1,
	},
}
v392[1] = v393
v387.Outputs = v392
v387.TimeToCraft = 1800
v387.PurchaseID = 3329520620
v387.RobuxPrice = 625
v387.LayoutOrder = 30
v387.MachineTypes = { "SeedEventWorkbench" }
v387.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 650000,
}
v387.DisplayInCrafting = false
v2["Amber Spine"] = v387
local v394 = {}
local v395 = {}
local v396 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Ember Lily",
		["AcceptAllTypes"] = false,
	},
}
v395[1] = v396
local v397 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Ember Lily",
		["AcceptAllTypes"] = false,
	},
}
v395[2] = v397
local v398 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Dinosaur Egg",
		["AcceptAllTypes"] = false,
	},
}
v395[3] = v398
local v399 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Ancient Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v395[4] = v399
v394.Inputs = v395
local v400 = {}
local v401 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Grand Volcania",
		["Quantity"] = 1,
	},
}
v400[1] = v401
v394.Outputs = v400
v394.TimeToCraft = 2700
v394.PurchaseID = 3329521774
v394.RobuxPrice = 819
v394.LayoutOrder = 30
v394.MachineTypes = { "SeedEventWorkbench" }
v394.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 900000,
}
v394.DisplayInCrafting = false
v2["Grand Volcania"] = v394
local v402 = {}
local v403 = {}
local v404 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v403[1] = v404
local v405 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v403[2] = v405
local v406 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Sprout Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v403[3] = v406
local v407 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Sprout Egg",
		["AcceptAllTypes"] = false,
	},
}
v403[4] = v407
v402.Inputs = v403
local v408 = {}
local v409 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Skyroot Chest",
		["Quantity"] = 1,
	},
}
v408[1] = v409
v402.Outputs = v408
v402.TimeToCraft = 1800
v402.PurchaseID = 3379243998
v402.RobuxPrice = 199
v402.LayoutOrder = 100
v402.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v402.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 7500000,
}
v2["Skyroot Chest"] = v402
local v410 = {}
local v411 = {}
local v412 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v411[1] = v412
local v413 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v411[2] = v413
local v414 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Sprout Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v411[3] = v414
local v415 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Uncommon Egg",
		["AcceptAllTypes"] = false,
	},
}
v411[4] = v415
v410.Inputs = v411
local v416 = {}
local v417 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Sprout Egg",
		["Quantity"] = 1,
	},
}
v416[1] = v417
v410.Outputs = v416
v410.TimeToCraft = 1800
v410.PurchaseID = 3371044215
v410.RobuxPrice = 149
v410.LayoutOrder = 120
v410.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v410.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 2500000,
}
v2["Sprout Egg"] = v410
local v418 = {}
local v419 = {}
local v420 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Flare Melon",
		["AcceptAllTypes"] = false,
	},
}
v419[1] = v420
local v421 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Glowpod",
		["AcceptAllTypes"] = false,
	},
}
v419[2] = v421
local v422 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v419[3] = v422
local v423 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v419[4] = v423
v418.Inputs = v419
local v424 = {}
local v425 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Willowberry",
		["Quantity"] = 1,
	},
}
v424[1] = v425
v418.Outputs = v424
v418.TimeToCraft = 1800
v418.PurchaseID = 3379244616
v418.RobuxPrice = 589
v418.LayoutOrder = 160
v418.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v418.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5500000,
}
v2.Willowberry = v418
local v426 = {}
local v427 = {}
local v428 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v427[1] = v428
local v429 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v427[2] = v429
local v430 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Sprout Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v427[3] = v430
local v431 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Sprout Crate",
		["AcceptAllTypes"] = false,
	},
}
v427[4] = v431
v426.Inputs = v427
local v432 = {}
local v433 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Green Bean Memories",
		["Quantity"] = 1,
	},
}
v432[1] = v433
v426.Outputs = v432
v426.TimeToCraft = 900
v426.PurchaseID = 3379259309
v426.RobuxPrice = 239
v426.LayoutOrder = 170
v426.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v426.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 4500000,
}
v2["Green Bean Memories"] = v426
local v434 = {}
local v435 = {}
local v436 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v435[1] = v436
local v437 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v435[2] = v437
local v438 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Coconut",
		["AcceptAllTypes"] = false,
	},
}
v435[3] = v438
local v439 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Sprout Crate",
		["AcceptAllTypes"] = false,
	},
}
v435[4] = v439
v434.Inputs = v435
local v440 = {}
local v441 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Bean Pool Table",
		["Quantity"] = 1,
	},
}
v440[1] = v441
v434.Outputs = v440
v434.TimeToCraft = 900
v434.PurchaseID = 3379259523
v434.RobuxPrice = 209
v434.LayoutOrder = 180
v434.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v434.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 4500000,
}
v2["Bean Pool Table"] = v434
local v442 = {}
local v443 = {}
local v444 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v443[1] = v444
local v445 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v443[2] = v445
local v446 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Flare Melon",
		["AcceptAllTypes"] = false,
	},
}
v443[3] = v446
local v447 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Sprout Crate",
		["AcceptAllTypes"] = false,
	},
}
v443[4] = v447
v442.Inputs = v443
local v448 = {}
local v449 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Bean Sprout Float Light",
		["Quantity"] = 1,
	},
}
v448[1] = v449
v442.Outputs = v448
v442.TimeToCraft = 900
v442.PurchaseID = 3379259737
v442.RobuxPrice = 149
v442.LayoutOrder = 190
v442.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v442.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 4500000,
}
v2["Bean Sprout Float Light"] = v442
local v450 = {}
local v451 = {}
local v452 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v451[1] = v452
local v453 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v451[2] = v453
local v454 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Beanstalk",
		["AcceptAllTypes"] = false,
	},
}
v451[3] = v454
local v455 = {
	["ItemType"] = "PetShard",
	["ItemData"] = {
		["ItemName"] = "Cleansing Pet Shard",
		["AcceptAllTypes"] = false,
	},
}
v451[4] = v455
v450.Inputs = v451
local v456 = {}
local v457 = {
	["ItemType"] = "PetShard",
	["ItemData"] = {
		["ItemName"] = "Pet Shard GiantBean",
		["Quantity"] = 1,
	},
}
v456[1] = v457
v450.Outputs = v456
v450.TimeToCraft = 3600
v450.PurchaseID = 3379333073
v450.RobuxPrice = 279
v450.LayoutOrder = 200
v450.MachineTypes = { "GiantBeanstalkEventWorkbench" }
v450.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 15000000,
}
v2["Pet Shard GiantBean"] = v450
local v458 = {}
local v459 = {}
local v460 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Sunbulb",
		["AcceptAllTypes"] = false,
	},
}
v459[1] = v460
local v461 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Strawberry",
		["AcceptAllTypes"] = false,
	},
}
v459[2] = v461
local v462 = {
	["ItemType"] = "Harvest Tool",
	["ItemData"] = {
		["ItemName"] = "Harvest Tool",
		["AcceptAllTypes"] = false,
	},
}
v459[3] = v462
v458.Inputs = v459
local v463 = {}
local v464 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Fairy Net",
		["Quantity"] = 20,
	},
}
v463[1] = v464
v458.Outputs = v463
v458.TimeToCraft = 30
v458.PurchaseID = 3395556018
v458.RobuxPrice = 109
v458.LayoutOrder = 10
v458.MachineTypes = { "FairyGeniusEventWorkbench" }
v458.Cost = {
	["CurrencyType"] = "FairyPoints",
	["Amount"] = 100,
}
v2["Fairy Net"] = v458
local v465 = {}
local v466 = {}
local v467 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v466[1] = v467
local v468 = {
	["ItemType"] = "Harvest Tool",
	["ItemData"] = {
		["ItemName"] = "Harvest Tool",
		["AcceptAllTypes"] = false,
	},
}
v466[2] = v468
v465.Inputs = v466
local v469 = {}
local v470 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Glimmering Radar",
		["Quantity"] = 5,
	},
}
v469[1] = v470
v465.Outputs = v469
v465.TimeToCraft = 300
v465.PurchaseID = 3395556015
v465.RobuxPrice = 199
v465.LayoutOrder = 20
v465.MachineTypes = { "FairyGeniusEventWorkbench" }
v465.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Glimmering Radar"] = v465
local v471 = {}
local v472 = {}
local v473 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v472[1] = v473
local v474 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v472[2] = v474
local v475 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v472[3] = v475
v471.Inputs = v472
local v476 = {}
local v477 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Fairy Targeter",
		["Quantity"] = 1,
	},
}
v476[1] = v477
v471.Outputs = v476
v471.TimeToCraft = 450
v471.PurchaseID = 3395556011
v471.RobuxPrice = 149
v471.LayoutOrder = 30
v471.MachineTypes = { "FairyGeniusEventWorkbench" }
v471.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Fairy Targeter"] = v471
local v478 = {}
local v479 = {}
local v480 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v479[1] = v480
local v481 = {
	["ItemType"] = "Sprinkler",
	["ItemData"] = {
		["ItemName"] = "Godly Sprinkler",
		["AcceptAllTypes"] = false,
	},
}
v479[2] = v481
v478.Inputs = v479
local v482 = {}
local v483 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Fairy Caller",
		["Quantity"] = 2,
	},
}
v482[1] = v483
v478.Outputs = v482
v478.TimeToCraft = 480
v478.PurchaseID = 3395556013
v478.RobuxPrice = 209
v478.LayoutOrder = 40
v478.MachineTypes = { "FairyGeniusEventWorkbench" }
v478.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 2500000,
}
v2["Fairy Caller"] = v478
local v484 = {}
local v485 = {}
local v486 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v485[1] = v486
local v487 = {
	["ItemType"] = "Fairy Caller",
	["ItemData"] = {
		["ItemName"] = "Fairy Caller",
		["AcceptAllTypes"] = false,
	},
}
v485[2] = v487
v484.Inputs = v485
local v488 = {}
local v489 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Fairy Power Extender",
		["Quantity"] = 1,
	},
}
v488[1] = v489
v484.Outputs = v488
v484.TimeToCraft = 600
v484.PurchaseID = 3395556012
v484.RobuxPrice = 299
v484.LayoutOrder = 50
v484.MachineTypes = { "FairyGeniusEventWorkbench" }
v484.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 5000000,
}
v2["Fairy Power Extender"] = v484
local v490 = {}
local v491 = {}
local v492 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v491[1] = v492
local v493 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v491[2] = v493
local v494 = {
	["ItemType"] = "Fairy Power Extender",
	["ItemData"] = {
		["ItemName"] = "Fairy Power Extender",
		["AcceptAllTypes"] = false,
	},
}
v491[3] = v494
v490.Inputs = v491
local v495 = {}
local v496 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Luminous Wand",
		["Quantity"] = 1,
	},
}
v495[1] = v496
v490.Outputs = v495
v490.TimeToCraft = 900
v490.PurchaseID = 3395556016
v490.RobuxPrice = 219
v490.LayoutOrder = 60
v490.MachineTypes = { "FairyGeniusEventWorkbench" }
v490.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 10000000,
}
v2["Luminous Wand"] = v490
local v497 = {}
local v498 = {}
local v499 = {
	["ItemType"] = "Fairy Jar",
	["ItemData"] = {
		["ItemName"] = "Fairy Jar",
		["AcceptAllTypes"] = false,
	},
}
v498[1] = v499
local v500 = {
	["ItemType"] = "Fairy Net",
	["ItemData"] = {
		["ItemName"] = "Fairy Net",
		["AcceptAllTypes"] = false,
	},
}
v498[2] = v500
local v501 = {
	["ItemType"] = "Fairy Power Extender",
	["ItemData"] = {
		["ItemName"] = "Fairy Power Extender",
		["AcceptAllTypes"] = false,
	},
}
v498[3] = v501
v497.Inputs = v498
local v502 = {}
local v503 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Fairy Summoner",
		["Quantity"] = 1,
	},
}
v502[1] = v503
v497.Outputs = v502
v497.TimeToCraft = 3600
v497.PurchaseID = 3395556009
v497.RobuxPrice = 399
v497.LayoutOrder = 80
v497.MachineTypes = { "FairyGeniusEventWorkbench" }
v497.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 15000000,
}
v2["Fairy Summoner"] = v497
local v504 = {}
local v505 = {}
local v506 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Sunbulb",
		["AcceptAllTypes"] = false,
	},
}
v505[1] = v506
local v507 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Enchanted Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v505[2] = v507
local v508 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Enchanted Egg",
		["AcceptAllTypes"] = false,
	},
}
v505[3] = v508
v504.Inputs = v505
local v509 = {}
local v510 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Enchanted Chest",
		["Quantity"] = 1,
	},
}
v509[1] = v510
v504.Outputs = v509
v504.TimeToCraft = 1800
v504.PurchaseID = 3394265025
v504.RobuxPrice = 199
v504.LayoutOrder = 10
v504.MachineTypes = { "FairyWorldCraftingWorkBench" }
v504.Cost = {
	["CurrencyType"] = "FairyPoints",
	["Amount"] = 6000,
}
v2["Enchanted Chest"] = v504
local v511 = {}
local v512 = {}
local v513 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Mushroom",
		["AcceptAllTypes"] = false,
	},
}
v512[1] = v513
local v514 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Mushroom",
		["AcceptAllTypes"] = false,
	},
}
v512[2] = v514
v511.Inputs = v512
local v515 = {}
local v516 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Enchanted Seed Pack",
		["Quantity"] = 1,
	},
}
v515[1] = v516
v511.Outputs = v515
v511.TimeToCraft = 300
v511.PurchaseID = 3394271793
v511.RobuxPrice = 99
v511.LayoutOrder = 20
v511.MachineTypes = { "FairyWorldCraftingWorkBench" }
v511.Cost = {
	["CurrencyType"] = "FairyPoints",
	["Amount"] = 1500,
}
v2["Enchanted Seed Pack"] = v511
local v517 = {}
local v518 = {}
local v519 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Glowthorn",
		["AcceptAllTypes"] = false,
	},
}
v518[1] = v519
local v520 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Enchanted Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v518[2] = v520
v517.Inputs = v518
local v521 = {}
local v522 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Enchanted Egg",
		["Quantity"] = 1,
	},
}
v521[1] = v522
v517.Outputs = v521
v517.TimeToCraft = 600
v517.PurchaseID = 3394272325
v517.RobuxPrice = 129
v517.LayoutOrder = 30
v517.MachineTypes = { "FairyWorldCraftingWorkBench" }
v517.Cost = {
	["CurrencyType"] = "FairyPoints",
	["Amount"] = 3000,
}
v2["Enchanted Egg"] = v517
local v523 = {}
local v524 = {}
local v525 = {
	["ItemType"] = "Seed Pack",
	["ItemData"] = {
		["ItemName"] = "Enchanted Seed Pack",
		["AcceptAllTypes"] = false,
	},
}
v524[1] = v525
v523.Inputs = v524
local v526 = {}
local v527 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Enchanted Crate",
		["Quantity"] = 1,
	},
}
v526[1] = v527
v523.Outputs = v526
v523.TimeToCraft = 300
v523.PurchaseID = 3394272617
v523.RobuxPrice = 179
v523.LayoutOrder = 40
v523.MachineTypes = { "FairyWorldCraftingWorkBench" }
v523.Cost = {
	["CurrencyType"] = "FairyPoints",
	["Amount"] = 1000,
}
v2["Enchanted Crate"] = v523
local v528 = {}
local v529 = {}
local v530 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Enchanted Crate",
		["AcceptAllTypes"] = false,
	},
}
v529[1] = v530
v528.Inputs = v529
local v531 = {}
local v532 = {
	["ItemType"] = "CosmeticCrate",
	["ItemData"] = {
		["ItemName"] = "Glimmering Crate",
		["Quantity"] = 1,
	},
}
v531[1] = v532
v528.Outputs = v531
v528.TimeToCraft = 300
v528.PurchaseID = 3394269769
v528.RobuxPrice = 179
v528.LayoutOrder = 50
v528.MachineTypes = { "FairyWorldCraftingWorkBench" }
v528.Cost = {
	["CurrencyType"] = "FairyPoints",
	["Amount"] = 1000,
}
v2["Glimmering Crate"] = v528
local v533 = {}
local v534 = {}
local v535 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Common Egg",
		["AcceptAllTypes"] = false,
	},
}
v534[1] = v535
local v536 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v534[2] = v536
local v537 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v534[3] = v537
local v538 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v534[4] = v538
v533.Inputs = v534
local v539 = {}
local v540 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Gem Egg",
		["Quantity"] = 1,
	},
}
v539[1] = v540
v533.Outputs = v539
v533.TimeToCraft = 600
v533.PurchaseID = 3455269673
v533.RobuxPrice = 209
v533.LayoutOrder = 100
v533.MachineTypes = { "SmithingEventPetWorkbench" }
v533.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1000000,
}
v2["Gem Egg"] = v533
local v541 = {}
local v542 = {}
local v543 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Dog",
		["AcceptAllTypes"] = false,
	},
}
v542[1] = v543
local v544 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v542[2] = v544
local v545 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v542[3] = v545
v541.Inputs = v542
local v546 = {}
local v547 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Smithing Dog",
		["Quantity"] = 1,
	},
}
v546[1] = v547
v541.Outputs = v546
v541.TimeToCraft = 1200
v541.PurchaseID = 3455274572
v541.RobuxPrice = 229
v541.LayoutOrder = 200
v541.MachineTypes = { "SmithingEventPetWorkbench" }
v541.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 3000000,
}
v2["Smithing Dog"] = v541
local v548 = {}
local v549 = {}
local v550 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Orange Tabby",
		["AcceptAllTypes"] = false,
	},
}
v549[1] = v550
local v551 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v549[2] = v551
local v552 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v549[3] = v552
v548.Inputs = v549
local v553 = {}
local v554 = {
	["ItemType"] = "Pet",
	["ItemData"] = {
		["ItemName"] = "Cheetah",
		["Quantity"] = 1,
	},
}
v553[1] = v554
v548.Outputs = v553
v548.TimeToCraft = 2400
v548.PurchaseID = 3455274866
v548.RobuxPrice = 549
v548.LayoutOrder = 300
v548.MachineTypes = { "SmithingEventPetWorkbench" }
v548.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 8500000,
}
v2.Cheetah = v548
local v555 = {}
local v556 = {}
local v557 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v556[1] = v557
local v558 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v556[2] = v558
local v559 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v556[3] = v559
v555.Inputs = v556
local v560 = {}
local v561 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Anvil",
		["Quantity"] = 1,
	},
}
v560[1] = v561
v555.Outputs = v560
v555.TimeToCraft = 900
v555.PurchaseID = 3455270076
v555.RobuxPrice = 119
v555.LayoutOrder = 100
v555.MachineTypes = { "SmithingEventCosmeticWorkbench" }
v555.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1500000,
}
v2.Anvil = v555
local v562 = {}
local v563 = {}
local v564 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v563[1] = v564
local v565 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v563[2] = v565
local v566 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v563[3] = v566
local v567 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Coconut",
		["AcceptAllTypes"] = false,
	},
}
v563[4] = v567
v562.Inputs = v563
local v568 = {}
local v569 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Coal Box",
		["Quantity"] = 1,
	},
}
v568[1] = v569
v562.Outputs = v568
v562.TimeToCraft = 900
v562.PurchaseID = 3455270320
v562.RobuxPrice = 119
v562.LayoutOrder = 200
v562.MachineTypes = { "SmithingEventCosmeticWorkbench" }
v562.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1500000,
}
v2["Coal Box"] = v562
local v570 = {}
local v571 = {}
local v572 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v571[1] = v572
local v573 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v571[2] = v573
local v574 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Giant Pinecone",
		["AcceptAllTypes"] = false,
	},
}
v571[3] = v574
v570.Inputs = v571
local v575 = {}
local v576 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Blacksmith Grinder",
		["Quantity"] = 1,
	},
}
v575[1] = v576
v570.Outputs = v575
v570.TimeToCraft = 900
v570.PurchaseID = 3455270632
v570.RobuxPrice = 189
v570.LayoutOrder = 300
v570.MachineTypes = { "SmithingEventCosmeticWorkbench" }
v570.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 6000000,
}
v2["Blacksmith Grinder"] = v570
local v577 = {}
local v578 = {}
local v579 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v578[1] = v579
local v580 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v578[2] = v580
local v581 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Olive",
		["AcceptAllTypes"] = false,
	},
}
v578[3] = v581
v577.Inputs = v578
local v582 = {}
local v583 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Tools Rack",
		["Quantity"] = 1,
	},
}
v582[1] = v583
v577.Outputs = v582
v577.TimeToCraft = 900
v577.PurchaseID = 3455271054
v577.RobuxPrice = 119
v577.LayoutOrder = 180
v577.MachineTypes = { "SmithingEventCosmeticWorkbench" }
v577.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 7000000,
}
v2["Tools Rack"] = v577
local v584 = {}
local v585 = {}
local v586 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v585[1] = v586
local v587 = {
	["ItemType"] = "Favorite Tool",
	["ItemData"] = {
		["ItemName"] = "Favorite Tool",
		["AcceptAllTypes"] = false,
	},
}
v585[2] = v587
local v588 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Apple",
		["AcceptAllTypes"] = false,
	},
}
v585[3] = v588
v584.Inputs = v585
local v589 = {}
local v590 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Shield Statue",
		["Quantity"] = 1,
	},
}
v589[1] = v590
v584.Outputs = v589
v584.TimeToCraft = 900
v584.PurchaseID = 3455271420
v584.RobuxPrice = 239
v584.LayoutOrder = 400
v584.MachineTypes = { "SmithingEventCosmeticWorkbench" }
v584.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 10500000,
}
v2["Shield Statue"] = v584
local v591 = {}
local v592 = {}
local v593 = {
	["ItemType"] = "Smith Hammer of Harvest",
	["ItemData"] = {
		["ItemName"] = "Smith Hammer of Harvest",
	},
}
v592[1] = v593
local v594 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Hollow Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v592[2] = v594
local v595 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v592[3] = v595
local v596 = {
	["ItemType"] = "Divine Coal",
	["ItemData"] = {
		["ItemName"] = "Divine Coal",
		["AcceptAllTypes"] = false,
	},
}
v592[4] = v596
v591.Inputs = v592
local v597 = {}
local v598 = {
	["ItemType"] = "Cosmetic",
	["ItemData"] = {
		["ItemName"] = "Horse Shoe Magnet",
		["Quantity"] = 1,
	},
}
v597[1] = v598
v591.Outputs = v597
v591.TimeToCraft = 7200
v591.PurchaseID = 3455271745
v591.RobuxPrice = 537
v591.LayoutOrder = 500
v591.MachineTypes = { "SmithingEventCosmeticWorkbench" }
v591.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 15000000,
}
v2["Horse Shoe Magnet"] = v591
local v599 = {}
local v600 = {}
local v601 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v600[1] = v601
local v602 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v600[2] = v602
local v603 = {
	["ItemType"] = "PetBoost",
	["ItemData"] = {
		["ItemName"] = "Small Treat",
		["AcceptAllTypes"] = false,
	},
}
v600[3] = v603
local v604 = {
	["ItemType"] = "PetBoost",
	["ItemData"] = {
		["ItemName"] = "Small Treat",
		["AcceptAllTypes"] = false,
	},
}
v600[4] = v604
v599.Inputs = v600
local v605 = {}
local v606 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Smith Treat",
		["Quantity"] = 1,
	},
}
v605[1] = v606
v599.Outputs = v605
v599.TimeToCraft = 600
v599.PurchaseID = 3455273350
v599.RobuxPrice = 229
v599.LayoutOrder = 205
v599.MachineTypes = { "SmithingEventGearWorkbench" }
v599.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 4000000,
}
v2["Smith Treat"] = v599
local v607 = {}
local v608 = {}
local v609 = {
	["ItemType"] = "Harvest Tool",
	["ItemData"] = {
		["ItemName"] = "Harvest Tool",
		["AcceptAllTypes"] = false,
	},
}
v608[1] = v609
local v610 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v608[2] = v610
local v611 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v608[3] = v611
local v612 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v608[4] = v612
v607.Inputs = v608
local v613 = {}
local v614 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Smith Hammer of Harvest",
		["Quantity"] = 1,
	},
}
v613[1] = v614
v607.Outputs = v613
v607.TimeToCraft = 1800
v607.PurchaseID = 3455273154
v607.RobuxPrice = 149
v607.LayoutOrder = 220
v607.MachineTypes = { "SmithingEventGearWorkbench" }
v607.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 6000000,
}
v2["Smith Hammer of Harvest"] = v607
local v615 = {}
local v616 = {}
local v617 = {
	["ItemType"] = "PetEgg",
	["ItemData"] = {
		["ItemName"] = "Gem Egg",
		["AcceptAllTypes"] = false,
	},
}
v616[1] = v617
local v618 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v616[2] = v618
local v619 = {
	["ItemType"] = "PetShard",
	["ItemData"] = {
		["ItemName"] = "Cleansing Pet Shard",
		["AcceptAllTypes"] = false,
	},
}
v616[3] = v619
v615.Inputs = v616
local v620 = {}
local v621 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Pet Shard Forger",
		["Quantity"] = 1,
	},
}
v620[1] = v621
v615.Outputs = v620
v615.TimeToCraft = 3600
v615.PurchaseID = 3455275888
v615.RobuxPrice = 499
v615.LayoutOrder = 210
v615.MachineTypes = { "SmithingEventGearWorkbench" }
v615.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 15000000,
}
v2["Pet Shard Forger"] = v615
local v622 = {}
local v623 = {}
local v624 = {
	["ItemType"] = "Smith Hammer of Harvest",
	["ItemData"] = {
		["ItemName"] = "Smith Hammer of Harvest",
	},
}
v623[1] = v624
local v625 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v623[2] = v625
local v626 = {
	["ItemType"] = "Divine Coal",
	["ItemData"] = {
		["ItemName"] = "Divine Coal",
		["AcceptAllTypes"] = false,
	},
}
v623[3] = v626
local v627 = {
	["ItemType"] = "Lightning Rod",
	["ItemData"] = {
		["ItemName"] = "Lightning Rod",
		["AcceptAllTypes"] = false,
	},
}
v623[4] = v627
v622.Inputs = v623
local v628 = {}
local v629 = {
	["ItemType"] = "Gear",
	["ItemData"] = {
		["ItemName"] = "Thundelbringer",
		["Quantity"] = 1,
	},
}
v628[1] = v629
v622.Outputs = v628
v622.TimeToCraft = 4500
v622.PurchaseID = 3455277251
v622.RobuxPrice = 489
v622.LayoutOrder = 500
v622.MachineTypes = { "SmithingEventGearWorkbench" }
v622.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 40000000,
}
v2.Thundelbringer = v622
local v630 = {}
local v631 = {}
local v632 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v631[1] = v632
local v633 = {
	["ItemType"] = "Common Coal",
	["ItemData"] = {
		["ItemName"] = "Common Coal",
		["AcceptAllTypes"] = false,
	},
}
v631[2] = v633
local v634 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Grape",
		["AcceptAllTypes"] = false,
	},
}
v631[3] = v634
local v635 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Tomato",
		["AcceptAllTypes"] = false,
	},
}
v631[4] = v635
v630.Inputs = v631
local v636 = {}
local v637 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Olive",
		["Quantity"] = 1,
	},
}
v636[1] = v637
v630.Outputs = v636
v630.TimeToCraft = 900
v630.PurchaseID = 0
v630.RobuxPrice = 129
v630.LayoutOrder = 100
v630.MachineTypes = { "SmithingEventSeedWorkbench" }
v630.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 500000,
}
v2.Olive = v630
local v638 = {}
local v639 = {}
local v640 = {
	["ItemType"] = "Rare Coal",
	["ItemData"] = {
		["ItemName"] = "Rare Coal",
		["AcceptAllTypes"] = false,
	},
}
v639[1] = v640
local v641 = {
	["ItemType"] = "Legendary Coal",
	["ItemData"] = {
		["ItemName"] = "Legendary Coal",
		["AcceptAllTypes"] = false,
	},
}
v639[2] = v641
local v642 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Bamboo",
		["AcceptAllTypes"] = false,
	},
}
v639[3] = v642
local v643 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Cactus",
		["AcceptAllTypes"] = false,
	},
}
v639[4] = v643
v638.Inputs = v639
local v644 = {}
local v645 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Hollow Bamboo",
		["Quantity"] = 1,
	},
}
v644[1] = v645
v638.Outputs = v644
v638.TimeToCraft = 2700
v638.PurchaseID = 0
v638.RobuxPrice = 507
v638.LayoutOrder = 200
v638.MachineTypes = { "SmithingEventSeedWorkbench" }
v638.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 1500000,
}
v2["Hollow Bamboo"] = v638
local v646 = {}
local v647 = {}
local v648 = {
	["ItemType"] = "Divine Coal",
	["ItemData"] = {
		["ItemName"] = "Divine Coal",
		["AcceptAllTypes"] = false,
	},
}
v647[1] = v648
local v649 = {
	["ItemType"] = "Divine Coal",
	["ItemData"] = {
		["ItemName"] = "Divine Coal",
		["AcceptAllTypes"] = false,
	},
}
v647[2] = v649
local v650 = {
	["ItemType"] = "Holdable",
	["ItemData"] = {
		["ItemName"] = "Burning Bud",
		["AcceptAllTypes"] = false,
	},
}
v647[3] = v650
local v651 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Daffodil",
		["AcceptAllTypes"] = false,
	},
}
v647[4] = v651
v646.Inputs = v647
local v652 = {}
local v653 = {
	["ItemType"] = "Seed",
	["ItemData"] = {
		["ItemName"] = "Yarrow",
		["Quantity"] = 1,
	},
}
v652[1] = v653
v646.Outputs = v652
v646.TimeToCraft = 3600
v646.PurchaseID = 0
v646.RobuxPrice = 729
v646.LayoutOrder = 300
v646.MachineTypes = { "SmithingEventSeedWorkbench" }
v646.Cost = {
	["CurrencyType"] = "Sheckles",
	["Amount"] = 10000000,
}
v2.Yarrow = v646
local v654 = {}
for v655, v656 in v2 do
	for _, v657 in v656.MachineTypes do
		local v658 = v654[v657]
		if not v658 then
			v658 = {}
			v654[v657] = v658
		end
		v658[v655] = v656
	end
end
return {
	["ItemRecipes"] = v2,
	["RecipiesSortedByMachineType"] = v654,
}
