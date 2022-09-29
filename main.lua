require("config");

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


