if Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
        PlayerJob = PlayerData.job
        Wait(2000)
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
        PlayerJob = job
        Wait(500)
    end)

elseif Config.Framework == "qbcore" then
    QBCore = exports['qb-core']:GetCoreObject()

    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
    end)
    
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = {}
    end)
    
end

function showGuidebook()
    local Options = {}

    for _, option in pairs(Config.Guidebook) do
        local shouldAddOption = true

        if Config.Framework == "ESX" then 
            currentJob = ESX.PlayerData.job.name
        elseif Config.Framework == "qbcore" then
            local Player = QBCore.Functions.GetPlayerData()
            currentJob = Player.job.name
        end 

        if Config.Framework == "qbcore" then 
            local Player = QBCore.Functions.GetPlayerData()
            currentGang = Player.gang.name
        end

        if option.job then
            if option.job ~= currentJob then
                shouldAddOption = false
            end
        end

        if option.gang then
            if option.gang ~= currentGang then
                shouldAddOption = false
            end
        end

        if shouldAddOption then
            local newOption = {
                title = option.title,
                image = option.image,
                onSelect = function()
                    lib.alertDialog({
                        header = option.title,
                        content = option.message,
                        centered = true,
                        cancel = false
                    })
                end,
            }

            table.insert(Options, newOption)
        end
    end

    lib.registerContext({
        id = 'guidebookmenu',
        title = "Guide book",
        options = Options,
    })
    lib.showContext('guidebookmenu')
end

RegisterCommand('guidebook', showGuidebook)
