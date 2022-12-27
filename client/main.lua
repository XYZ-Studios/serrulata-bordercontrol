local PedModel = {
    "mp_m_securoguard_01"
}

-- Functions --
function FuckMePed()
    RequestModel(GetHashKey(PedModel[1]))
    while not HasModelLoaded(GetHashKey(PedModel[1])) do
        Wait(1)
    end

    local ped =
        CreatePed(
        4,
        GetHashKey(PedModel[1]),
        Config.PedCoords.x,
        Config.PedCoords.y,
        Config.PedCoords.z,
        Config.PedCoords.w,
        false,
        true
    )

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanRagdoll(ped, false)
    SetPedCanPlayAmbientAnims(ped, false)
    SetPedCanPlayAmbientBaseAnims(ped, false)
    SetPedCanPlayGestureAnims(ped, false)
    SetPedCanPlayVisemeAnims(ped, false, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)

    if Config.Target == "ox_target" then
        local model = PedModel

        local options = {
            {
                name = "control",
                event = "serrulata-welcomeplace:client:talktotheguard",
                icon = "fas fa-user",
                label = "Talk to the guard",
                canInteract = function(entity, distance, coords, name, bone)
                    return distance < 2.0
                end
            }
        }
        exports.ox_target:addModel(model, options)
    elseif Config.Target == "qb-menu" then
        print("You need to do this yourself, sorry.")
    end

    local PedZone =
        BoxZone:Create(
        vector3(Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z),
        2.0,
        2.0,
        {
            name = "PedZone",
            heading = 0,
            debugPoly = Config.DebugPoly,
            minZ = 14.83,
            maxZ = 21.00
        }
    )

    PedZone:onPlayerInOut(
        function(isPointInside, point)
            if isPointInside then
                lib.notify(
                    {
                        title = "Hint",
                        description = "Use [L-CTRL] to talk to the guard",
                        type = "inform"
                    }
                )
            end
        end
    )

    RegisterNetEvent(
        "mones-check:client:pedzone",
        function()
            PedZone:destroy()
        end
    )
end

function PolyDoMeHard()
    local CockZone = {}

    for k, v in pairs(Config.WelcomeZones) do
        if v.box then -- BoxZone
            CockZone[#CockZone + 1] =
                BoxZone:Create(
                v.coords,
                v.length,
                v.width,
                {
                    name = "Zone" .. k,
                    minZ = v.minZ,
                    maxZ = v.maxZ,
                    debugPoly = DebugPoly
                }
            )
        else
            CockZone[#CockZone + 1] =
                PolyZone:Create(
                v.points,
                {
                    name = "Zone" .. k,
                    minZ = v.minZ,
                    maxZ = v.maxZ,
                    debugGrid = DebugPoly
                }
            )
        end
    end

    local WelcomeCum =
        ComboZone:Create(
        CockZone,
        {
            name = "ZoneCombo",
            debugPoly = true
        }
    )

    WelcomeCum:onPlayerInOut(
        function(isPointInside, point, zone)
            if isPointInside then
                return
            else
                TriggerServerEvent("mones-border:server:checking")
                print("Sending to Server")
            end
        end
    )

    RegisterNetEvent(
        "mones-check:client:polyzedestory",
        function()
            WelcomeCum:destroy()
        end
    )
end
-- Events --
RegisterNetEvent(
    "mones-checkfail:client:teleportbacktoaccept",
    function()
        local ped = cache.ped
        DoScreenFadeOut(1000)
        Wait(1000)
        SetEntityCoords(ped, -498.13, -690.8, 20.03, 240.45, 0.0, 0.0, false)
        DoScreenFadeIn(1000)
    end
)

RegisterNetEvent(
    "serrulata-welcomeplace:client:talktotheguard",
    function()
        if Config.Menu == "qb-menu" then -- TODO
            print("qb-menu")
        elseif Config.Menu == "keep-menu" then
            exports["keep-menu"]:createMenu(
                {
                    {
                        header = "Welcome to Los Santos Border Control",
                        icon = "fas fa-city",
                        disabled = true
                    },
                    {
                        header = "Check Papers",
                        subheader = "Check your papers",
                        icon = "fas fa-id-card",
                        event = "serrulata-welcomeplace:client:rules",
                        submenu = true
                    }
                }
            )
        end
    end
)
RegisterNetEvent(
    "serrulata-welcomeplace:client:rules",
    function()
        local questions = Config.Questions

        exports["bcs_questionare"]:openQuiz(
            {
                title = "Server Rules",
                image = "SIM",
                description = "Please read the rules and do a test to continue",
                minimum = Config.Minimum,
                shuffle = true
            },
            questions,
            function(correct, questions)
                TriggerEvent("QBCore:Notify", "You have accepted the rules", "success", 5000)
                TriggerServerEvent("mones-accpeted:server:rulesaccepted")
                TriggerEvent("mones-check:client:pedzone")
            end,
            function(correct, questions)
                lib.notify(
                    {
                        title = "Failed to Read the Rules?",
                        type = "error"
                    }
                )
            end
        )
    end
)
-- Threads --
CreateThread(
    function()
        local blip = AddBlipForCoord(Config.WelcomePlace.x, Config.WelcomePlace.y, Config.WelcomePlace.z)
        SetBlipSprite(blip, 590)
        SetBlipDisplay(blip, 6)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Arrival Point")
        EndTextCommandSetBlipName(blip)
    end
)

CreateThread(
    function()
        FuckMePed()
        PolyDoMeHard()
    end
)
-- AddEventHandler --
AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            RemoveBlip(blip)
        end
    end
)
-----------------------------------------------------
-- Mad You actually read this, I'm impressed. --
