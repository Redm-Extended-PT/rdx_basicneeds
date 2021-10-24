RDX  = nil

Citizen.CreateThread(function()
	while RDX == nil do
		TriggerEvent('rdx:getSharedObject', function(obj) rdx = obj end)
		Citizen.Wait(1000)
	end
end)

local IsDead = false
local IsAnimated = false

AddEventHandler('rdx_basicneeds:resetStatus', function()
	TriggerEvent('rdx_status:set', 'hunger', 500000)
	TriggerEvent('rdx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('rdx_basicneeds:healPlayer')
AddEventHandler('rdx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('rdx_status:set', 'hunger', 1000000)
	TriggerEvent('rdx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('rdx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('rdx:onPlayerSpawn', function(spawn)
	if IsDead then
		TriggerEvent('rdx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('rdx_status:loaded', function(status)

	TriggerEvent('rdx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('rdx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
		status.remove(75)
	end)

end)

AddEventHandler('rdx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('rdx_basicneeds:onEat')
AddEventHandler('rdx_basicneeds:onEat', function(prop_name)
local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

			
            TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_EAT_APPLE'), -1, true, false, false, false)
            Citizen.Wait(5000)
            ClearPedTasksImmediately(PlayerPedId())
			ClearPedSecondaryTask(PlayerPedId())
end)

RegisterNetEvent('rdx_basicneeds:onDrink')
AddEventHandler('rdx_basicneeds:onDrink', function(prop_name)
	local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

			
            TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_DRINK_FLASK'), -1, true, false, false, false)
            Citizen.Wait(5000)
            ClearPedTasksImmediately(PlayerPedId())
			ClearPedSecondaryTask(PlayerPedId())
end)
