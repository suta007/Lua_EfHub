-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-10 07:41:05
-- Luau version 6, Types version 3
-- Time taken: 0.027909 seconds

local module_upvr = {}
local tbl_3 = {
	Berry = {"Blueberry", "Cranberry", "Grape", "Raspberry", "Strawberry", "Celestiberry", "White Mulberry", "Lingonberry", "Elder Strawberry", "Willowberry", "Sunbulb", "Pyracantha", "Blue Raspberry", "Fall Berry", "Speargrass", "Mandrone Berry", "Evo Blueberry I", "Evo Blueberry II", "Evo Blueberry III", "Evo Blueberry IV", "Persimmon", "Fissure Berry", "Banesberry", "Viburnum Berry", "Pomegranate", "Asteris", "Gem Fruit", "Holly Berry", "Gift Berry", "Gumdrop", "Christmas Cracker", "Crimson Cranberry", "Hexberry"};
	Root = {"Carrot", "Mutant Carrot", "Chocolate Carrot", "Wild Carrot", "Taro Flower", "Potato", "Mandrake", "Rhubarb", "Onion", "Tall Asparagus", "Horsetail", "Spring Onion", "Aurora Vine", "Radish", "Turnip", "Mangrove", "Auburn Pine", "Evo Beetroot I", "Evo Beetroot II", "Evo Beetroot III", "Evo Beetroot IV", "Ghoul Root", "Mummy's Hand", "Devilroot", "Trinity Fruit", "Lumin Bloom", "Asteris", "Octobloom", "Reindeer Root", "Colorpop Crop", "Kernel Curl"};
	Candy = {"Blue Lollipop", "Candy Blossom", "Candy Sunflower", "Chocolate Carrot", "Easter Egg", "Red Lollipop", "Sugarglaze", "Maple Resin", "Chicken Feed", "Candy Cornflower", "Gem Fruit", "Peppermint Vine", "Gingerbread Blossom", "Cookie Stack", "Peppermint Pop", "Gumdrop", "Christmas Cracker", "Candy Cane", "Sparkle Slice", "Confetti Tula", "Candlite", "Kernel Curl"};
	Flower = {"Candy Blossom", "Candy Sunflower", "Cherry Blossom", "Crocus", "Daffodil", "Lotus", "Orange Tulip", "Buttercup", "Big Buttercup", "Bigger Buttercup", "Biggest Buttercup", "Beast Buttercup", "Shadow Buttercup", "Big Shadow Buttercup", "Bigger Shadow Buttercup", "Biggest Shadow Buttercup", "Beast Shadow Buttercup", "Pink Tulip", "Nightshade", "Moonflower", "Moon Blossom", "Rose", "Foxglove", "Lilac", "Pink Lily", "Purple Dahlia", "Sunflower", "Legacy Sunflower", "Lavender", "Suncoil", "Honeysuckle", "Manuka Flower", "Ember Lily", "Noble Flower", "Bee Balm", "Succulent", "Parasol Flower", "Rosy Delight", "Lily of the Valley", "Burning Bud", "Rafflesia", "Stonebite", "Liberty Lily", "Firework Flower", "Confetti Tula", "Grand Volcania", "Serenity", "Monoblooma", "Hinomai", "Taro Flower", "Zenflare", "Soft Sunshine", "Dezen", "Artichoke", "Veinpetal", "Cyclamen", "Flare Daisy", "Sakura Bush", "Dandelion", "Peace Lily", "Delphinium", "Bone Blossom", "Tranquil Bloom", "Paradise Petal", "Crown of Thorns", "Calla Lily", "Cyclamen", "Briar Rose", "Spirit Flower", "Broccoli", "Pyracantha", "Horned Melon", "Urchin Plant", "Untold Bell", "Pixie Faern", "Kniphofia", "Torchflare", "Corpse Flower", "Black Bat Flower", "Sundew", "Fissure Berry", "Candy Cornflower", "Wisp Flower", "Horned Redrose", "Monster Flower", "Protea", "Horned Redrose", "Banana Orchid", "Thornspire", "Daisy", "Peacock Tail", "Lumin Bloom", "Yarrow", "Sunflower", "Legacy Sunflower", "Zucchini", "Pomegranate", "Wild Pineapple", "Asteris", "Octobloom", "Pinkside Dandelion", "Sherrybloom", "Gingerbread Blossom", "Poinsettia", "Cryo Rose", "Frosty Bite", "Colorpop Crop", "Blooming Cactus", "Bonanza Bloom"};
	Fruit = {"Apple", "Avocado", "Banana", "Blueberry", "Coconut", "Cranberry", "Dragon Fruit", "Durian", "Grape", "Lemon", "Lime", "Mango", "Papaya", "Passionfruit", "Peach", "Pear", "Pineapple", "Raspberry", "Strawberry", "Watermelon", "Starfruit", "Blood Banana", "Moon Melon", "Celestiberry", "Moon Mango", "Nectarine", "Hive Fruit", "Green Apple", "Sugar Apple", "Traveler's Fruit", "Loquat", "Kiwi", "Glass Kiwi", "White Mulberry", "Lingonberry", "Maple Apple", "Spiked Mango", "Crown Melon", "Grand Tomato", "Pricklefruit", "Mangosteen", "Canary Melon", "Tomato", "Cantaloupe", "Pumpkin", "Eggplant", "Feijoa", "Prickly Pear", "Guanabana", "Bitter Melon", "Corn", "Violet Corn", "Elder Strawberry", "Willowberry", "Carrot", "Cocomango", "Pixie Faern", "Blue Raspberry", "Ackee", "Pixie Faern", "Carnival Pumpkin", "Meyer Lemon", "Golden Peach", "Mangrove", "Fall Berry", "Fruitball", "Mandrone Berry", "Evo Pumpkin I", "Evo Pumpkin II", "Evo Pumpkin III", "Evo Pumpkin IV", "Evo Apple I", "Evo Apple II", "Evo Apple III", "Evo Apple IV", "Evo Blueberry I", "Evo Blueberry II", "Evo Blueberry III", "Evo Blueberry IV", "Cherry", "Hazelnut", "Pecan", "Chicken Feed", "Poison Apple", "Jack O Lantern", "Blood Orange", "Zombie Fruit", "Baobab", "Trinity Fruit", "Faestar", "Amberfruit Shrub", "Java Banana", "Olive", "Zucchini", "Wild Pineapple", "Pomegranate", "Asteris", "Gem Fruit", "Mahogany", "Coinfruit", "Holly Berry", "Cryoshard", "Sparkle Slice", "Hexberry", "Plumwillow", "Yellow Core"};
	Leafy = {"Apple", "Blueberry", "Cranberry", "Eggplant", "Grape", "Mango", "Peach", "Pineapple", "Pumpkin", "Raspberry", "Strawberry", "Tomato", "Watermelon", "Cantaloupe", "Cacao", "Beanstalk", "Coolcool Beanbeanstalk", "Mint", "Moonflower", "Starfruit", "Moonglow", "Moon Blossom", "Blood Banana", "Celestiberry", "Moon Mango", "Rose", "Foxglove", "Lilac", "Pink Lily", "Purple Dahlia", "Sunflower", "Legacy Sunflower", "Nectarine", "Hive Fruit", "Lumira", "Honeysuckle", "Noble Flower", "Bee Balm", "Green Apple", "Sugar Apple", "Parasol Flower", "Elephant Ears", "Black Magic Ears", "Traveler's Fruit", "Rosy Delight", "Cauliflower", "Aloe Vera", "Lily of the Valley", "Pitcher Plant", "Rafflesia", "Firefly Fern", "Giant Pinecone", "Serenity", "Soft Sunshine", "Dragon Sapling", "Maple Apple", "Spiked Mango", "Sakura Bush", "Frost Bush", "Grand Tomato", "Artichoke", "Twisted Tangle", "Log Pumpkin", "Mandrake", "Cyclamen", "Mangosteen", "Princess Thorn", "Romanesco", "Purple Cabbage", "King Cabbage", "Spirit Lantern", "Glowpod", "Shimmersprout", "Willowberry", "Brussels Sprout", "Cocomango", "Urchin Plant", "Fennel", "Pixie Faern", "Emerald Bud", "Aetherfruit", "Parsley", "Maple Resin", "Naval Wort", "Fall Berry", "Speargrass", "Torchflare", "Auburn Pine", "Firewell", "Frostspike", "Evo Pumpkin I", "Evo Pumpkin II", "Evo Pumpkin III", "Evo Pumpkin IV", "Evo Apple I", "Evo Apple II", "Evo Apple III", "Evo Apple IV", "Evo Blueberry I", "Evo Blueberry II", "Evo Blueberry III", "Evo Blueberry IV", "Persimmon", "Ferntail", "Great Pumpkin", "Jack O Lantern", "Poison Apple", "Candy Cornflower", "Wereplant", "Sugarcane", "Monster Flower", "Protea", "Ghost Pepper", "Trinity Fruit", "Amberfruit Shrub", "Bamboo Tree", "Daisy", "Java Banana", "Peacock Tail", "Olive", "Sunflower", "Legacy Sunflower", "Luna Stem", "Hollow Bamboo", "Zucchini", "Iciclesco", "Wild Pineapple", "Pomegranate", "Asteris", "Coilvine", "Coinfruit", "Monster Plum", "Pinkside Dandelion", "Archling", "Cold Snap Suckle", "Rosemary", "Wintercreep", "Holly Berry", "Gift Berry", "Cryo Rose", "Bush Flake", "Pollen Cone", "Frosty Bite", "Crimson Cranberry", "Reindeer Root", "Christmas Tree", "Firework Fern", "Jungle Queen Bulb", "Shimmersprout", "Blooming Cactus", "Madcrown Vine", "Bonanza Bloom", "Amazon Feather Fern"};
	Sour = {"Cranberry", "Lemon", "Lime", "Passionfruit", "Starfruit", "Mangosteen", "Flare Melon", "Mangosteen", "Kiwi", "Glass Kiwi", "Sunbulb", "Cocomango", "Horned Melon", "Meyer Lemon", "Golden Peach", "Speargrass", "Fissure Berry", "Poison Apple", "Blood Orange", "Severed Spine", "Buddhas Hand", "Olive", "Wild Pineapple", "Pomegranate", "Asteris", "Cryoshard", "Crimson Cranberry", "Hexberry"};
	Sweet = {"Banana", "Blue Lollipop", "Blueberry", "Candy Blossom", "Candy Sunflower", "Chocolate Carrot", "Easter Egg", "Grape", "Mango", "Peach", "Pear", "Pineapple", "Raspberry", "Red Lollipop", "Strawberry", "Watermelon", "Starfruit", "Nectar Thorn", "Sugar Apple", "Moon Melon", "Spiked Mango", "Sugarglaze", "Crown Melon", "Mangosteen", "Canary Melon", "Romanesco", "Cocomango", "Pixie Faern", "Blue Raspberry", "Untold Bell", "Carnival Pumpkin", "Golden Peach", "Fall Berry", "Evo Pumpkin I", "Evo Pumpkin II", "Evo Pumpkin III", "Evo Pumpkin IV", "Evo Apple I", "Evo Apple II", "Evo Apple III", "Evo Apple IV", "Evo Blueberry I", "Evo Blueberry II", "Evo Blueberry III", "Evo Blueberry IV", "Cherry", "Persimmon", "Chicken Feed", "Poison Apple", "Candy Cornflower", "Sugarcane", "Buddhas Hand", "Trinity Fruit", "Faestar", "Madras Thorn", "Olive", "Zucchini", "Pomegranate", "Asteris", "Coinfruit", "Peppermint Vine", "Gingerbread Blossom", "Cookie Stack", "Frosty Bite", "Crimson Cranberry", "Peppermint Pop", "Gumdrop", "Christmas Cracker", "Candy Cane", "Sparkle Slice", "Confetti Tula", "Candlite", "Plumwillow"};
	Tropical = {"Banana", "Coconut", "Dragon Fruit", "Durian", "Mango", "Papaya", "Passionfruit", "Pineapple", "Watermelon", "Parasol Flower", "Cocovine", "Starfruit", "Ackee", "Persimmon", "Fissure Berry", "Glass Kiwi", "Sugarcane", "Banana Orchid", "Orange Delight", "Aqua Lily", "Olive", "Pomegranate", "Coilvine", "Wild Frond"};
	Vegetable = {"Carrot", "Wild Carrot", "Chocolate Carrot", "Corn", "Violet Corn", "Eggplant", "Pepper", "Pumpkin", "Purple Cabbage", "Tomato", "Beanstalk", "Coolcool Beanbeanstalk", "Mint", "Dragon Pepper", "Cauliflower", "Bell Pepper", "Taro Flower", "Artichoke", "Onion", "Jalapeno", "Tall Asparagus", "Grand Tomato", "Log Pumpkin", "Badlands Pepper", "Rhubarb", "King Cabbage", "Bitter Melon", "Mandrake", "Mutant Carrot", "Romanesco", "Snaparino Beanarini", "Untold Bell", "Brussels Sprout", "Potato", "Broccoli", "Fennel", "Emerald Bud", "Radish", "Turnip", "Parsley", "Carnival Pumpkin", "Evo Beetroot I", "Evo Beetroot II", "Evo Beetroot III", "Evo Beetroot IV", "Evo Pumpkin I", "Evo Pumpkin II", "Evo Pumpkin III", "Evo Pumpkin IV", "Pecan", "Great Pumpkin", "Jack O Lantern", "Ghost Pepper", "Severed Spine", "Zucchini", "Iciclesco", "Asteris", "Coilvine", "Sherrybloom", "Frost Pepper", "Magma Pepper"};
	Woody = {"Apple", "Sugar Apple", "Avocado", "Cacao", "Coconut", "Durian", "Mango", "Papaya", "Peach", "Pear", "Moon Blossom", "Moon Mango", "Nectarine", "Hive Fruit", "Cocovine", "Traveler's Fruit", "Kiwi", "Glass Kiwi", "Feijoa", "Giant Pinecone", "Dragon Sapling", "Maple Apple", "Spiked Mango", "Sakura Bush", "Rhubarb", "Duskpuff", "Mangosteen", "Gleamroot", "Amberheart", "Bamboo", "Lucky Bamboo", "Bendboo", "Boneboo", "Glowpod", "Willowberry", "Cocomango", "Aurora Vine", "Aetherfruit", "Maple Resin", "Mangrove", "Fall Berry", "Speargrass", "Auburn Pine", "Firewell", "Frostspike", "Naval Wort", "Evo Apple I", "Evo Apple II", "Evo Apple III", "Evo Apple IV", "Cherry", "Acorn", "Hazelnut", "Pecan", "Poison Apple", "Ghost Bush", "Weeping Branch", "Severed Spine", "Baobab", "Trinity Fruit", "Amberfruit Shrub", "Bamboo Tree", "Castor Bean", "Hollow Bamboo", "Walnut", "Asteris", "Mahogany", "Rosemary", "Wintercreep", "Antlerbloom", "Gift Berry", "Bush Flake", "Pollen Cone", "Frosty Bite", "Crimson Cranberry", "Christmas Cracker", "Reindeer Root", "Christmas Tree", "Plumwillow", "Madcrown Vine", "Bonanza Bloom"};
	Prickly = {"Cactus", "Dragon Fruit", "Durian", "Pineapple", "Venus Fly Trap", "Celestiberry", "Nectar Thorn", "Prickly Pear", "Aloe Vera", "Horned Dinoshroom", "Spiked Mango", "Twisted Tangle", "Pricklefruit", "Princess Thorn", "Crown of Thorns", "Glowthorn", "Pyracantha", "Horned Melon", "Speargrass", "Firewell", "Rose", "Frostspike", "Crimson Thorn", "Multitrap", "Poison Apple", "Horned Redrose", "Devilroot", "Severed Spine", "Horned Redrose", "Thornspire", "Trinity Fruit", "Cyberflare", "Wild Pineapple", "Asteris", "Firework Fern", "Blooming Cactus", "Bonanza Bloom"};
	Toxic = {"Foxglove", "Nightshade", "Rafflesia", "Pitcher Plant", "Horned Dinoshroom", "Sinisterdrip", "Cursed Fruit", "Amber Spine", "Glowthorn", "Ackee", "Torchflare", "Firewell", "Corpse Flower", "Poison Apple", "Witch Cap", "Zombie Fruit", "Mummy's Hand", "Devilroot", "Horned Redrose", "Viburnum Berry", "Wyrmvine", "Castor Bean", "Lumin Bloom", "Asteris", "Icestalite"};
	Fungus = {"Mega Mushroom", "Mushroom", "Glowshroom", "Nectarshade", "Horned Dinoshroom", "Sinisterdrip", "Duskpuff", "Autumn Shroom", "Evo Mushroom I", "Evo Mushroom II", "Evo Mushroom III", "Evo Mushroom IV", "Bloodred Mushroom", "Witch Cap", "Frosty Bite", "Asteris", "Shimmersprout"};
	Night = {"Blood Banana", "Moon Melon", "Nightshade", "Glowshroom", "Mint", "Moonflower", "Starfruit", "Moonglow", "Moon Blossom", "Moon Mango", "Celestiberry", "Aura Flora", "Gleamroot", "Glowpod", "Glowthorn", "Lightshoot", "Black Bat Flower", "Banesberry", "Ghost Bush", "Wereplant", "Wyrmvine", "Trinity Fruit", "Faestar", "Lumin Bloom", "Luna Stem", "Asteris", "Firework Fern", "Shimmersprout", "Hexberry", "Madcrown Vine"};
	Spicy = {"Cursed Fruit", "Ember Lily", "Pepper", "Dragon Pepper", "Cacao", "Horned Dinoshroom", "Grand Volcania", "Jalapeno", "Badlands Pepper", "Taco Fern", "Briar Rose", "Radish", "Torchflare", "Inferno Quince", "Poison Apple", "Ghost Pepper", "Devilroot", "Ghost Pepper", "Luna Stem", "Asteris", "Peppermint Vine", "Gingerbread Blossom", "Firework Fern", "Frost Pepper", "Magma Pepper"};
	Stalky = {"Beanstalk", "Coolcool Beanbeanstalk", "Burning Bud", "Zebrazinkle", "Bamboo", "Dandelion", "Mushroom", "Bendboo", "Lotus", "Black Magic Ears", "Elephant Ears", "Lily of the Valley", "Pitcher Plant", "Stonebite", "Firefly Fern", "Horned Dinoshroom", "Grand Volcania", "Soft Sunshine", "Hinomai", "Sinisterdrip", "Lucky Bamboo", "Sugarglaze", "Tall Asparagus", "Veinpetal", "Pricklefruit", "Spring Onion", "Mutant Carrot", "Poseidon Plant", "Corn", "Violet Corn", "Mega Mushroom", "Glowshroom", "Spectralis", "Spirit Lantern", "Flare Melon", "Snaparino Beanarino", "Untold Bell", "Brussels Sprout", "Lightshoot", "Urchin Plant", "Pyracantha", "Urchin Plant", "Kniphofia", "Parsley", "Mangrove", "Naval Wort", "Autumn Shroom", "Crimson Thorn", "Black Bat Flower", "Inferno Quince", "Multitrap", "Naval Wort", "Ferntail", "Chicken Feed", "Seer Vine", "Candy Cornflower", "Devilroot", "Severed Spine", "Sugarcane", "Spider Vine", "Viburnum Berry", "Thornspire", "Wyrmvine", "Orange Delight", "Faestar", "Bamboo Tree", "Sunflower", "Legacy Sunflower", "Luna Stem", "Hollow Bamboo", "Zucchini", "Frosty Bite", "Asteris", "Coilvine", "Mahogany", "Coinfruit", "Pinkside Dandelion", "Rosemary", "Wintercreep", "Peppermint Vine", "Peppermint Pop", "Christmas Cracker", "Reindeer Root", "Candy Cane", "Colorpop Crop", "Firework Fern", "Madcrown Vine", "Blooming Cactus", "Kernel Curl", "Bonanza Bloom"};
	Summer = {"Carrot", "Strawberry", "Blueberry", "Tomato", "Watermelon", "Rafflesia", "Cauliflower", "Green Apple", "Avocado", "Banana", "Pineapple", "Kiwi", "Bell Pepper", "Prickly Pear", "Loquat", "Feijoa", "Pitcher Plant", "Sugar Apple", "Wild Carrot", "Pear", "Cantaloupe", "Parasol Flower", "Rosy Delight", "Elephant Ears", "Delphinium", "Lily of the Valley", "Traveler's Fruit", "Peace Lily", "Aloe Vera", "Guanabana", "Butternut Squash", "Black Magic Ears", "Daisy", "Peacock Tail", "Sunflower", "Legacy Sunflower", "Wild Pineapple", "Pomegranate"};
	Prehistoric = {"Stonebite", "Paradise Petal", "Horned Dinoshroom", "Boneboo", "Firefly Fern", "Fossilight", "Bone Blossom", "Horsetail", "Lingonberry", "Amber Spine", "Grand Volcania"};
	Zen = {"Monoblooma", "Serenity", "Taro Flower", "Zen Rocks", "Hinomai", "Maple Apple", "Zenflare", "Soft Sunshine", "Spiked Mango", "Sakura Bush", "Enkaku", "Dezen", "Lucky Bamboo", "Tranquil Bloom", "Buddhas Hand", "Bamboo Tree", "Lumin Bloom", "Hollow Bamboo"};
	Magical = {"Mandrake", "Soul Fruit", "Cursed Fruit", "Firework Flower", "Fossilight", "Tranquil Bloom", "King Cabbage", "Amberheart", "Golden Egg", "Spirit Flower", "Wispwing", "Aurora Vine", "Emerald Bud", "Aetherfruit", "Untold Bell", "Pixie Faern", "Poison Apple", "Seer Vine", "Poison Apple", "Great Pumpkin", "Weeping Branch", "Wisp Flower", "Devilroot", "Wereplant", "Trinity Fruit", "Faestar", "Peacock Tail", "Lumin Bloom", "Asteris", "Gem Fruit", "Octobloom", "Sherrybloom", "Frostwing", "Gift Berry", "Spirit Sparkle", "Christmas Tree", "Shimmersprout", "Confetti Tula", "Hexberry"};
	Fall = {"Corn", "Pumpkin", "Turnip", "Parsley", "Meyer Lemon", "Carnival Pumpkin", "Kniphofia", "Golden Peach", "Maple Resin", "Great Pumpkin", "Jack O Lantern", "Sunflower", "Legacy Sunflower", "Pomegranate"};
	Nutty = {"Hazelnut", "Acorn", "Filbert Nut", "Coconut", "Acorn Squash", "Pecan", "Castor Bean", "Christmas Cracker", "Peanut", "Crunchnut"};
	Spooky = {"Bloodred Mushroom", "Jack O Lantern", "Ghoul Root", "Chicken Feed", "Seer Vine", "Poison Apple", "Banesberry", "Blood Orange", "Mummy's Hand", "Wisp Flower", "Zombie Fruit", "Candy Cornflower", "Weeping Branch", "Ghost Bush", "Devilroot", "Wereplant", "Severed Spine", "Monster Flower", "Spider Vine", "Ghost Pepper", "Wyrmvine", "Observee", "Lumin Bloom", "Asteris", "Hexberry", "Madcrown Vine"};
	Safari = {"Ackee", "Aloe Vera", "Auburn Pine", "Banana", "Bamboo", "Cactus", "Coconut", "Elephant Ears", "Firewell", "Golden Peach", "Horned Melon", "Mango", "Mangrove", "Papaya", "Persimmon", "Pineapple", "Prickly Pear", "Pyracantha", "Speargrass", "Crown of Thorns", "Kniphofia", "Amber Spine", "Orange Delight", "Protea", "Baobab", "Trinity Fruit", "Daisy", "Bamboo Tree", "Amberfruit Shrub", "Castor Bean", "Java Banana", "Peacock Tail", "Madras Thorn", "Zebrazinkle"};
	Christmas = {"Gingerbread Blossom", "Cookie Stack", "Poinsettia", "Antlerbloom", "Holly Berry", "Gift Berry", "Gift Root", "Mammoth Mistletoe", "Frosty Bite", "Cryo Rose", "Bush Flake", "Rosemary", "Cryoshard", "Frostwing", "Pollen Cone", "Peppermint Vine", "Peppermint Pop", "Gumdrop", "Christmas Cracker", "Reindeer Root", "Spirit Sparkle", "Candy Cane", "Snowman Sprout", "Christmas Tree", "Candlite", "Frost Pepper"};
	Apple = {"Apple", "Sugar Apple", "Pineapple", "Maple Apple", "Green Apple", "Evo Apple I", "Evo Apple II", "Evo Apple III", "Evo Apple IV", "Poison Apple", "Wild Pineapple"};
}
module_upvr.Traits = tbl_3
local tbl_2_upvr = {
	Berry = {142, 68, 173};
	Root = {179, 129, 72};
	Flower = {255, 105, 180};
	Fruit = {39, 174, 96};
	Leafy = {46, 204, 113};
	Sour = {241, 196, 15};
	Sweet = {241, 148, 138};
	Tropical = {26, 188, 156};
	Vegetable = {88, 214, 141};
	Woody = {147, 81, 22};
	Prickly = {211, 84, 0};
	Fungus = {165, 105, 189};
	Spicy = {192, 57, 43};
	Stalky = {34, 153, 84};
	Summer = {255, 170, 51};
	Candy = {230, 126, 34};
	Night = {93, 109, 126};
	Prehistoric = {133, 163, 81};
	Zen = {129, 207, 224};
	Toxic = {128, 0, 128};
	Magical = {186, 85, 211};
	Nutty = {199, 136, 60};
	Spooky = {88, 0, 153};
}
local tbl = {194, 178, 128}
tbl_2_upvr.Safari = tbl
tbl = {}
local var67 = tbl
for i, _ in tbl_3 do
	var67[i] = i
