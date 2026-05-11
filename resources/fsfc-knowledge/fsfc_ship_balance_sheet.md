# FreeSpace: Fleet Command - Ship Balance Sheet

This document serves as a central reference for ship statistics and weapon DPS to assist in balancing the FreeSpace 1 and FreeSpace 2 eras.

## Methodology
- **DPS (Weapon)**: Calculated as `(shots_per_burst * damage) / (burst_cycle_time)`. For beams, it accounts for duration over the cycle.
- **Total DPS (Ship)**: The sum of DPS for **ALL** primary weapon mounts.
- **Sensors**: Displayed as `Primary Range / Secondary Range`.
- **Movement**: Displayed as `Spd (Max) / Rot (Max)`.
- **Time/Research**: Build time in seconds and the research prerequisite.
- **Res Cost/Time**: Cost in RU and time in seconds for the *primary* research prerequisite.

---

## Unit Capacity Constraints (Baseline)

The following caps are enforced across all map sizes. Ships often consume units from multiple pools (e.g., a Destroyer consumes 1 from 'Capital' and 1 from 'Destroyer').

| Family Pool | Capacity | Primary Ships Covered |
| :--- | :--- | :--- |
| **Fighter** | 135 | All interceptors and space superiority fighters |
| **Bomber** | 135 | All light, medium, and heavy bombers |
| **Cruiser** | 25 | Fenris, Leviathan, Aten, Cain, etc. |
| **Advanced Cruiser** | 5 | Aeolus, Rakshasa, Mentu |
| **Destroyer** | 2 | Orion, Typhon, Demon, Ravana, Hecate |
| **Capital (Global)** | 15 | Global limit for all capital class ships |
| **Unique Caps** | | |
| Colossus / Sathanas | 1 | GTVA Colossus / Shivan Sathanas |
| Lucifer / Hades | 1 | Shivan Lucifer / GTD Hades |

---

## [TERRAN - GTA]

