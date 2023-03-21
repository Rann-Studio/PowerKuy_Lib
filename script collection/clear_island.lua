-- Script by : Rann#6485
-- Do not trade this script!


function break_item(t)
    local x = t[1] or t.x or exit_message{message="x coordinate is not defined"}
    local y = t[2] or t.y or exit_message{message="y coordinate is not defined"}

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


function exit_message(t)
    local message = t[1] or t.message or "Thanks for using this library"
    LogToConsole(message)
    return false
end


clear_island()
