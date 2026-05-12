supplyLimit("Fighter", 300);

supplyLimit("Scout", 300);
supplyLimit("Interceptor", 300);
supplyLimit("Bomber", 300);
supplyLimit("LanceFighter", 300);
supplyLimit("Defenders", 50);
supplyLimit("Defensefighters", 50);
supplyLimit("CloakedFighters", 50);
--
-- Vaygr FamilyOverride Fighter 205
-- Vaygr ShipOverride Interceptor 175
-- Vaygr ShipOverride Bomber 175
--
supplyLimit("Corvette", 150);

supplyLimit("MinelayerCorvette", 15);
supplyLimit("CommandCorvette", 10);
supplyLimit("SalvageCorvette", 45);
--
-- Vaygr FamilyOverride Corvette 100
--
supplyLimit("Frigate", 100);

supplyLimit("DefenseFieldFrigate", 10);
supplyLimit("CaptureFrigate", 20);
--
supplyLimit("Capital", 50);

supplyLimit("Destroyer", 15);
supplyLimit("MissileDestroyer", 10);
supplyLimit("Carrier", 10);
supplyLimit("Battlecruiser", 15);
supplyLimit("HeavyCruiser", 15);
supplyLimit("Shipyard", 2);
--
supplyLimit("Utility", 100);

supplyLimit("Probe", 25);
supplyLimit("ECMProbe", 25);
supplyLimit("ProximitySensor", 25);
--
supplyLimit("Resource", 60);

supplyLimit("ResourceCollector", 45);
supplyLimit("ResourceController", 10);
--
supplyLimit("NonCombat", 100);

supplyLimit("Probe_hw1", 25);
supplyLimit("ProximitySensor_hw1", 25);
supplyLimit("Research", 5);
supplyLimit("Research1", 5);
supplyLimit("Research2", 5);
supplyLimit("Research3", 5);
supplyLimit("Research4", 5);
supplyLimit("Research5", 5);
supplyLimit("CloakGenerator", 10);
supplyLimit("GravWellGenerator", 10);
supplyLimit("SensorArray", 10);
--
supplyLimit("Platform", 50);

supplyLimit("HyperspacePlatform", 15);
--
supplyLimit("Mothership", 2);
--
supplyLimit("SinglePlayerMisc", 100);



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
supplyLimit("Cruiser", 75)
supplyLimit("AdvancedCruiser", 20)
supplyLimit("Destroyer", 10)
supplyLimit("Deimos", 20)
supplyLimit("Hades", 4)
supplyLimit("Colossus", 2)
supplyLimit("Installation", 4)
supplyLimit("Iceni", 2)
supplyLimit("Ares", 40)
supplyLimit("Erinyes", 30)
supplyLimit("ArtemisDH", 40)
supplyLimit("AWACS", 10)
supplyLimit("Faustus", 4)
supplyLimit("Moloch", 15)
supplyLimit("Sobek", 15)
supplyLimit("Aeolus", 15)
supplyLimit("Rakshasa", 15)
supplyLimit("Lucifer", 2)
supplyLimit("Sathanas", 2)
supplyLimit("Imhotep", 4)

-- Show Freespace families
supplyShow("Cruiser", "Always")
supplyShow("AdvancedCruiser", "Always")
supplyShow("Installation", "Always")
supplyShow("Aeolus", "Always")
supplyShow("Erinyes", "Always")
supplyShow("Rakshasa", "Always")

-- Layout Limits (Global Faction Caps)
supplyLimit("LayoutFighter", 180)
supplyLimit("LayoutCorvette", 180)
supplyLimit("LayoutFrigate", 180)
supplyLimit("LayoutDestroyer", 180)
supplyLimit("LayoutBattleCruiser", 180)
supplyLimit("LayoutResource", 180)
supplyLimit("LayoutBomber", 180)
supplyLimit("LayoutCruiser", 180)

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
