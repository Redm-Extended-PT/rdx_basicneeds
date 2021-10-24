RDX = nill

TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)

RDX.RegisterUsableItem('bread', function(source)
	local xPlayer = RDX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('rdx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('rdx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_bread'))
end)

RDX.RegisterUsableItem('water', function(source)
	local xPlayer = RDX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('rdx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('rdx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_water'))
end)

RDX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('rdx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
