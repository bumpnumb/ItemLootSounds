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
    "",
    "",
    "nya.wav",
    "tuturu.mp3",
    "pinnes.mp3",
    "Wow.mp3",
    "nyalong.mp3",
    "nyalong.mp3",
    "nyalong.mp3"
};


-- {"Sound file (.wav, .mp3, .ogg)", {Comma separated list of item names}}
-- Sould rules take priority in descending order meaning:

-- {"nya.wav", {"Small Dream Shard"}},
-- {"tuturu.mp3", {"Frostweave Cloth", "Small Dream Shard"}},

-- "Small Dream Shard" will get "tuturu.mp3" sound

-- ItemRules always takes priority over QualityRules

ItemRules = {
    {"nya.wav", {"Small Dream Shard", "Lesser Cosmic Essence"}},
    {"tuturu.mp3", {"Frostweave Cloth", "Infinite Dust"}},
};

local delay = 0
local DEBOUNCE_INTERVAL = 0.3

function ItemFilter()
    if GetTime() - delay >= DEBOUNCE_INTERVAL then
        delay = GetTime()
        local info = GetLootInfo();

        local bestQuality = 0;
        local bestRule = 0;

        for i = 1, #info do
            local itemInfo = info[i];
            local itemQuality = itemInfo.quality + 1;
            if itemQuality > bestQuality then
                bestQuality = itemQuality;
            end

            for rule = 1, #ItemRules do
                for itemName = 1, #ItemRules[2] do
                    if itemInfo.item == ItemRules[rule][2][itemName] then
                        bestRule = rule;
                    end
                end
            end
        end

        local bestSound = BasePath..QualityRules[bestQuality]; -- will alyways proc
        if bestRule ~= 0 then
            bestSound = BasePath..ItemRules[bestRule][1];
        end

        PlaySoundFile(bestSound)
    end
end



local itemFilter = CreateFrame("frame")
itemFilter:RegisterEvent("Loot_Ready")
itemFilter:SetScript("OnEvent", ItemFilter)


