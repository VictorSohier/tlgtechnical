#include <cstdint>
#include <string>

enum AddItemToPlayerState
{
	NONE = 0,
	PLAYER_ALLOCD = 1 << 0,
};

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);
	AddItemToPlayerState state = AddItemToPlayerState::NONE; 
								
	if (!player) {
		// This is definitely _a_ source of allocations, this is _a_ source of
		// _a_ leak.
		player = new Player(nullptr);
		// This could be initialized further up, but the branch exists anyways
		state |= AddItemToPlayerState::PLAYER_ALLOCD;
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			// again, no assumptions of the above function, no guard here
			// because player at this point is definitely allocated by way of
			// line 18. There is no other path to this branch.
			delete player;
			return;
		}
	}
	// Unfortunately, there is no further context about item, however, if
	// Item::CreateItem allocates, item too would have to be freed as it isn't
	// returned nor does it modify an existing pointer. This very well may be
	// managed by an external system though. More context is needed before I
	// act on item.
	Item* item = Item::CreateItem(itemId);
	if (!item) {
		// Condition to avoid double free. If it wasn't created in this
		// function, it is probably managed by an external system
		if (state & AddItemToPlayerState) delete player;
		return;
	}
	g_game.internalAddItem(
		player->getInbox(),
		item,
		INDEX_WHEREEVER,
		FLAG_NOLIMIT
	);
	if (player->isOffline()) {
		// I am making no assumptions about this function, savePlayer can't
		// free player because it has no clue of if player was allocated
		IOLoginData::savePlayer(player);
	}
	if (state & AddItemToPlayerState) delete player;
}
