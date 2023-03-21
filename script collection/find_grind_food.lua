-- Script by : Rann#6485
-- Do not trade this script!
-- More information? read wiki!
-- https://github.com/Rann-Studio/PowerKuy_Lib/wiki

local grindPos = "top"
local grindOffset = 1
local itemID = 880
local amountGrind = 5


function find_item(t)
    local item_id = t[1] or t.item_id or exit_message{message = "item id is not defined"}

    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. item_id .. "|1\n")
end


function grind_food(t)
    local position = t[1] or t.position or exit_message{message = "position is not defined"}
    local offset = t[2] or t.offset or nil
    local item_id = t[3] or t.item_id or exit_message{message = "item id is not defined"}
    local amount = t[4] or t.amount or exit_message{message = "amount id is not defined"}

    local grinder_x
    local grinder_y

    if (position == "top") then
        grinder_x = (GetLocal().posX // 32)
        grinder_y = ((GetLocal().posY // 32) - 1) - ((offset ~= nil) and offset or 0)
        
    elseif (position == "bottom") then
        grinder_x = (GetLocal().posX // 32)
        grinder_y = ((GetLocal().posY // 32) + 1) + ((offset ~= nil) and offset or 0)
        
    elseif (position == "left") then
        grinder_x = ((GetLocal().posX // 32) - 1) - ((offset ~= nil) and offset or 0)
        grinder_y = (GetLocal().posY // 32)
        
    elseif (position == "right") then
        grinder_x = ((GetLocal().posX // 32) + 1) + ((offset ~= nil) and offset or 0)
        grinder_y = (GetLocal().posY // 32)
    
    end
    
    SendPacket(2, "action|dialog_return\ndialog_name|grinder\nx|".. grinder_x .. "|\ny|"..grinder_y.."|\nitemID|"..item_id.."|\namount|"..amount.."\n")
end


function exit_message(t)
    local message = t[1] or t.message or "Thanks for using this library"
    LogToConsole(message)
    return false
end


while true do
  find_item{item_id = itemID}
  Sleep(300)

  grind_food{position = grindPos, offset = grindOffset, item_id = itemID, amount = amountGrind}
  Sleep(1000)
end
