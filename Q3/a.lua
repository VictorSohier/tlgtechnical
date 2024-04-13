-- Format, format, format
--
-- Keep consistent with function name casing, I don't care what it is, so long
-- as it is internally consistent and consistent across the codebase
--
-- Use full words unless it is a well known shorthand. "sth" is not well known
-- shorthand.
--
-- Be more descriptive than just "Something"
--
-- Type annotations are beautiful, they prevent you from doing stupid things
--
-- The playerId should be typed by way of whatever the type is of the ID of the
-- player object. I picked integer just because integers are common. I prefer
-- using the names of functions to describe what it is doing than doc comments.
-- Doc comments usually go stale and aren't maintained unless it is the
-- interface to a library. Same with tests.
--
-- Underscore for unused variables better communicates the intention that the
-- value is unused.

---@param playerId integer
---@param membername string
function removePlayerByNameFromPartyByPlayerWithId(playerId, membername)
	player = Player:getFromId(playerId)
	local party = player:getParty()
	for _,v in pairs(party:getMembers()) do
		if v == player.membername then
			-- getPlayerByName is just a hypothetical function, if I had more
			-- context, I'd be able to write it
			party:removeMember(getPlayerByName(membername).id)
		end
	end
end
