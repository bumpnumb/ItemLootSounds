-- Time delay
local delay = 0
local DEBOUNCE_INTERVAL = 0.3
local open = io.open

local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local fileContent = read_file("Interface\\Addons\\ItemFilter\\config.txt");
message(fileContent);

function ItemFilter()
    if GetTime() - delay >= DEBOUNCE_INTERVAL then
        delay = GetTime()


        info = GetLootInfo();

        -- local n = GetNumLootItem()
        -- message(tostring(n))

        local itemText;
        local frostWeave = false;
        
        for i = 1, #info do
            local itemInfo = info[i];

            if itemInfo.item == "Frostweave Cloth" then
                frostWeave = true;
            end


            if itemText == nil then
                itemText = itemInfo.item;
            else
                itemText = itemText..itemInfo.item;
            end

        end

        if frostWeave == true then
            PlaySoundFile("Interface\\Addons\\ItemFilter\\Sounds\\nyalong.mp3");
        else
            PlaySoundFile("Interface\\Addons\\ItemFilter\\Sounds\\pinnes.mp3");
        end
    end

    -- message(itemText);
end



local itemFilter = CreateFrame("frame")
itemFilter:RegisterEvent("Loot_Ready")
itemFilter:SetScript("OnEvent", ItemFilter)


