require("config")

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
            if itemInfo.quality < bestQuality then
                bestQuality = itemInfo.quality;
            end
            
            for rule=1, #Item do
                for item=1, #Item[2] do
                    if itemInfo.item == Item[rule][2][item] then
                        bestRule = rule;
                    end
                end
            end
        end


        if bestRule == 0 then
            bestSound = Quality[bestQuality];
        else
            bestSound = Item[bestRule][1];
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


