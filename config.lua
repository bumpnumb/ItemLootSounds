BasePath = "Interface\\Addons\\ItemLootSounds\\Sounds\\";

-- 0 	Poor 	    Poor 	
-- 1 	Common 	    Common 
-- 2 	Uncommon 	Uncommon 	
-- 3 	Rare 	    Rare 	
-- 4 	Epic 	    Epic 	
-- 5 	Legendary 	Legendary 	
-- 6 	Artifact 	Artifact 	
-- 7 	Heirloom 	Heirloom 	
-- 8 	WoWToken 	WoW Token 	

QualityRules = {
    "tuturu.mp3",
    "tuturu.mp3",
    "Wow.mp3",
    "nyalong.mp3",
    "Nani.mp3",
    "",
    "",
    "",
    ""
};


-- {"Sound file (.wav, .mp3, .ogg)", {Comma separated list of item names}}
-- Sould rules take priority in descending order meaning:

-- {"nya.wav", {"Small Dream Shard"}},
-- {"tuturu.mp3", {"Frostweave Cloth", "Small Dream Shard"}},

-- "Small Dream Shard" will get "tuturu.mp3" sound

-- ItemRules always takes priority over QualityRules

ItemRules = {
    {"nya.wav", {"Small Dream Shard"}},
    {"tuturu.mp3", {"Frostweave Cloth", "Infinite Dust"}},
    {"", {"Lesser Cosmic Essence"}}
};