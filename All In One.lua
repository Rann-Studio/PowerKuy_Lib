function add_magplant(t)
    local position = t[1] or t.position or os.exit()
    local offset = t[2] or t.offset or nil

    local magplant_x
    local magplant_y

    if (position == "top") then
        magplant_x = (GetLocal().posX // 32)
        magplant_y = ((GetLocal().posY // 32) + 1) + ((offset ~= nil) and offset or 0)
        
    elseif (position == "bottom") then
        magplant_x = (GetLocal().posX // 32)
        magplant_y = ((GetLocal().posY // 32) - 1) + ((offset ~= nil) and offset or 0)
        
    elseif (position == "left") then
        magplant_y = ((GetLocal().posX // 32) - 1) + ((offset ~= nil) and offset or 0)
        magplant_x = (GetLocal().posY // 32)
        
    elseif (position == "right") then
        magplant_y = ((GetLocal().posX // 32) + 1) + ((offset ~= nil) and offset or 0)
        magplant_x = (GetLocal().posY // 32)
    
    end

    SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. magplant_x .. "|\ny|" .. magplant_y .."|\nbuttonClicked|additems\n")
end



function retrieve_magplant(t)
    local position = t[1] or t.position or os.exit()
    local offset = t[2] or t.offset or nil

    local magplant_x
    local magplant_y

    if (position == "top") then
        magplant_x = (GetLocal().posX // 32)
        magplant_y = ((GetLocal().posY // 32) + 1) + ((offset ~= nil) and offset or 0)
        
    elseif (position == "bottom") then
        magplant_x = (GetLocal().posX // 32)
        magplant_y = ((GetLocal().posY // 32) - 1) + ((offset ~= nil) and offset or 0)
        
    elseif (position == "left") then
        magplant_y = ((GetLocal().posX // 32) - 1) + ((offset ~= nil) and offset or 0)
        magplant_x = (GetLocal().posY // 32)
        
    elseif (position == "right") then
        magplant_y = ((GetLocal().posX // 32) + 1) + ((offset ~= nil) and offset or 0)
        magplant_x = (GetLocal().posY // 32)
    
    end

    SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. magplant_x .. "|\ny|" .. magplant_y .."|\nbuttonClicked|withdraw\n")
end



function find_item(t)
    local item_id = t[1] or t.item_id or os.exit()

    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. item_id .. "|1\n")
end



function recycle_item(t)
    local item_id = t[1] or t.item_id or os.exit()
    local amount = t[2] or t.amount or os.exit()

    SendPacket(2, "action|dialog_return\ndialog_name|trash\nitem_trash|".. item_id .. "|\nitem_count|"..amount.."\n")
end



function recycle_all_item()
    for k, v in pairs(GetInventory()) do
        SendPacket(2, "action|dialog_return\ndialog_name|trash\nitem_trash|".. v.id .. "|\nitem_count|"..v.amount.."\n") 
    end
end



function drop_item(t)
    local item_id = t[1] or t.item_id or os.exit()
    local amount = t[2] or t.amount or os.exit()

    SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|".. item_id .. "|\nitem_count|"..amount.."\n")
end



function drop_all_item()
    for k, v in pairs(GetInventory()) do
        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|".. v.id .. "|\nitem_count|"..v.amount.."\n") 
    end
end



function show_notification(t)
    local icon = t[1] or t.icon or "interface/large/adventure.rttex"
    local message = t[2] or t.message or "Hello Growtopians"
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
