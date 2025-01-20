local function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {} ; i = 1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- Server-side event for broadcasting alerts
RegisterServerEvent("alert:sv")
AddEventHandler("alert:sv", function(msg, msg2)
    TriggerClientEvent("SendAlert", -1, msg, msg2)
end)

AddEventHandler('chatMessage', function(source, name, msg)
    local command = stringsplit(msg, " ")[1]

    if command == "/alert" then
        local src = source

        -- Fetch PlayerData correctly
        local Player = exports.qbx_core:GetPlayer(src)

        if Player and Player.PlayerData and Player.PlayerData.job then
            local job = Player.PlayerData.job.name
            local grade = Player.PlayerData.job.grade.level

            -- Check job and rank
            if job == Config.Job and grade >= Config.MinimumRank then
                CancelEvent() 
                TriggerClientEvent("alert:Send", source, string.sub(msg, 8), Config.TitleDepartment)
            end
        end
    end
end)

-- © Fuza Development