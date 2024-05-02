--===========================================================================
--  Purpose : Lua definition file for homeworld 2.
--            -Hgn Carrier Parade formation
--
--  Copyright Relic Entertainment, Inc.  All rights reserved.
--===========================================================================

-- format   slot-name   vector-offset    vector-heading  vector-direction of growth     size-of-growth (set to 0 if want default)
-- offset determines offset from center of formation
-- heading determines heading, use { 0,0,1 } for forward
-- direction of growth determines how new formations will grow out
-- size of growth determines how spaced out additional formations are.  Set to 0 for default
-- one slot MUST be called "misc", leftovers will get put here

-- right

paradeSlot("Ter_Artemis", { -1045, -2, 875 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Artemisdh", { -1045, -102, 875 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Athena", { -759, 48, 534 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Boanerges", { -618, 98, 184 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Medusa", { -1045, -2, 875 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Ursa", { -1045, -102, 875 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Zeus", { -759, 48, 534 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);

paradeSlot("Ter_Fenris", { 765, 102, -19 }, { 0, 0, 1 }, { 1, 0, 0 }, 0);
paradeSlot("Ter_Leviathan", { 1150, -98, 1181 }, { 0, 0, 1 }, { 1, 0, 0 }, 0);
paradeSlot("Ter_Aeolus", { 928, 2, 581 }, { 0, 0, 1 }, { 1, 0, 0 }, 0);

paradeSlot("Ter_Colossus", { 1156, 100, 1870 }, { 0, 0, 1 }, { 1, 0, 0 }, 0);

-- left
paradeSlot("Ter_Apollo", { -1060, -102, 1629 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Ares", { -716, -52, 1356 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Erinyes", { -447, -2, 1097 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Hercules", { -447, -102, 1097 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_herculesmk2", { -1060, -102, 1629 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Loki", { -716, -52, 1356 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Myrmidon", { -447, -2, 1097 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Pegasus", { -447, -102, 1097 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Perseus", { -1060, -102, 1629 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Ulysses", { -716, -52, 1356 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Valkyrie", { -447, -2, 1097 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);

paradeSlot("Ter_Elysium", { -927, 133, -739 }, { 0, 0, 1 }, { -1, 0, 0 }, 0);
paradeSlot("Ter_Zephyrus", { -927, -86, -939, }, { 0, 0, 1 }, { -1, 0, 0 }, 0);

-- up
paradeSlot("Ter_Alastor", { 65, 0, 704 }, { 0, 0, 1 }, { 0, 1, 0 }, 0);
paradeSlot("Ter_Cerberus", { 65, 0, 704 }, { 0, 0, 1 }, { 0, 1, 0 }, 0);

-- REQUIRED "misc" slot
paradeSlot("misc", { 1254, 350, -1250 }, { 0, 0, 1 }, { 1, 0, 0 }, 0); -- grows right
