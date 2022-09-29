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
    "nya.wav",
    "tuturu.mp3",
    "Wow.mp3",
    "nyalong.mp3",
    "Nani.mp3",
    nil,
    nil,
    nil,
    nil
};

ItemRules = {
    {"nyalong.mp3", {"Small Dream Shard"}},
    {"Nya! arigato.wav", {"Frostweave Cloth", "Infinite Dust"}},
    {nil, {"Lesser Cosmic Essence"}}
};



local delay = 0
local DEBOUNCE_INTERVAL = 0.3

function ItemFilter()
    if GetTime() - delay >= DEBOUNCE_INTERVAL then
        delay = GetTime()
        local info = GetLootInfo();

        local bestQuality = 0;
        local bestRule = 0;
        local bestSound = "";
        
        for i = 1, #info do
            local itemInfo = info[i];
            if itemInfo.quality + 1 > bestQuality then
                bestQuality = itemInfo.quality + 1;
            end
            
            for rule = 1, #ItemRules do
                for itemName = 1, #ItemRules[2] do
                    if itemInfo.item == ItemRules[rule][2][itemName] then
                        bestRule = rule;
                    end
                end
            end
        end


        if bestRule == 0 then
            bestSound = QualityRules[bestQuality];
        else
            bestSound = ItemRules[bestRule][1];
        end

        if bestSound ~= "" then
            -- PlaySoundFile(BasePath..bestSound);
            PlaySoundFile("Interface\\Addons\\ItemFilter\\Sounds\\".."nya.wav")
        end
    end
end



local itemFilter = CreateFrame("frame")
itemFilter:RegisterEvent("Loot_Ready")
itemFilter:SetScript("OnEvent", ItemFilter)


