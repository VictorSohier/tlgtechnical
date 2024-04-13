-- Loosening the assumptions to where releaseStorage isn't used anywhere,
-- releaseStorage would then not exist as it is a one line function that is an
-- alias for another function with more flexibility. The same effect with
-- default arguments if you didn't want to pass what I presume to be the ID and
-- value. I presume onLogout is required on the basis of being a handler for
-- something in another codebase. (I checked the provided repositories,
-- it doesn't)
--
-- I believe this to be ideal given the assumptions I can make.

---@param player Player
---@return boolean
function onLogout(player)
	if player:getStorageValue(1000) == 1 then
		player:setStorageValue(1000, -1)
	end
	return true
end
