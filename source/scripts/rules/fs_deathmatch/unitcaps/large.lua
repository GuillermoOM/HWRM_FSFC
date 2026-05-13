supplyLimit("Fighter", 800);

supplyLimit("Scout", 600);
supplyLimit("Interceptor", 800);
supplyLimit("Bomber", 450);
supplyLimit("LanceFighter", 800);
supplyLimit("Defenders", 160);
supplyLimit("Defensefighters", 160);
supplyLimit("CloakedFighters", 160);
--
-- Vaygr FamilyOverride Fighter 170
-- Vaygr ShipOverride Interceptor 140
-- Vaygr ShipOverride Bomber 140
--
supplyLimit("Corvette", 180);

supplyLimit("MinelayerCorvette", 36);
supplyLimit("CommandCorvette", 24);
supplyLimit("SalvageCorvette", 90);
--
-- Vaygr FamilyOverride Corvette 80
--
supplyLimit("Frigate", 50);

supplyLimit("DefenseFieldFrigate", 6);
supplyLimit("CaptureFrigate", 15);		
--
-- Kushan FamilyOverride Frigate 24
-- Taiidan FamilyOverride Frigate 24	
--
supplyLimit("Capital", 20);
	
supplyLimit("Destroyer", 5);
supplyLimit("MissileDestroyer", 4);
supplyLimit("Carrier", 4);
supplyLimit("Battlecruiser", 5);
supplyLimit("HeavyCruiser", 5);
supplyLimit("Shipyard", 1);
--
supplyLimit("Utility", 60);

supplyLimit("Probe", 18);
supplyLimit("ECMProbe", 18);
supplyLimit("ProximitySensor", 18);
--
supplyLimit("Resource", 45);

supplyLimit("ResourceCollector", 30);
supplyLimit("ResourceController", 6);
--
supplyLimit("NonCombat", 60);

supplyLimit("Probe_hw1", 18);
supplyLimit("ProximitySensor_hw1", 18);
supplyLimit("Research", 1);
supplyLimit("Research1", 1);
supplyLimit("Research2", 1);
supplyLimit("Research3", 1);
supplyLimit("Research4", 1);
supplyLimit("Research5", 1);
supplyLimit("CloakGenerator", 8);
supplyLimit("GravWellGenerator", 8);
supplyLimit("SensorArray", 8);
--
supplyLimit("Platform", 35);

supplyLimit("HyperspacePlatform", 10);
--
supplyLimit("Mothership", 1);
--
supplyLimit("SinglePlayerMisc", 60);




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
supplyLimit("Cruiser", 40)
supplyLimit("AdvancedCruiser", 10)
supplyLimit("Aeolus", 10)
supplyLimit("Rakshasa", 10)
supplyLimit("Deimos", 10)
supplyLimit("Destroyer", 5)
supplyLimit("Hades", 2)
supplyLimit("Colossus", 1)
supplyLimit("Installation", 2)
supplyLimit("Iceni", 1)
supplyLimit("Ares", 100)
supplyLimit("Erinyes", 80)
supplyLimit("ArtemisDH", 75)
supplyLimit("AWACS", 5)
supplyLimit("Faustus", 2)
supplyLimit("Moloch", 10)
supplyLimit("Sobek", 10)
supplyLimit("Lucifer", 1)
supplyLimit("Sathanas", 1)
supplyLimit("Imhotep", 2)

-- Layout Limits (Global Faction Caps)
supplyLimit("LayoutFighter", 720)
supplyLimit("LayoutCorvette", 540)
supplyLimit("LayoutFrigate", 180)
supplyLimit("LayoutDestroyer", 180)
supplyLimit("LayoutBattleCruiser", 5)
supplyLimit("LayoutResource", 180)
supplyLimit("LayoutBomber", 540)
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
