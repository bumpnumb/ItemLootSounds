-- Time delay
local delay = 0
local DEBOUNCE_INTERVAL = 0.3



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


local panel = CreateFrame("Frame")
panel.name = "--------ItemLootSounds"
InterfaceOptions_AddCategory(panel)

-- Create the scrolling parent frame and size it to fit inside the texture
local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 3, -4)
scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

-- Create the scrolling child frame, set its width to fit, and give it an arbitrary minimum height (such as 1)
local scrollChild = CreateFrame("Frame")
scrollFrame:SetScrollChild(scrollChild)
scrollChild:SetWidth(InterfaceOptionsFramePanelContainer:GetWidth()-18)
scrollChild:SetHeight(1);

-- -- Add widgets to the scrolling child frame as desired
-- local title = scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
-- title:SetPoint("TOPLEFT")
-- title:SetText("Rule")

local eb = CreateFrame("EditBox", nil, scrollFrame);
eb:SetWidth(300);
eb:SetHeight(40);
eb:SetText("Anus");
eb:SetMultiLine(false);
eb:SetAutoFocus(false);
scrollFrame:SetScrollChild(eb);
-- editbox:SetScipt("OnEnterPressed", function(self)
-- 	self:ClearFocus();
--     message(self.GetText());
-- end)



-- local footer = scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
-- footer:SetPoint("TOP", 0, -5000)
-- footer:SetText("This is 5000 below the top, so the scrollChild automatically expanded.")