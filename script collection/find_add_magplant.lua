-- Script by : Rann#6485
-- Do not trade this script!
-- More information? read wiki!
-- https://github.com/Rann-Studio/PowerKuy_Lib/wiki

local itemID = 1656
local magPos = "top"
local magOffset = 1


function find_item(t)
    local item_id = t[1] or t.item_id or exit_message{message = "item id is not defined"}

    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. item_id .. "|1\n")
end


function add_magplant(t)
    local position = t[1] or t.position or exit_message{message = "position is not defined"}
    local offset = t[2] or t.offset or nil

    local magplant_x
    local magplant_y

    if (position == "top") then
        magplant_x = (GetLocal().posX // 32)
        magplant_y = ((GetLocal().posY // 32) - 1) - ((offset ~= nil) and offset or 0)
        
    elseif (position == "bottom") then
        magplant_x = (GetLocal().posX // 32)
        magplant_y = ((GetLocal().posY // 32) + 1) + ((offset ~= nil) and offset or 0)
        
    elseif (position == "left") then
        magplant_x = ((GetLocal().posX // 32) - 1) - ((offset ~= nil) and offset or 0)
        magplant_y = (GetLocal().posY // 32)
        
    elseif (position == "right") then
        magplant_x = ((GetLocal().posX // 32) + 1) + ((offset ~= nil) and offset or 0)
        magplant_y = (GetLocal().posY // 32)
    
    end

    SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. magplant_x .. "|\ny|" .. magplant_y .."|\nbuttonClicked|additems\n")
end


function exit_message(t)
    local message = t[1] or t.message or "Thanks for using this library"
    LogToConsole(message)
    return false
end


while true do
    find_item{ item_id = itemID }
    Sleep(1000)
  
    add_magplant{position = magPos, offset = magOffset}
    Sleep(1000)
end
