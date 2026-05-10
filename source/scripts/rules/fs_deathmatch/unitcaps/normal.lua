supplyLimit("Fighter", 70);

supplyLimit("Scout", 18);
supplyLimit("Interceptor", 70);
supplyLimit("Bomber", 70);
supplyLimit("LanceFighter", 70);
supplyLimit("Defenders", 20);
supplyLimit("Defensefighters", 10);
supplyLimit("CloakedFighters", 20);
--
-- Vaygr FamilySupplyOverride Fighter 108
-- Vaygr ShipSupplyOverride Interceptor 108
-- Vaygr ShipSupplyOverride Bomber 108
--
supplyLimit("Corvette", 42);

supplyLimit("MinelayerCorvette",4);
supplyLimit("CommandCorvette",2);
supplyLimit("SalvageCorvette",14);
--
-- Vaygr FamilySupplyOverride Corvette 56
--
supplyLimit("Frigate", 21);

supplyLimit("DefenseFieldFrigate",2);
supplyLimit("CaptureFrigate",6);
--
-- Kushan FamilySupplyOverride Frigate 24
-- Taiidan FamilySupplyOverride Frigate 24		
--
supplyLimit("Capital", 13);

supplyLimit("Destroyer", 6);
supplyLimit("MissileDestroyer", 2);
supplyLimit("Carrier", 4);
supplyLimit("Battlecruiser",2);
supplyLimit("HeavyCruiser",2);
supplyLimit("Shipyard", 1);

--
-- Vaygr FamilySupplyOverride Capital 15
--

supplyLimit("Utility", 44);

supplyLimit("Probe", 6);
supplyLimit("ECMProbe", 6);
supplyLimit("ProximitySensor", 6);

--
supplyLimit("NonCombat", 30);

supplyLimit("Probe_hw1", 6);
supplyLimit("ProximitySensor_hw1", 6);
supplyLimit("CloakGenerator", 4);
supplyLimit("GravWellGenerator", 4);
supplyLimit("SensorArray", 4);

supplyLimit("Research", 1);
supplyLimit("Research1", 1);
supplyLimit("Research2", 1);
supplyLimit("Research3", 1);
supplyLimit("Research4", 1);
supplyLimit("Research5", 1);

--
supplyLimit("Resource", 26);

supplyLimit("ResourceCollector", 22);
supplyLimit("ResourceController", 4);

--
supplyLimit("Platform", 21);

supplyLimit("HyperspacePlatform", 6);
--
supplyLimit("Mothership", 1);
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
supplyLimit("Cruiser", 25)
supplyLimit("AdvancedCruiser", 5)
supplyLimit("Deimos", 5)
supplyLimit("Hades", 1)
supplyLimit("Colossus", 1)
supplyLimit("Installation", 1)
supplyLimit("Iceni", 1)
supplyLimit("Ares", 20)
supplyLimit("ArtemisDH", 20)
supplyLimit("AWACS", 2)
supplyLimit("Faustus", 1)
supplyLimit("Moloch", 5)
supplyLimit("Sobek", 5)
supplyLimit("Lucifer", 1)
supplyLimit("Sathanas", 1)
supplyLimit("Imhotep", 1)

supplyShow("Cruiser", "Always")
supplyShow("AdvancedCruiser", "Always")

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

supplyLimit("LayoutBomber", 180)
supplyLimit("LayoutCruiser", 180)
supplyLimit("LayoutBattleCruiser", 1)

supplyShow("LayoutBomber", "Never")
supplyShow("LayoutCruiser", "Never")
supplyShow("LayoutBattleCruiser", "Never")