| Ship | HP | Cost | Time | Research (Prereq) | Res Cost/Time | DPS | Sensors | Movement |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| GTSG Cerberus | 150 | 40 | 5s | SentryGun | 1500RU / 50s | **140.0** | 2000/2000 | Spd:0 / Rot:0 |
| GTSG Alastor | 250 | 60 | 7s | SentryGun | 1500RU / 50s | **190.0** | 2000/2000 | Spd:0 / Rot:0 |
| GTNB Pharos | 100 | 100 | 20s | None | -RU / -s | **0** | 10000/10000 | Spd:500 / Rot:250 |
| GTS Centaur | 2000 | 150 | 9s | FighterDesign | 1200RU / 40s | **0** | 3500/4500 | Spd:295 / Rot:125 |
| GTS Hygeia | 1000 | 150 | 9s | FighterDesign | 1200RU / 40s | **0** | 3500/4500 | Spd:280 / Rot:125 |
| GTF Ulysses | 240 | 390 | 26s | Ulysses & FS2 | 1000RU / 45s | **126.33** | 9000/11000 | Spd:328 / Rot:125 |
| GTF Ulysses (FS1) | 240 | 390 | 26s | Ulysses & FS1 | 1000RU / 45s | **115.33** | 9000/11000 | Spd:328 / Rot:125 |
| GTT Elysium | 3500 | 400 | 25s | None | -RU / -s | **13.5** | 3500/4500 | Spd:160 / Rot:10 |
| GTFr Poseidon | 4000 | 400 | 25s | SentryAndMineDeployer | 1500RU / 50s | **90.0** | 4000/5000 | Spd:200 / Rot:25 |
| GTC Fenris (FS1) | 18000 | 450 | 30s | CruiserDesign & FS1 | 2500RU / 50s | **640.0** | 5000/6000 | Spd:90 / Rot:20 |
| GTB Zeus | 200 | 450 | 31s | Zeus | 1000RU / 40s | **270.46** | 4000/10000 | Spd:260 / Rot:100 |
| GTF Loki | 90 | 460 | 29s | FighterDesign | 1200RU / 40s | **133.83** | 9000/11000 | Spd:340 / Rot:130 |
| GTF Apollo | 240 | 470 | 30s | Apollo & FS1 | 850RU / 40s | **59.5** | 9000/11000 | Spd:284 / Rot:125 |
| GTF Valkyrie | 200 | 470 | 30s | Valkyrie & FS1 | 850RU / 40s | **95.0** | 3000/4000 | Spd:370 / Rot:125 |
| GTB Athena | 250 | 490 | 31s | BomberDesign | 1500RU / 50s | **124.92** | 4000/10000 | Spd:270 / Rot:120 |
| GTC Fenris | 18000 | 500 | 30s | CruiserDesign & FS2 | 2500RU / 50s | **454.36** | 5000/6000 | Spd:90 / Rot:20 |
| GTB Medusa (FS1) | 350 | 530 | 35s | Medusa & FS1 | 1500RU / 50s | **203.33** | 4000/10000 | Spd:230 / Rot:80 |
| GTB Medusa | 350 | 530 | 35s | Medusa & FS2 | 1500RU / 50s | **253.33** | 4000/10000 | Spd:230 / Rot:80 |
| GTF Myrmidon | 240 | 590 | 36s | Myrmidon & FS2 | 1200RU / 50s | **94.5** | 9000/11000 | Spd:340 / Rot:130 |
| GTB Artemis | 275 | 600 | 37s | Artemis & FS2 | 1200RU / 50s | **125.5** | 4000/10000 | Spd:260 / Rot:90 |
| GTF Hercules Mk. II | 275 | 610 | 37s | HerculesMk2 & FS2 | 1200RU / 50s | **167.56** | 3000/4000 | Spd:240 / Rot:110 |
| GTF Perseus | 265 | 620 | 35s | Perseus & FS2 | 1200RU / 50s | **188.0** | 3000/4000 | Spd:360 / Rot:140 |
| GTT Argo | 13500 | 625 | 37s | Repair Frigate & FS2 | 1000RU / 50s | **66.66** | 5000/6000 | Spd:140 / Rot:18 |
| GTFr Chronos | 20000 | 625 | 37s | Repair Frigate & FS1 | 1000RU / 50s | **70.0** | 3500/4500 | Spd:190 / Rot:25 |
| GTF Hercules | 250 | 660 | 39s | Hercules | 1000RU / 45s | **110.63** | 3000/4000 | Spd:228 / Rot:100 |
| GTC Leviathan (FS1) | 18000 | 750 | 43s | HeavyCruiser & FS1 | 1000RU / 50s | **640.0** | 5000/6000 | Spd:40 / Rot:15 |
| GTG Zephyrus | 10000 | 600 | 30s | None | -RU / -s | **238.33** | 3500/4500 | Spd:160 / Rot:25 |
| GTB Artemis D.H. | 275 | 810 | 42s | ArtemisDH & FS2 | 1400RU / 50s | **190.17** | 4000/10000 | Spd:300 / Rot:100 |
| GTC Leviathan | 18000 | 850 | 43s | HeavyCruiser & FS2 | 1000RU / 50s | **348.72** | 5000/6000 | Spd:40 / Rot:15 |
| GTF Erinyes | 325 | 900 | 45s | Erinyes & FS2 | 1800RU / 60s | **267.26** | 3000/4000 | Spd:270 / Rot:115 |
| GTB Boanerges | 325 | 910 | 44s | Boanerges & FS2 | 1800RU / 60s | **320.84** | 4000/10000 | Spd:240 / Rot:85 |
| GTF Ares | 425 | 925 | 45s | Ares & FS2 | 1500RU / 50s | **248.54** | 3000/4000 | Spd:224 / Rot:100 |
| GTB Ursa (FS1) | 550 | 940 | 45s | Ursa & FS1 | 2000RU / 50s | **271.83** | 4000/10000 | Spd:210 / Rot:70 |
| GTB Ursa | 550 | 940 | 45s | Ursa & FS2 | 2000RU / 50s | **416.83** | 4000/10000 | Spd:210 / Rot:70 |
| GTF Pegasus | 90 | 1000 | 65s | Pegasus & FS2 | 1000RU / 30s | **146.0** | 9000/11000 | Spd:400 / Rot:130 |
| GTC Aeolus | 18000 | 1050 | 47s | AdvancedCruiser & FS2 | 2000RU / 50s | **504.34** | 5000/6000 | Spd:140 / Rot:25 |
| GTSC Faustus | 12000 | 1500 | 35s | ScienceVessel | 1500RU / 50s | **480.0** | 5000/6000 | Spd:125 / Rot:15 |
| GTA Charybdis | 10000 | 2000 | 90s | AWACS & FS2 | 2500RU / 50s | **480.0** | 5000/6000 | Spd:140 / Rot:25 |
| GTCv Deimos | 85000 | 3000 | 110s | Corvette & FS2 | 1500RU / 50s | **1045.7** | 6500/7500 | Spd:120 / Rot:12 |
| GTSG Mjolnir | 5000 | 3000 | 120s | BeamSentry | 1500RU / 50s | **714.29** | 0/0 | Spd:0 / Rot:0 |
| GTI Arcadia | 200000 | 6000 | 100s | Installation | 2500RU / 75s | **1056.25** | 10000/18000 | Spd:0 / Rot:0 |
| NTF Iceni | 150000 | 9000 | 0s | None | -RU / -s | **1031.38** | 6500/7500 | Spd:190 / Rot:18 |
| GTD Hecate | 80000 | 11000 | 200s | CapitalShipDesign & FS2 | 3000RU / 75s | **1576.38** | 5000/6000 | Spd:60 / Rot:4 |
| GTD Orion (FS1) | 80000 | 12500 | 215s | CapitalShipDesign & FS1 | 3000RU / 75s | **480.0** | 5000/6000 | Spd:60 / Rot:4 |
| GTD Orion | 80000 | 12500 | 215s | CapitalShipDesign & FS2 | 3000RU / 75s | **321.54** | 5000/6000 | Spd:60 / Rot:4 |
| GTD Hades | 400000 | 20000 | 280s | SuperDestroyer | 5000RU / 100s | **1180.0** | 7000/8000 | Spd:80 / Rot:6 |
| GTVA Colossus | 1000000 | 50000 | 500s | Juggernaut & FS2 | 10000RU / 150s | **5313.76** | 18000/20000 | Spd:125 / Rot:3 |

