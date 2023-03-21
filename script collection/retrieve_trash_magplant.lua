-- Script by : Rann#6485
-- Do not trade this script!

local itemID = 1656
local magPos = "top"
local magOffset = 1
local amountTrash = 250


function retrieve_magplant(t)
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

    SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. magplant_x .. "|\ny|" .. magplant_y .."|\nbuttonClicked|withdraw\n")
end


function recycle_item(t)
    local item_id = t[1] or t.item_id or exit_message{message = "item id is not defined"}
    local amount = t[2] or t.amount or exit_message{message = "amount is not defined"}

    SendPacket(2, "action|dialog_return\ndialog_name|trash\nitem_trash|".. item_id .. "|\nitem_count|"..amount.."\n")
end


function exit_message(t)
    local message = t[1] or t.message or "Thanks for using this library"
    LogToConsole(message)
    return false
end


while true do
  retrieve_magplant{position = magPos, offset = magOffset}
  Sleep(1000)

  recycle_item{item_id = itemID, amount = amountTrash }
  Sleep(1000)
end
