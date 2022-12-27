local QBCore = exports["qb-core"]:GetCoreObject()
local Webhook = "" -- Add your webhook here to see who is kicked for not accepting the rules

function KickPlayer()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    if Player.PlayerData.metadata["acceptrules"] == false then
        local embedData = {
            {
                ["title"] = "Player Kicked",
                ["type"] = "rich",
                ["color"] = 16711680,
                ["description"] = "**Player Name:** " ..
                    PlayerName .. "\n**Player ID:** " .. src .. "\n**Reason:** Failed to Accept the Rules",
                ["footer"] = {
                    ["text"] = "Player Kicked"
                }
            }
        }
        PerformHttpRequest(
            Webhook,
            function()
            end,
            "POST",
            json.encode({username = "Mones-Bot", embeds = embedData}),
            {["Content-Type"] = "application/json"}
        )
        DropPlayer(src, "Failed to Accept the Rules")
        print("Kicked" .. " Kicked " .. PlayerName .. " " .. src)
    end
end

RegisterNetEvent(
    "mones-border:server:checking",
    function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local PlayerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname

        if Player.PlayerData.metadata["acceptrules"] == false then
            TriggerClientEvent("mones-checkfail:client:teleportbacktoaccept", src)
            TriggerClientEvent("mones-checktarget:client:target", src)
            TriggerClientEvent("QBCore:Notify", source, "Talk to the Border Guard to accept the rules", "error")
            TriggerClientEvent(
                "QBCore:Notify",
                source,
                "You have not accepted the rules yet, please do so before continuing",
                "error"
            )

            local random = math.random(1, 10)
            if random == 1 then
                KickPlayer()
            end
        else
            TriggerClientEvent("mones-check:client:polyzedestory", src)
            TriggerClientEvent("mones-check:client:pedzone", src)
            print("Checked" .. " Approved " .. PlayerName .. " " .. src)
        end
    end
)

RegisterNetEvent(
    "mones-accpeted:server:rulesaccepted",
    function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local PlayerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname

        Player.Functions.SetMetaData("acceptrules", true)
    end
)

if Config.AdminPerms then
    print("Admin Perms Enabled")
    QBCore.Commands.Add(
        "acceptedrules",
        "Admin - Skip the Test Quiz",
        {},
        false,
        function(source, args)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local PlayerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname

            Player.Functions.SetMetaData("acceptrules", true)
            print("Border |" .. " Used Admin Command " .. PlayerName .. " " .. src)
        end,
        "admin"
    )
end

AddEventHandler(
    "onResourceStart",
    function(resource)
        if resource == GetCurrentResourceName() then
            print("^3 Serrulata-Studios - Border Control Has Loaded ^7")
        end
    end
)
