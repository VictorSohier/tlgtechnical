-- Step 1: Format. Poorly formatted code is always a pain to read. Personally,
-- I stick to an 80 column limit and 4 space tabulator to keep things legible
--
-- Fix the name of resultId to just result. I presume that is what it was meant
-- to be
--
-- I'm not entirely familiar with the database API, but I'm pretty sure that
-- there is almost certainly some connection state. I'd rather have that state
-- be parameterized. A function should never have state that isn't
-- parameterized in my opinion. This also indicates that this function performs
-- database access
--
-- result is supposedly some state and therefore should be access as though it
-- is.
--
-- Personally wouldn't leave the comment there, but in this case, the function
-- is a bit nebulous since it touches the database. Not everyone who uses lua
-- knows SQL. I'd move the comment to a doc header and provide types so your
-- editor yells at you for putting a string in memberCount. That would be
-- dangerous.
--
-- Also, there was nothing treating the result as though it may have multiple
-- records, I added a hypothetical loop that would get the records. Again,
-- I'm only speculating at the database interface
--
-- Given the database access, I'd actually put the database access into a typed
-- language (i.e. C/C++) to at least mitigate the potential for SQL injection,
-- accidental by way of the developer or intentional by way of the player.

---this method is supposed to print names of all guilds that have less than
---memberCount max members
---@param db DatabaseConnection
---@param memberCount integer
function printSmallGuildNames(db, memberCount)
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local result = db:storeQuery(
		string.format(selectGuildQuery, memberCount)
	)
	local resultCount = result:rows();
	for i=1, resultCount do
		local guildName = result:getRow(i):getString("name")
		print(guildName)
	end
end
