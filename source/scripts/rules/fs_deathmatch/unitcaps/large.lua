supplyLimit("Fighter", 200);

supplyLimit("Scout", 150);
supplyLimit("Interceptor", 200);
supplyLimit("Bomber", 150);
supplyLimit("LanceFighter", 200);
supplyLimit("Defenders", 40);
supplyLimit("Defensefighters", 40);
supplyLimit("CloakedFighters", 40);
--
-- Vaygr FamilyOverride Fighter 170
-- Vaygr ShipOverride Interceptor 140
-- Vaygr ShipOverride Bomber 140
--
supplyLimit("Corvette", 60);

supplyLimit("MinelayerCorvette",12);
supplyLimit("CommandCorvette",8);
supplyLimit("SalvageCorvette",30);
--
-- Vaygr FamilyOverride Corvette 80
--
supplyLimit("Frigate", 50);

supplyLimit("DefenseFieldFrigate",6);
supplyLimit("CaptureFrigate",15);		
--
-- Kushan FamilyOverride Frigate 24
-- Taiidan FamilyOverride Frigate 24	
--
supplyLimit("Capital", 20);
	
supplyLimit("Destroyer", 5);
supplyLimit("MissileDestroyer", 4);
supplyLimit("Carrier", 4);
supplyLimit("Battlecruiser",5);
supplyLimit("HeavyCruiser",5);
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
supplyLimit("Destroyer", 5)
supplyLimit("Deimos", 10)
supplyLimit("Hades", 2)
supplyLimit("Colossus", 1)
supplyLimit("Installation", 2)
supplyLimit("Iceni", 1)
supplyLimit("Ares", 25)
supplyLimit("ArtemisDH", 25)
supplyLimit("AWACS", 5)
supplyLimit("Faustus", 2)
supplyLimit("Moloch", 10)
supplyLimit("Sobek", 10)
supplyLimit("Lucifer", 1)
supplyLimit("Sathanas", 1)
supplyLimit("Imhotep", 2)

-- Show Freespace families
supplyShow("Cruiser", "Always")
supplyShow("AdvancedCruiser", "Always")
supplyShow("Installation", "Always")

-- Indents
supplyIndent("Cruiser", 1)
supplyIndent("AdvancedCruiser", 1)
supplyIndent("Ares", 1)
supplyIndent("ArtemisDH", 1)
supplyIndent("AWACS", 1)
supplyIndent("Faustus", 1)
supplyIndent("Hades", 1)
supplyIndent("Deimos", 1)
supplyIndent("Colossus", 1)
supplyIndent("Installation", 1)
supplyIndent("Iceni", 1)
supplyIndent("Moloch", 1)
supplyIndent("Sobek", 1)
supplyIndent("Lucifer", 1)
supplyIndent("Sathanas", 1)
supplyIndent("Imhotep", 1)
