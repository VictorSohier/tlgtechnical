-- Assuming all functions are required and the interface is inflexible, with
-- no other context, I would just format the code, inline the body of
-- releaseStorage in onLogout

local function releaseStorage(player)
	player:setStorageValue(1000, -1)
end

function onLogout(player)
	if player:getStorageValue(1000) == 1 then
		player:setStorageValue(1000, -1)
	end
	return true
end
