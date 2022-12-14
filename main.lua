BasePath = "Interface\\Addons\\ItemLootSounds\\Sounds\\";

-- Item Qualities are:
-- 0 	Poor 	    Poor 	    Gray
-- 1 	Common 	    Common      White
-- 2 	Uncommon 	Uncommon 	Green
-- 3 	Rare 	    Rare 	    Blue
-- 4 	Epic 	    Epic 	    Purple
-- 5 	Legendary 	Legendary 	Orange
-- 6 	Artifact 	Artifact 	Beige
-- 7 	Heirloom 	Heirloom 	Beige
-- 8 	WoWToken 	WoW Token 	Turquoise

-- Sound when looting
-- LootItemRules overrides LootQualityRules


LootQualityRules = {
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

-- {"nya.wav", {"Small Dream Shard"}},
-- {"tuturu.mp3", {"Frostweave Cloth", "Small Dream Shard"}},

-- "Small Dream Shard" will use "tuturu.mp3" sound


-- Empty string as sound can be used to silence item, for example:
-- {"", {"Small Dream Shard"}},
-- means "Small Dream Shard" will have no sound when found


-- ItemRules always takes priority over QualityRules


LootItemRules = {
    {"", {"Small Dream Shard", "Lesser Cosmic Essence"}},
    {"", {"Frostweave Cloth", "Infinite Dust"}},
    {"", {"Copper Ore", "Tin Ore", "Silver Ore", "Iron Ore", "Gold Ore", "Mithril Ore", "Truesilver Ore", "Dark Iron Ore", "Fel Iron Ore", "Adamantite Ore"}},
    {"cobalt_ore.mp3", {"Cobalt Ore"}},
    {"saronite_ore.mp3", {"Saronite Ore"}},
    {"titanium_ore.mp3", {"Titanium Ore"}},
    {"eternal.mp3", {"Eternal Might", "Eternal Shadow", "Eternal Earth", "Eternal Fire", "Eternal Water", "Eternal Air", "Eternal Life", "Eternal Mana [PH]"}},
};

EventRules = {
    {"achievement.mp3", "ACHIEVEMENT_EARNED"},
    {"kul_att_man_va_bjuden.mp3", "PARTY_INVITE_REQUEST"},
    {"fan_va_duktig_du_ar.mp3", "PLAYER_LEVEL_UP"},
    
}


-- Sound when rolling for loot
-- RollItemRules overrides RollQualityRules

RollQualityRules = {
    "",
    "",
    "rap_vafan.mp3",
    "dags_att_forlora_rolls.mp3",
    "håll_i_mig_forfan.mp3",
    "korka_up_nu_dani.mp3",
    "ateru.mp3",
    "kul_att_man_va_bjuden.mp3",
    "kul_att_man_va_bjuden.mp3"
};
RollItemRules = {
    {"", {"Small Dream Shard"}},
};

-- ################################# IGNORE REST #################################


local delay = 0
local DEBOUNCE_INTERVAL = 0.3
local soundDelay = 0;
local awaitCorrectSoundDuration = 0.3;
local lootSound = "";



function PlayLootSound()
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

            for rule = 1, #LootItemRules do
                for itemName = 1, #LootItemRules[rule][2] do
                    if itemInfo.item == LootItemRules[rule][2][itemName] then
                        bestRule = rule;
                    end
                end
            end
        end

        local bestSound = BasePath..LootQualityRules[bestQuality]; -- will alyways proc
        if bestRule ~= 0 then
            bestSound = BasePath..LootItemRules[bestRule][1];
        end

        -- lootSound = bestSound
        PlaySoundFile(bestSound, "master")
    end
end


function PlayRollSound(id)
    local texture, name, count, quality = GetLootRollItemInfo(id);

    print("Name: "..name..", Quality: "..tostring(quality)..", EventId: "..tostring(id))

    local bestRule = 0;

    for rule = 1, #RollItemRules do
        for itemName = 1, #RollItemRules[rule][2] do
            if name == RollItemRules[rule][2][itemName] then
                bestRule = rule;
            end
        end
    end

    local bestSound = BasePath..RollQualityRules[quality + 1]; -- will alyways proc
    if bestRule ~= 0 then
        bestSound = BasePath..RollItemRules[bestRule][1];
    end

    -- lootSound = bestSound
    PlaySoundFile(bestSound, "master")
end


function PlayEventSound(event)
    local sound = ""
    for i = 1, #EventRules do
        if (EventRules[i][2] == event) then
            sound = EventRules[i][1]
        end
    end

    PlaySoundFile(BasePath..sound, "master");
end



-- function PlaySoundDelayed()
--     soundDelay = GetTime()
--     repeat until( GetTime() - soundDelay >= awaitCorrectSoundDuration )

--     PlaySoundFile(lootSound, "master");
--     lootSound = "";
-- end


local lootFrame = CreateFrame("frame");
lootFrame:RegisterEvent("Loot_Ready");
lootFrame:SetScript("OnEvent", PlayLootSound);

local rollFrame = CreateFrame("frame");
rollFrame:RegisterEvent("START_LOOT_ROLL");
rollFrame:SetScript("OnEvent", function(self, event, id)
    PlayRollSound(id)
end);

-- local soundFrame = CreateFrame("frame");
-- soundFrame:RegisterEvent("Loot_Ready");
-- soundFrame:RegisterEvent("START_LOOT_ROLL");
-- soundFrame:SetScript("OnEvent", PlaySoundDelayed);



local eventFilter = CreateFrame("frame");
-- Add events from EventRules
for i = 1, #EventRules do
    eventFilter:RegisterEvent(EventRules[i][2]);
end
eventFilter:SetScript("OnEvent", function(self, event) PlayEventSound(event) end);

-- local interfaceLoader = CreateFrame("Frame")
-- interfaceLoader:RegisterEvent("ADDON_LOADED")
-- interfaceLoader:SetScript("OnEvent", InitializeOptions)

-- function interfaceLoader:InitializeOptions()
--     self.panel = CreateFrame("Frame")
--     self.panel.name = "ItemLootSounds"


--     InterfaceOptions_AddCategory(self.panel)
-- end