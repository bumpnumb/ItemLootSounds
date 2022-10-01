BasePath = "Interface\\Addons\\ItemLootSounds\\Sounds\\";

-- 0 	Poor 	    Poor 	    Gray
-- 1 	Common 	    Common      White
-- 2 	Uncommon 	Uncommon 	Green
-- 3 	Rare 	    Rare 	    Blue
-- 4 	Epic 	    Epic 	    Purple
-- 5 	Legendary 	Legendary 	Orange
-- 6 	Artifact 	Artifact 	Beige
-- 7 	Heirloom 	Heirloom 	Beige
-- 8 	WoWToken 	WoW Token 	Turquoise

QualityRules = {
    "",
    "",
    "green_item.mp3",
    "blue_item.mp3",
    "woo_epic.mp3",
    "markus_droppa_byxorna.mp3",
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
    {"", {"Small Dream Shard", "Lesser Cosmic Essence"}},
    {"", {"Frostweave Cloth", "Infinite Dust"}},
    {"", {"Copper Ore", "Tin Ore", "Silver Ore", "Iron Ore", "Gold Ore", "Mithril Ore", "Truesilver Ore", "Dark Iron Ore", "Fel Iron Ore", "Adamantite Ore"}},
    {"cobalt_ore.mp3", {"Cobalt Ore"}},
    {"saronite_ore.mp3", {"Saronite Ore"}},
    {"titanium_ore.mp3", {"Titanium Ore"}},
    {"eternal.mp3", {"Eternal Might", "Eternal Shadow", "Eternal Earth", "Eternal Fire", "Eternal Water", "Eternal Air", "Eternal Life", "Eternal Mana [PH]"}},
};



-- ################################# IGNORE REST #################################


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

function PlayRollSound()
    PlaySoundFile(BasePath.."time_to_roll.mp3");
end

local itemFilter = CreateFrame("frame");
itemFilter:RegisterEvent("Loot_Ready");
itemFilter:SetScript("OnEvent", ItemFilter);


local rollFilter = CreateFrame("frame");
rollFilter:RegisterEvent("START_LOOT_ROLL");
rollFilter:SetScript("OnEvent", PlayRollSound);