---

## [SHIVAN - Unknown]

| Ship | HP | Cost | Time | Research (Prereq) | Res Cost/Time | DPS | Sensors | Movement |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| SSG Trident | 100 | 50 | 5s | SentryGun | 1000RU / 40s | **60.0** | 2000/2000 | Spd:0 / Rot:0 |
| SSG Belial | 160 | 75 | 7s | SentryGun | 1000RU / 40s | **120.0** | 2000/2000 | Spd:0 / Rot:0 |
| ST Azrael | 2000 | 400 | 25s | None | -RU / -s | **68.58** | 3500/4500 | Spd:200 / Rot:15 |
| SFr Mephisto | 10000 | 400 | 25s | SentryAndMineDeployer | 1000RU / 40s | **91.44** | 4000/5000 | Spd:210 / Rot:25 |
| SF Astaroth | 100 | 420 | 29s | FighterDesign | 800RU / 40s | **33.61** | 3000/4000 | Spd:380 / Rot:120 |
| SF Scorpion | 90 | 430 | 29s | FighterDesign | 800RU / 40s | **86.25** | 9000/11000 | Spd:284 / Rot:125 |
| SF Manticore | 100 | 450 | 35s | FighterDesign | 800RU / 40s | **142.86** | 3000/4000 | Spd:414 / Rot:135 |
| SB Nahema | 300 | 550 | 31s | BomberDesign | 1000RU / 40s | **77.8** | 4000/10000 | Spd:324 / Rot:120 |
| SFr Asmodeus | 8000 | 550 | 37s | RepairArgo | 1000RU / 40s | **141.33** | 5000/6000 | Spd:210 / Rot:20 |
| SF Aeshma | 125 | 570 | 42s | FighterDesign | 800RU / 40s | **159.31** | 3000/4000 | Spd:272 / Rot:115 |
| SC Cain | 18000 | 600 | 30s | CruiserDesign & FS2 | 1500RU / 40s | **367.18** | 5000/6000 | Spd:120 / Rot:25 |
| SB Taurvi | 600 | 600 | 37s | BomberDesign | 1000RU / 40s | **179.5** | 4000/10000 | Spd:274 / Rot:95 |
| SC Cain (FS1) | 18000 | 600 | 30s | CruiserDesign & FS1 | 1500RU / 40s | **362.86** | 5000/6000 | Spd:120 / Rot:25 |
| SF Basilisk | 100 | 620 | 39s | FighterDesign | 800RU / 40s | **130.55** | 3000/4000 | Spd:246 / Rot:100 |
| SF Dragon | 240 | 670 | 26s | FighterDesign | 800RU / 40s | **122.0** | 9000/11000 | Spd:330 / Rot:140 |
| SG Rahu | 18000 | 800 | 30s | None | -RU / -s | **108.0** | 3500/4500 | Spd:225 / Rot:20 |
| SB Shaitan | 400 | 830 | 31s | BomberDesign | 1000RU / 40s | **199.75** | 4000/10000 | Spd:264 / Rot:110 |
| SB Nephilim | 500 | 840 | 37s | BomberDesign | 1000RU / 40s | **398.75** | 4000/10000 | Spd:280 / Rot:90 |
| SF Mara | 240 | 860 | 36s | FighterDesign | 800RU / 40s | **128.25** | 9000/11000 | Spd:296 / Rot:130 |
| SB Seraphim | 500 | 880 | 45s | BomberDesign | 1000RU / 40s | **514.47** | 4000/10000 | Spd:300 / Rot:85 |
| SF Gorgon | 240 | 890 | 35s | FighterDesign | 800RU / 40s | **160.3** | 3000/4000 | Spd:435 / Rot:130 |
| Shivan Comm Node | 40000 | 1000 | 0s | None | -RU / -s | **0** | 15000/30000 | Spd:0 / Rot:0 |
| SC Rakshasa | 18000 | 1250 | 47s | AdvancedCruiser & FS2 | 2000RU / 40s | **499.18** | 5000/6000 | Spd:80 / Rot:20 |
| SCv Moloch | 85000 | 3000 | 110s | Corvette & FS2 | 1500RU / 40s | **480.32** | 6500/7500 | Spd:120 / Rot:10 |
| SC Lilith | 18000 | 4000 | 43s | HeavyCruiser & FS2 | 1000RU / 40s | **284.18** | 5000/6000 | Spd:80 / Rot:20 |
| SC Lilith (FS1) | 18000 | 4000 | 43s | HeavyCruiser & FS1 | 1000RU / 40s | **279.86** | 5000/6000 | Spd:80 / Rot:20 |
| SD Demon | 80000 | 11500 | 215s | CapitalShipDesign & FS2 | 2500RU / 60s | **1135.54** | 5000/6000 | Spd:80 / Rot:6 |
| SD Demon (FS1) | 80000 | 11500 | 215s | CapitalShipDesign & FS1 | 2500RU / 60s | **1126.9** | 5000/6000 | Spd:80 / Rot:6 |
| SD Ravana | 80000 | 13000 | 200s | CapitalShipDesign & FS2 | 2500RU / 60s | **1119.51** | 5000/6000 | Spd:80 / Rot:6 |
| SD Lucifer | 500000 | 21500 | 280s | SuperDestroyer | 4000RU / 80s | **510.5** | 7000/8000 | Spd:90 / Rot:4 |
| SJ Sathanas | 1000000 | 55000 | 500s | Juggernaut & FS2 | 10000RU / 100s | **1968.23** | 18000/20000 | Spd:120 / Rot:3 |

