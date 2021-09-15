local stringstarts = tw.func.stringstarts

Hook.Add("chatMessage", "vam_CommandHook", function(message, client)
    message = message:lower()
    if stringstarts(message,"/killme") then
        if vam.config.allowSuicideCommand == true and client.Character.IsDead == false then
            client.Character.Kill(CauseOfDeathType.Unknown)
            Game.Log(tostring(client.Character.Name) .. " (" .. tostring(client.Name) .. ") committed suicide", 7)
        else
            Game.SendDirectChatMessage(vam.config.servermessageprefix, vam.config.disabledCommandText, nil, 7, client)
        end
        return true
    elseif stringstarts(message,"/spawnas ") then
        if vam.config.allowSpawnAsCommand then
            if client.Character.IsDead == true then
                local targetSpecies = message:sub(9,#message)
                for index, value in pairs(vam.config.spawnAsWhitelist) do
                    if targetSpecies == value then
                        local newCharacter = Character.Create(targetSpecies)
                        client.SetClientCharacter(newCharacter)
                        Game.Log(tostring(client.Name) .. " spawned as a " .. targetSpecies, 7)
                        break
                    end
                end
            else
                Game.SendDirectChatMessage(vam.config.servermessageprefix, vam.config.failedCommandAlive, nil, 7, client)
            end
        else
            Game.SendDirectChatMessage(vam.config.servermessageprefix, vam.config.disabledCommandText, nil, 7, client)
        end
    end
end)