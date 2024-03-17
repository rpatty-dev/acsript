function UpdateGasState()
    local player = getGameData('players.player')
    if player ~= nil then
        player.data.gas = 1
    end
end

function onUpdate(delta)
    UpdateGasState()
end
