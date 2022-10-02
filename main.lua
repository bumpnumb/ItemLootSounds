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
    {"fan_va_duktig_du_är.mp3", "PLAYER_LEVEL_UP"},
    
}


-- Sound when rolling for loot
-- RollItemRules overrides RollQualityRules

RollQualityRules = {
    "",
    "",
    "dags_att_förlora_rolls.mp3",
    "dags_att_förlora_rolls.mp3",
    "dags_att_förlora_rolls.mp3",
    "dags_att_förlora_rolls.mp3",
    "dags_att_förlora_rolls.mp3",
    "dags_att_förlora_rolls.mp3",
    "dags_att_förlora_rolls.mp3"
};
RollItemRules = {
    {"", {"Small Dream Shard"}},
};

-- ################################# IGNORE REST #################################


local delay = 0
local DEBOUNCE_INTERVAL = 0.3

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
                for itemName = 1, #LootItemRules[2] do
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

        PlaySoundFile(bestSound, "master")
    end
end


local function PlayRollSound(self, event, id)
    -- delay can be global, lets not spam audio
    if GetTime() - delay >= DEBOUNCE_INTERVAL then
        delay = GetTime()
        local texture, name, count, quality = GetLootRollItemInfo(id);
        quality = quality + 1; -- Quality is 0-indexed

        print("Name: "..name..", Quality: "..tostring(quality)..", EventId: "..tostring(id))

        local bestRule = 0;

        for rule = 1, #RollItemRules do
            for itemName = 1, #RollItemRules[2] do
                if name == RollItemRules[rule][2][itemName] then
                    bestRule = rule;
                end
            end
        end

        local bestSound = BasePath..RollQualityRules[quality]; -- will alyways proc
        if bestRule ~= 0 then
            bestSound = BasePath..RollItemRules[bestRule][1];
        end

        PlaySoundFile(bestSound, "master")
    end
end


local function PlayEventSound(self, event)
    local sound = ""
    for i = 1, #EventRules do
        if (EventRules[i][2] == event) then
            sound = EventRules[i][1]
        end
    end

    PlaySoundFile(BasePath..sound, "master");
end

local lootFrame = CreateFrame("frame");
lootFrame:RegisterEvent("Loot_Ready");
lootFrame:SetScript("OnEvent", PlayLootSound);

local rollFrame = CreateFrame("frame");
rollFrame:RegisterEvent("START_LOOT_ROLL");
rollFrame:SetScript("OnEvent", PlayRollSound);


local eventFilter = CreateFrame("frame");
-- Add events from EventRules
for i = 1, #EventRules do
    eventFilter:RegisterEvent(EventRules[i][2]);
end
eventFilter:SetScript("OnEvent", PlayEventSound);

-- local interfaceLoader = CreateFrame("Frame")
-- interfaceLoader:RegisterEvent("ADDON_LOADED")
-- interfaceLoader:SetScript("OnEvent", InitializeOptions)

-- function interfaceLoader:InitializeOptions()
--     self.panel = CreateFrame("Frame")
--     self.panel.name = "ItemLootSounds"


--     InterfaceOptions_AddCategory(self.panel)
-- end


