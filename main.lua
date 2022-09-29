BasePath = "Interface\\Addons\\ItemFilter\\Sounds\\";

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

ItemRules = {
    {"nyalong.mp3", {"Small Dream Shard"}},
    {"tuturu.mp3", {"Frostweave Cloth", "Infinite Dust"}},
    {"", {"Lesser Cosmic Essence"}}
};



local delay = 0
local DEBOUNCE_INTERVAL = 0.3

function ItemFilter()
    if GetTime() - delay >= DEBOUNCE_INTERVAL then
        delay = GetTime()
        local info = GetLootInfo();

        local bestQuality = 0;
        
        for i = 1, #info do
            local itemInfo = info[i];
            local itemQuality = itemInfo.quality + 1;
            if itemQuality > bestQuality then
                bestQuality = itemQuality;
            end
        end



        local bestSound = BasePath..QualityRules[bestQuality];
        -- bestSound = ItemRules[bestRule][1];
        PlaySoundFile(bestSound)

        -- if bestSound ~= "" then
        --     -- PlaySoundFile(BasePath..bestSound);
        --     PlaySoundFile("Interface\\Addons\\ItemFilter\\Sounds\\".."nya.wav")
        -- end
    end
end



local itemFilter = CreateFrame("frame")
itemFilter:RegisterEvent("Loot_Ready")
itemFilter:SetScript("OnEvent", ItemFilter)