end
module_upvr.TraitNames = var67
for i_2, v_2 in tbl_3 do
	local tbl_5 = {}
	for _, v_3 in v_2 do
		tbl_5[v_3] = true
	end
	module_upvr[i_2] = tbl_5
end
function module_upvr.HasTrait(arg1, arg2) -- Line 1323
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not arg1 or arg1 == "" then
		warn("PlantTraitsData.HasTrait | No plant name given!")
		return false
	end
	if not arg2 or arg2 == "" then
		warn("PlantTraitsData.HasTrait | No trait name given!")
		return false
	end
	local var69 = module_upvr[arg2]
	if not var69 or not var69[arg1] then
	end
	return false
end
function module_upvr.GetTraits(arg1) -- Line 1337
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not arg1 or arg1 == "" then
		warn("PlantTraitsData.GetTraits | No plant name given!")
		return {}
	end
	for i_4, v_4 in module_upvr do
		if typeof(v_4) == "table" and v_4[arg1] then
			table.insert({}, i_4)
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return {}
end
function module_upvr.GetTraitsAsString(arg1) -- Line 1352
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: tbl_2_upvr (readonly)
	]]
	if not arg1 or arg1 == "" then
		warn("PlantTraitsData.GetTraitsAsString | No plant name given!")
		return ""
	end
	for i_5, v_5 in module_upvr do
		if typeof(v_5) == "table" and v_5[arg1] and module_upvr.TraitNames[i_5] then
			if not tbl_2_upvr[i_5] then
				local tbl_4 = {255, 255, 255}
			end
			table.insert({}, `<font color="{string.format("#%02X%02X%02X", tbl_4[1], tbl_4[2], tbl_4[3])}">{i_5}</font>`)
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return table.concat({}, ", ")
end
return module_upvr
