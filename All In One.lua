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



function break_item(t)
    local x = t[1] or t.x or exit_message{message="x coordinate is not defined"}
    local y = t[1] or t.y or exit_message{message="y coordinate is not defined"}

    pkt = {}
    pkt.px = x;
    pkt.py = y;
    pkt.x = x * 32;
    pkt.y = (y - 1) * 32;
    pkt.type = 3;
    pkt.value = 18;
    SendPacketRaw(false, pkt);
    Sleep(200)
    clear_island()
end



function clear_island()
    for y = 0, 193 do
        for x = 0, 199 do
            if y % 2 == 0 then
                local tile = GetTile(x, y)
                if (tile.fg == 12988) or (tile.fg == 12986) or (tile.bg == 14 and tile.fg ~= 8) or (tile.fg == 1104) or (tile.bg == 1102) then
                    if (FindPath(tile.x, tile.y - 1) == false) then
                        break_item{ x= tile.x, y = tile.y}
                        break
                    end
                end
            else
                local tile = GetTile(199 - x, y)
                if (tile.fg == 12988) or (tile.fg == 12986) or (tile.bg == 14  and tile.fg ~= 8) or (tile.fg == 1104) or (tile.bg == 1102) then
                    if (FindPath(tile.x, tile.y - 1) == false) then
                        break_item{x= tile.x, y = tile.y}
                        break
                    end
                end
            end
        end
    end
end



function find_item(t)
    local item_id = t[1] or t.item_id or exit_message{message = "item id is not defined"}

    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. item_id .. "|1\n")
end



function recycle_item(t)
    local item_id = t[1] or t.item_id or exit_message{message = "item id is not defined"}
    local amount = t[2] or t.amount or exit_message{message = "amount is not defined"}

    SendPacket(2, "action|dialog_return\ndialog_name|trash\nitem_trash|".. item_id .. "|\nitem_count|"..amount.."\n")
end



function recycle_all_item()
    for k, v in pairs(GetInventory()) do
        SendPacket(2, "action|dialog_return\ndialog_name|trash\nitem_trash|".. v.id .. "|\nitem_count|"..v.amount.."\n")
        Sleep(300)
    end
end



function drop_item(t)
    local item_id = t[1] or t.item_id or exit_message{message = "item id is not defined"}
    local amount = t[2] or t.amount or exit_message{message = "amount is not defined"}

    SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|".. item_id .. "|\nitem_count|"..amount.."\n")
end



function drop_all_item()
    for k, v in pairs(GetInventory()) do
        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|".. v.id .. "|\nitem_count|"..v.amount.."\n")
        Sleep(300)
    end
end



function show_notification(t)
    local icon = t[1] or t.icon or "interface/large/adventure.rttex"
    local message = t[2] or t.message or  exit_message{message = "message is not defined"}
    local sound = t[3] or t.sound or "audio/gong.wav"

    local notification = {
        v0 = "OnAddNotification",
        v1 = icon,
        v2 = message,
        v3 = sound,
        v4 = 0
    }
    SendVariant(notification)
end



function exit_message(t)
    local message = t[1] or t.message or "Thanks for using this library"
    LogToConsole(message)
    return false
end
