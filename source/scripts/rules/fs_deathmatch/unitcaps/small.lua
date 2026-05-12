supplyLimit("Fighter", 60);

supplyLimit("Scout", 40);
supplyLimit("Interceptor", 60);
supplyLimit("Bomber", 40);
supplyLimit("LanceFighter", 60);
supplyLimit("Defenders", 10);
supplyLimit("Defensefighters", 10);
supplyLimit("CloakedFighters", 10);
--
-- Vaygr FamilyOverride Fighter 56
-- Vaygr ShipOverride Interceptor 56
-- Vaygr ShipOverride Bomber 56
--
supplyLimit("Corvette", 20);

supplyLimit("MinelayerCorvette",4);
supplyLimit("CommandCorvette",2);
supplyLimit("SalvageCorvette",10);
--
-- Vaygr FamilyOverride Corvette 32
--
supplyLimit("Frigate", 10);

supplyLimit("DefenseFieldFrigate",2);
supplyLimit("CaptureFrigate",4);
--



supplyLimit("Capital", 5);

supplyLimit("Destroyer", 1);
supplyLimit("MissileDestroyer", 1);
supplyLimit("Carrier", 1);
supplyLimit("Battlecruiser",1);
supplyLimit("HeavyCruiser",1);
supplyLimit("Shipyard", 0);
--
supplyLimit("Utility", 20);
supplyLimit("Probe", 6);
supplyLimit("ECMProbe", 6);
supplyLimit("ProximitySensor", 6);
--
supplyLimit("Resource", 15);
supplyLimit("ResourceCollector", 10);
supplyLimit("ResourceController", 2);
--
supplyLimit("NonCombat", 20);
supplyLimit("Probe_hw1", 6);
supplyLimit("ProximitySensor_hw1", 6);
supplyLimit("Research", 1);
supplyLimit("Research1", 1);
supplyLimit("Research2", 1);
supplyLimit("Research3", 1);
supplyLimit("Research4", 1);
supplyLimit("Research5", 1);
supplyLimit("CloakGenerator", 4);
supplyLimit("GravWellGenerator", 4);
supplyLimit("SensorArray", 4);
--
supplyLimit("Platform", 10);
supplyLimit("HyperspacePlatform", 2);
--
supplyLimit("Mothership", 1);
--
supplyLimit("SinglePlayerMisc", 20);



-- Generic Indents
supplyIndent("Scout", 1);
supplyIndent("Interceptor", 1);
supplyIndent("Bomber", 1);

supplyIndent("MinelayerCorvette", 1);

supplyIndent("Destroyer", 1);
supplyIndent("Carrier", 1);


-- Race Specific Indents
supplyIndent("LanceFighter", 1);
supplyIndent("Defenders", 1);
supplyIndent("Defensefighters", 1);
supplyIndent("CloakedFighters", 1);

supplyIndent("CommandCorvette", 1);
supplyIndent("SalvageCorvette", 1);

supplyIndent("DefenseFieldFrigate", 1);
supplyIndent("CaptureFrigate", 1);

supplyIndent("MissileDestroyer", 1);
supplyIndent("Battlecruiser", 1);
supplyIndent("HeavyCruiser", 1);
supplyIndent("Shipyard", 1);

supplyIndent("ResourceCollector", 1);
supplyIndent("ResourceController", 1);

supplyIndent("Probe", 1);
supplyIndent("Probe_hw1", 1);

supplyIndent("ProximitySensor", 1);
supplyIndent("ProximitySensor_hw1", 1);

supplyIndent("CloakGenerator", 1);
supplyIndent("GravWellGenerator", 1);
supplyIndent("ECMProbe", 1);
supplyIndent("SensorArray", 1);

supplyIndent("HyperspacePlatform", 1);


-- Display Rules
supplyShow("Fighter", "Always");
supplyShow("Corvette", "Always");
supplyShow("Frigate", "Always");
supplyShow("Capital", "Always");

supplyShow("Utility", "NotEmpty");
supplyShow("Resource", "NotEmpty");
supplyShow("Platform", "NotEmpty");

supplyShow("Mothership", "Never");
supplyShow("SinglePlayerMisc", "Never");

supplyShow("NonCombat", "NotEmpty");

supplyShow("Research", "Never");
supplyShow("Research1", "Never");
supplyShow("Research2", "Never");
supplyShow("Research3", "Never");
supplyShow("Research4", "Never");
supplyShow("Research5", "Never");



-- Freespace Custom Families
supplyLimit("Cruiser", 10)
supplyLimit("AdvancedCruiser", 2)
supplyLimit("Aeolus", 2)
supplyLimit("Rakshasa", 2)
supplyLimit("Deimos", 2)
supplyLimit("Destroyer", 1)
supplyLimit("Hades", 0)
supplyLimit("Colossus", 0)
supplyLimit("Installation", 1)
supplyLimit("Iceni", 0)
supplyLimit("Ares", 5)
supplyLimit("Erinyes", 4)
supplyLimit("ArtemisDH", 5)
supplyLimit("AWACS", 1)
supplyLimit("Faustus", 1)
supplyLimit("Moloch", 2)
supplyLimit("Sobek", 2)
supplyLimit("Lucifer", 0)
supplyLimit("Sathanas", 0)
supplyLimit("Imhotep", 1)

-- Layout Limits (Global Faction Caps)
supplyLimit("LayoutFighter", 180)
supplyLimit("LayoutCorvette", 180)
supplyLimit("LayoutFrigate", 180)
supplyLimit("LayoutDestroyer", 180)
supplyLimit("LayoutBattleCruiser", 1)
supplyLimit("LayoutResource", 180)
supplyLimit("LayoutBomber", 180)
supplyLimit("LayoutCruiser", 180)

-- Show Freespace families
supplyShow("Cruiser", "Always")
supplyShow("AdvancedCruiser", "Always")
supplyShow("Installation", "Always")
supplyShow("Aeolus", "Always")
supplyShow("Erinyes", "Always")
supplyShow("Rakshasa", "Always")

-- Display Rules (Hide Layout Caps)
supplyShow("LayoutFighter", "Never")
supplyShow("LayoutCorvette", "Never")
supplyShow("LayoutFrigate", "Never")
supplyShow("LayoutDestroyer", "Never")
supplyShow("LayoutBattleCruiser", "Never")
supplyShow("LayoutResource", "Never")
supplyShow("LayoutBomber", "Never")
supplyShow("LayoutCruiser", "Never")

-- Indents
supplyIndent("Cruiser", 1)
supplyIndent("AdvancedCruiser", 1)
supplyIndent("Aeolus", 1)
supplyIndent("Deimos", 1)
supplyIndent("Hades", 1)
supplyIndent("Colossus", 1)
supplyIndent("Installation", 1)
supplyIndent("Iceni", 1)
supplyIndent("Ares", 1)
supplyIndent("Erinyes", 1)
supplyIndent("ArtemisDH", 1)
supplyIndent("AWACS", 1)
supplyIndent("Faustus", 1)
supplyIndent("Moloch", 1)
supplyIndent("Sobek", 1)
supplyIndent("Lucifer", 1)
supplyIndent("Sathanas", 1)
supplyIndent("Imhotep", 1)
supplyIndent("Rakshasa", 1)
