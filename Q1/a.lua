-- Assuming all functions are required and the interface is inflexible, with
-- no other context, I would just format the code, inline the body of
-- releaseStorage in onLogout

---@param player Player
local function releaseStorage(player)
	player:setStorageValue(1000, -1)
end

---@param player Player
---@return boolean
function onLogout(player)
	if player:getStorageValue(1000) == 1 then
		player:setStorageValue(1000, -1)
	end
	return true
end