---

## [VASUDAN - PVN]

| Ship | HP | Cost | Time | Research (Prereq) | Res Cost/Time | DPS | Sensors | Movement |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| PVSG Ankh | 60 | 30 | 5s | SentryGun | 1000RU / 40s | **140.0** | 2000/2000 | Spd:0 / Rot:0 |
| GVSG Edjo | 70 | 45 | 7s | SentryGun | 1000RU / 40s | **70.0** | 2000/2000 | Spd:0 / Rot:0 |
| PVNB Geb | 50 | 100 | 20s | None | -RU / -s | **0** | 10000/10000 | Spd:500 / Rot:250 |
| PVS Scarab | 1000 | 150 | 9s | FighterDesign | 800RU / 40s | **0** | 3500/4500 | Spd:295 / Rot:125 |
| GVS Nephthys | 1000 | 150 | 9s | FighterDesign | 800RU / 40s | **0** | 3500/4500 | Spd:280 / Rot:125 |
| PVFr Bast | 4000 | 350 | 25s | SentryAndMineDeployer | 1000RU / 40s | **67.5** | 4000/5000 | Spd:230 / Rot:25 |
| PVF Anubis | 300 | 370 | 24s | FighterDesign | 800RU / 40s | **26.25** | 9000/11000 | Spd:330 / Rot:140 |
| PVT Isis | 5000 | 400 | 25s | None | -RU / -s | **27.0** | 3500/4500 | Spd:160 / Rot:10 |
| GVFr Bes | 4500 | 400 | 25s | SentryAndMineDeployer | 1000RU / 40s | **87.5** | 4000/5000 | Spd:210 / Rot:25 |
| GVC Aten (FS1) | 18000 | 450 | 30s | CruiserDesign & FS1 | 1500RU / 40s | **271.0** | 5000/6000 | Spd:105 / Rot:25 |
| GVC Aten | 18000 | 450 | 30s | CruiserDesign & FS2 | 1500RU / 40s | **325.36** | 5000/6000 | Spd:105 / Rot:25 |
| GVF Horus | 170 | 475 | 30s | FighterDesign | 800RU / 40s | **99.08** | 3000/4000 | Spd:400 / Rot:140 |
| GVFr Satis | 10000 | 550 | 37s | RepairArgo | 1000RU / 40s | **237.5** | 5000/6000 | Spd:220 / Rot:20 |
| GVB Bakha | 440 | 570 | 31s | BomberDesign | 1000RU / 40s | **186.75** | 4000/10000 | Spd:260 / Rot:110 |
| GVF Seth | 280 | 570 | 30s | FighterDesign | 800RU / 40s | **166.22** | 3000/4000 | Spd:254 / Rot:100 |
| GVF Thoth | 240 | 590 | 29s | FighterDesign | 800RU / 40s | **98.0** | 9000/11000 | Spd:286 / Rot:130 |
| GVF Serapis | 220 | 690 | 35s | FighterDesign | 800RU / 40s | **145.36** | 3000/4000 | Spd:306 / Rot:140 |
| GVB Osiris | 600 | 750 | 35s | BomberDesign | 1000RU / 40s | **155.33** | 4000/10000 | Spd:228 / Rot:85 |
| PVFr Maat | 18000 | 800 | 37s | RepairChronos | 1000RU / 40s | **151.5** | 3500/4500 | Spd:225 / Rot:20 |
| GVG Anuket | 18000 | 800 | 30s | None | -RU / -s | **165.83** | 3500/4500 | Spd:225 / Rot:20 |
| GVF Tauret | 300 | 860 | 42s | FighterDesign | 800RU / 40s | **189.26** | 3000/4000 | Spd:280 / Rot:120 |
| GVB Sehkmet | 500 | 890 | 37s | BomberDesign | 1000RU / 40s | **277.03** | 4000/10000 | Spd:248 / Rot:85 |
| GVF Ptah | 90 | 1000 | 65s | FighterDesign | 800RU / 40s | **148.0** | 9000/11000 | Spd:400 / Rot:140 |
| PVB Amun | 625 | 1310 | 45s | BomberDesign | 1000RU / 40s | **394.17** | 4000/10000 | Spd:160 / Rot:70 |
| GVC Mentu | 18000 | 1475 | 47s | AdvancedCruiser & FS2 | 2000RU / 40s | **623.01** | 5000/6000 | Spd:140 / Rot:25 |
| PVSC Imhotep | 10000 | 1500 | 35s | ScienceVessel | 1500RU / 40s | **260.5** | 5000/6000 | Spd:180 / Rot:20 |
| GVA Setekh | 10000 | 1750 | 90s | AWACS & FS2 | 2500RU / 40s | **150.0** | 5000/6000 | Spd:165 / Rot:25 |
| GVCv Sobek | 85000 | 3000 | 110s | Corvette & FS2 | 1500RU / 40s | **842.04** | 6500/7500 | Spd:120 / Rot:10 |
| GVD Typhon | 80000 | 8000 | 175s | CapitalShipDesign & FS2 | 2500RU / 60s | **1036.62** | 5000/6000 | Spd:60 / Rot:4.5 |
| PVI Karnak | 400000 | 10000 | 100s | Installation | 2500RU / 60s | **1683.75** | 10000/18000 | Spd:0 / Rot:0 |
| GVD Typhon (FS1) | 80000 | 11000 | 175s | CapitalShipDesign & FS1 | 2500RU / 60s | **1102.9** | 5000/6000 | Spd:60 / Rot:4.5 |
| GVD Hatshepsut | 80000 | 14000 | 200s | CapitalShipDesign & FS2 | 2500RU / 60s | **2156.95** | 5000/6000 | Spd:60 / Rot:4.5 |
| GTVA Colossus | 1000000 | 50000 | 500s | Juggernaut & FS2 | 10000RU / 100s | **5313.76** | 18000/20000 | Spd:125 / Rot:3 |
