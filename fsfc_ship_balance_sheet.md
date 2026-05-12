# FreeSpace: Fleet Command - Master Balance Sheet

## [HOW TO READ THIS SHEET]
This document is the **Universal Source of Truth** for mod balancing. It is auto-generated from source files.

### 1. The Weaponry Matrix
- **DPS**: Calculated sum of damage over time.
- **Acc: F/C/Fr/Cp**: Accuracy against **F**ighter, **C**orvette, **Fr**igate, **Cp** (Capital).
- **Pen: Un/Lt/Md/Hv**: Damage multiplier against **Un**armoured, **Lt** (Light), **Md** (Medium), **Hv** (Heavy) armor families.

### 2. The Detailed Ability Matrix (New)
- **Hangar**: Hangar capacity and supported weight/families.
- **Hyperspace**: Min cost, multiplier factor, and recovery time.
- **Repair**: HP/s repair rate and radius.
- **Harvest/Cloak**: Detailed capacity/rates for specialized systems.

---

## Weaponry Matrix (Accuracy & Penetration)
| Weapon | Dmg | ROF | DPS | Range | Acc: F/C/Fr/Cp | Pen: Un/Lt/Md/Hv |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| beam_AABlue | 77.0 | 1.0 | **77.0** | 4500.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| beam_AARed | 77.0 | 1.0 | **77.0** | 4500.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| Beam_MjolnirBeam | 25000.0 | 1.0 | **25000.0** | 10000.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| beam_sgold | 8250.0 | 1.0 | **8250.0** | 8000.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| beam_slashgreen | 3850.0 | 1.0 | **3850.0** | 8000.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_avenger | 16.0 | 0.67 | **10.67** | 2000.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| gun_avenger_gimble | 16.0 | 0.8 | **12.8** | 2000.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_avenger_turret | 35.0 | 0.67 | **23.33** | 2000.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_bansheenormal | 26.0 | 0.56 | **14.44** | 1950.0 | 0.7/0.8/0.80/0.80 | 1.25/0.8/0.4/0.4 |
| gun_circe | 45.0 | 0.56 | **25.0** | 2700.0 | 1/1/1/1 | 1.25/0.8/0.4/0.4 |
| gun_disruptor | 30.0 | 0.74 | **22.22** | 2000.0 | 0/0/0/0 | 1/0.4/0.2/0.1 |
| gun_disruptorfs1 | 15.0 | 0.62 | **9.38** | 1280.0 | 0/0/0/0 | 1/0.4/0.2/0.1 |
| gun_Flak_Gimble | 5.0 | 0.87 | **4.35** | 2100.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_flak_turret | 5.0 | 0.87 | **4.35** | 2100.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_heavyflak_turret | 10.0 | 0.6 | **5.99** | 2500.0 | 0.3/0.5/0.80/0.80 | 2/1/1/1 |
| gun_kayser | 28.0 | 0.8 | **22.4** | 1950.0 | 1/1/1/1 | 1.25/0.8/0.4/0.4 |
| gun_lamprey | 20.0 | 0.62 | **12.5** | 1800.0 | 1/1/1/1 | 0.5/0.1/0.1/0.1 |
| gun_longrangeflak_turret | 40.0 | 0.77 | **30.77** | 6300.0 | 0.3/0.5/0.80/0.80 | 2/1/1/1 |
| gun_maxim | 26.0 | 0.77 | **20.0** | 7200.0 | 0.3/0.6/1/1 | 2/1/0.8/0.5 |
| gun_mekhu | 12.0 | 0.8 | **9.6** | 1940.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| gun_mekhu_turret | 12.0 | 0.8 | **9.6** | 3000.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_ml16 | 5.0 | 0.56 | **2.78** | 1800.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| gun_morningstar | 9.0 | 0.77 | **6.92** | 4000.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| gun_prometheusfs1 | 20.0 | 0.62 | **12.5** | 1800.0 | 1/1/1/1 | 1.5/1/0.7/0.3 |
| gun_prometheusfs1_turret | 20.0 | 0.5 | **10.0** | 1800.0 | 0.3/0.4/1/1 | 1.5/1/0.7/0.3 |
| gun_prometheusR | 19.0 | 0.53 | **10.0** | 1800.0 | 1/1/1/1 | 1.5/1/0.7/0.3 |
| gun_prometheusS | 30.0 | 0.59 | **17.65** | 3000.0 | 1/1/1/1 | 1.5/1/0.7/0.3 |
| gun_sentrylaser_turret | 19.0 | 0.83 | **15.83** | 2500.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_shivheavylaser | 18.0 | 2.0 | **36.0** | 1900.0 | 1/1/1/1 | 1/1/0.7/0.4 |
| gun_shivheavylaser_gimble | 18.0 | 0.67 | **12.0** | 1900.0 | 0.7/0.8/0.80/0.80 | 1/1/0.7/0.4 |
| gun_shivheavylaser_turret | 18.0 | 0.67 | **12.0** | 1900.0 | 0.7/0.8/0.80/0.80 | 1/1/0.7/0.4 |
| gun_shivlightlaser | 8.0 | 0.74 | **5.93** | 1800.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| gun_shivlightlaser_gimble | 8.0 | 0.74 | **5.93** | 1800.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_shivlightlaser_turret | 8.0 | 2.86 | **22.86** | 1800.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_shivmegafunk_turret | 390.0 | 0.22 | **86.67** | 2880.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_shivmegalaser | 30.0 | 0.57 | **17.14** | 1600.0 | 1/1/1/1 | 1.5/1/0.7/0.3 |
| gun_shivsentry_turret | 15.0 | 0.67 | **10.0** | 2800.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_shivsuperlaser_gimble | 60.0 | 0.83 | **50.0** | 2800.0 | 0.1/0.2/0.80/0.80 | 1/1/0.7/0.4 |
| gun_shivsuperlaser_turret | 60.0 | 0.83 | **50.0** | 2800.0 | 0.1/0.2/0.80/0.80 | 1/1/0.7/0.4 |
| gun_subach | 23.0 | 0.67 | **15.33** | 1800.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| gun_subach_turret | 13.0 | 1.67 | **21.67** | 1800.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.1 |
| gun_terbig_turret | 250.0 | 0.2 | **50.0** | 4200.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_tercollector_turret | 13.0 | 1.0 | **13.0** | 1940.0 | 0.5/0.6/0.80/0.80 | 1/0.8/0.4/0.1 |
| gun_terhuge_turret | 500.0 | 0.2 | **100.0** | 4200.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_terhugeturretlaser_gimble | 250.0 | 0.2 | **50.0** | 4200.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_terlaser_gimble | 80.0 | 1.0 | **80.0** | 2750.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_terlaser_turret | 43.0 | 1.0 | **43.0** | 2750.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_vashuge_gimble | 250.0 | 0.2 | **50.0** | 4200.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_vashuge_turret | 250.0 | 0.2 | **50.0** | 4200.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| gun_vaslaser_gimble | 43.0 | 0.5 | **21.5** | 2750.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_vaslaser_turret | 43.0 | 0.5 | **21.5** | 2750.0 | 0.7/0.8/0.80/0.80 | 1/0.8/0.4/0.2 |
| gun_vll9 | 10.0 | 2.0 | **20.0** | 1800.0 | 1/1/1/1 | 1/0.8/0.4/0.1 |
| miss_Cyclops | 2000.0 | 0.05 | **95.24** | 4750.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| miss_empadv | 90.0 | 0.05 | **4.29** | 2750.0 | 0/0/1/1 | 1/1/1/1 |
| miss_fighterkiller | 180.0 | 0.2 | **36.0** | 1900.0 | 1/1/0/0 | 1/1/0.2/0.1 |
| miss_fighterkiller_turret | 180.0 | 0.2 | **36.0** | 1900.0 | 1/1/0/0 | 1/1/0.2/0.1 |
| miss_fluxcannon | 500.0 | 0.2 | **100.0** | 8000.0 | 0/0/0.8/1 | 0.25/0.3/1/1 |
| miss_fury | 30.0 | 0.67 | **20.0** | 2000.0 | 1/1/1/1 | 1/1/1/.75 |
| miss_harbinger | 3200.0 | 0.03 | **103.23** | 3000.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| miss_harpoon | 200.0 | 0.2 | **40.0** | 2500.0 | 1/1/1/1 | 1/0.8/0.2/0.1 |
| miss_Helios | 6800.0 | 0.03 | **219.35** | 3900.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| miss_hornet | 50.0 | 0.87 | **43.48** | 2660.0 | 1/1/1/1 | 1/1/1.0/0.75 |
| miss_infyrno | 150.0 | 0.05 | **7.5** | 2500.0 | 1/1/1/1 | 0.1/0.1/1/0.75 |
| miss_phoenixv | 350.0 | 0.08 | **26.92** | 3500.0 | 1/1/1/1 | 1.1/1.1/0.5/0.4 |
| miss_pihrana | 70.0 | 0.05 | **3.5** | 4000.0 | 1/1/1/1 | 1/1/1/0.75 |
| miss_rockeye | 25.0 | 0.2 | **5.0** | 2500.0 | 1/1/1/1 | 1/0.8/0.5/0.3 |
| miss_shivbomb | 2000.0 | 0.05 | **100.0** | 4750.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| miss_shivmegabomb | 6800.0 | 0.03 | **226.67** | 3900.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |
| miss_stiletto | 775.0 | 0.05 | **36.9** | 4500.0 | 0/0/0/0 | 0/0/0/0 |
| miss_stilettoII | 1000.0 | 0.05 | **47.62** | 11000.0 | 0/0/0/0 | 0/0/0/0 |
| miss_synaptic | 40.0 | 0.05 | **2.0** | 4000.0 | 1/1/1/1 | 1/1/1/0.75 |
| miss_tempest | 40.0 | 0.67 | **26.67** | 1700.0 | 1/1/1/1 | 1/1/1/.75 |
| miss_tornado | 50.0 | 0.98 | **49.02** | 3220.0 | 1/1/1/1 | 1/1/1.0/0.75 |
| miss_trebuchet | 840.0 | 0.04 | **33.6** | 10080.0 | 1/1/1/1 | 0.75/1.0/0.5/0.4 |
| miss_tsunami | 1500.0 | 0.05 | **71.43** | 3000.0 | 0/0/0.80/0.80 | 1/1/0.8/0.5 |

---

## Detailed Ability Breakdown (Stats)

| Ship | Build | Hangar | Hyperspace | Repair | Harvest | Cloak | Special |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| GTA Charybdis | No | No | Min:130 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Artemis | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Artemis D.H. | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Athena | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Boanerges | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Medusa | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Medusa (FS1) | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Ursa | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Ursa (FS1) | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTB Zeus | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTC Aeolus | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GTC Fenris | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GTC Fenris (FS1) | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GTC Leviathan | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GTC Leviathan (FS1) | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GTCv Deimos | No | No | Min:350 | Fact:1 | Rec:0s | No | No | No | No |
| GTD Hades | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:28 | Fams:Fighter, Utility | Rep:60 | Min:800 | Fact:1 | Rec:0s | No | No | No | No |
| GTD Hecate | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| GTD Orion | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| GTD Orion (FS1) | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Apollo | No | No | No | No | No | No | No |
| GTF Ares | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Erinyes | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Hercules | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Hercules Mk. II | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Loki | No | No | No | No | No | No | No |
| GTF Myrmidon | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Pegasus | No | No | No | No | No | Usage:0 | Cost:0 | Regen:0 | No |
| GTF Perseus | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Ulysses | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Ulysses (FS1) | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTF Valkyrie | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GTFr Chronos | No | No | Min:70 | Fact:1 | Rec:0s | Rate:400 | Rad:25 | No | No | No |
| GTFr Poseidon | Fams: Platform | Size:1 | Fams:Fighter, Utility | Rep:400 | No | No | No | No | No |
| GTG Zephyrus | No | Size:1.0 | Fams: | Rep:0 | Min:60 | Fact:1 | Rec:0s | No | No | No | No |
| GTI Arcadia | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:16 | Fams:Fighter, Utility | Rep:100 | No | No | No | No | No |
| GTNB Pharos | No | No | No | No | No | No | No |
| GTS Centaur | No | No | Min:25 | Fact:1 | Rec:0s | Rate:400 | Rad:0 | No | No | No |
| GTS Hygeia | No | No | Min:25 | Fact:1 | Rec:0s | Rate:400 | Rad:0 | No | No | No |
| GTSC Faustus | No | No | Min:130 | Fact:1 | Rec:0s | No | No | No | No |
| GTSG Alastor | No | No | No | No | No | No | No |
| GTSG Cerberus | No | No | No | No | No | No | No |
| GTSG Mjolnir | No | No | No | No | No | No | No |
| GTT Argo | No | No | Min:70 | Fact:1 | Rec:0s | Rate:400 | Rad:25 | No | No | No |
| GTT Elysium | No | No | Min:30 | Fact:1 | Rec:0s | No | Rate:200 | Cap:8 | No | No |
| GTVA Colossus | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:60 | Fams:Fighter, Utility | Rep:100 | Min:2500 | Fact:1 | Rec:0s | No | No | No | No |
| GTVA Colossus | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:60 | Fams:Fighter, Utility | Rep:100 | Min:2500 | Fact:1 | Rec:0s | No | No | No | No |
| GVA Setekh | No | No | Min:300 | Fact:1 | Rec:0s | No | No | No | No |
| GVB Bakha | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVB Osiris | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVB Sehkmet | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVC Aten | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GVC Aten (FS1) | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GVC Mentu | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GVCv Sobek | No | No | Min:350 | Fact:1 | Rec:0s | No | No | No | No |
| GVD Hatshepsut | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| GVD Typhon | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| GVD Typhon (FS1) | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| GVF Horus | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVF Ptah | No | No | No | No | No | Usage:0 | Cost:0 | Regen:0 | No |
| GVF Serapis | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVF Seth | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVF Tauret | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVF Thoth | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| GVFr Bes | Fams: Platform | Size:1 | Fams:Fighter, Utility | Rep:400 | No | No | No | No | No |
| GVFr Satis | No | No | Min:50 | Fact:1 | Rec:0s | Rate:400 | Rad:25 | No | No | No |
| GVG Anuket | No | Size:1.0 | Fams: | Rep:0 | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| GVS Nephthys | No | No | Min:25 | Fact:1 | Rec:0s | Rate:400 | Rad:0 | No | No | No |
| GVSG Edjo | No | No | No | No | No | No | No |
| NTF Iceni | No | No | Min:350 | Fact:1 | Rec:0s | No | No | No | No |
| PVB Amun | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| PVF Anubis | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| PVFr Bast | Fams: Platform | Size:1 | Fams:Fighter, Utility | Rep:400 | No | No | No | No | No |
| PVFr Maat | No | Size:0 | Fams: | Rep:0 | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| PVI Karnak | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:16 | Fams:Fighter, Utility | Rep:100 | No | No | No | No | No |
| PVNB Geb | No | No | No | No | No | No | No |
| PVS Scarab | No | No | Min:25 | Fact:1 | Rec:0s | Rate:400 | Rad:0 | No | No | No |
| PVSC Imhotep | No | No | Min:50 | Fact:1 | Rec:0s | No | No | No | No |
| PVSG Ankh | No | No | No | No | No | No | No |
| PVT Isis | No | No | Min:30 | Fact:1 | Rec:0s | No | Rate:200 | Cap:8 | No | No |
| SB Nahema | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SB Nephilim | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SB Seraphim | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SB Shaitan | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SB Taurvi | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SC Cain | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| SC Cain (FS1) | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| SC Lilith | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| SC Lilith (FS1) | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| SC Rakshasa | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| SCv Moloch | No | No | Min:70 | Fact:1 | Rec:0s | No | No | No | No |
| SD Demon | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| SD Demon | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| SD Lucifer | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:28 | Fams:Fighter, Utility | Rep:60 | Min:800 | Fact:1 | Rec:0s | No | No | No | EMP |
| SD Ravana | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:20 | Fams:Fighter, Utility | Rep:200 | Min:875 | Fact:1 | Rec:0s | No | No | No | No |
| SF Aeshma | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Astaroth | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Basilisk | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Dragon | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Gorgon | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Manticore | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Mara | No | No | Min:30 | Fact:1 | Rec:0s | No | No | No | No |
| SF Scorpion | No | No | No | No | No | No | No |
| SFr Asmodeus | No | No | Min:55 | Fact:1 | Rec:0s | Rate:0 | Rad:25 | No | No | No |
| SFr Mephisto | Fams: Platform | Size:1 | Fams:Fighter, Utility | Rep:400 | No | No | No | No | No |
| SG Rahu | No | Size:0 | Fams: | Rep:0 | Min:55 | Fact:1 | Rec:0s | No | No | No | No |
| SJ Sathanas | Fams: Utility, Fighter, Bomber, Cruiser, Capital, Platform | Size:60 | Fams:Fighter, Utility | Rep:60 | Min:2000 | Fact:1 | Rec:0s | No | No | No | No |
| SSG Belial | No | No | No | No | No | No | No |
| SSG Trident | No | No | No | No | No | No | No |
| ST Azrael | No | No | Min:30 | Fact:1 | Rec:0s | No | Rate:200 | Cap:8 | No | No |
| Shivan Comm Node | No | No | No | No | No | No | No |

---

## [TERRAN - GTA]

| Ship | HP | Armor / Attack Fam | Cost | Time | Guns | DPS | F/AF | C/AC | Fr/AFr | T | Sensors | Spd/Rot/Acc/Bnk |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| GTSG Cerberus | 150 | TurretArmour / Frigate | 40 | 5s | 2x avenger_turret | **46.66** | 0/8 | 0/0 | 0/0 | 8 | 2000/2000 | 0/120/0.11/15 |
| GTSG Alastor | 250 | TurretArmour / Frigate | 60 | 7s | 2x sentrylaser_turret | **31.66** | 0/8 | 0/0 | 0/0 | 8 | 2000/2000 | 0/120/0.11/15 |
| GTNB Pharos | 100 | Unarmoured / Utility | 100 | 20s | None | **0** | 0/0 | 0/0 | 0/0 | 0 | 10000/10000 | 500/170/0.11/15 |
| GTS Centaur | 2000 | LightArmour / Resource | 150 | 9s | None | **0** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 295/95/4/85 |
| GTS Hygeia | 1000 | LightArmour / Resource | 150 | 9s | None | **0** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 280/95/4/85 |
| GTF Ulysses | 240 | Unarmoured / Fighter | 390 | 26s | 1x subach, 1x morningstar, 1x miss_harpoon | **62.25** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 328/129/2/85 |
| GTF Ulysses (FS1) | 240 | Unarmoured / Fighter | 390 | 26s | 1x prometheusfs1, 1x avenger, 1x miss_harpoon | **63.17** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 328/129/2/85 |
| GTT Elysium | 3500 | ResArmour / Resource | 400 | 25s | 1x tercollector_turret | **13.0** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 160/60/3/30 |
| GTFr Poseidon | 4000 | LightArmour / ResourceLarge | 400 | 25s | 4x subach_turret | **86.68** | 0/0 | 10/0 | 0/0 | 10 | 4000/5000 | 200/50/8/60 |
| GTC Fenris (FS1) | 18000 | MediumArmour / Frigate | 450 | 30s | 8x terlaser_gimble | **640.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 90/20/10/20 |
| GTB Zeus | 200 | LightArmour / Fighter | 450 | 31s | 1x Subach, 1x disruptor, 1x miss_Cyclops, 1x miss_Stiletto | **169.69** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 260/85/1/85 |
| GTF Loki | 90 | Unarmoured / Fighter | 460 | 29s | 1x subach, 1x lamprey, 1x miss_harpoon, 1x miss_empadv | **72.12** | 8/0 | 0/0 | 0/0 | 8 | 9000/11000 | 340/130/2/85 |
| GTF Apollo | 240 | Unarmoured / Fighter | 470 | 30s | 1x ml16, 1x avenger, 1x miss_rockeye, 1x miss_fury | **38.45** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 284/112.5/3/85 |
| GTF Valkyrie | 200 | Unarmoured / Fighter | 470 | 30s | 1x bansheenormal, 1x prometheusfs1, 1x miss_phoenixv | **53.86** | 8/8 | 0/0 | 0/0 | 8 | 3000/4000 | 370/103/1/85 |
| GTB Athena | 250 | LightArmour / Fighter | 490 | 31s | 1x avenger, 1x disruptorfs1, 1x miss_phoenixv, 1x miss_stiletto | **83.87** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 270/80/4/85 |
| GTC Fenris | 18000 | MediumArmour / Frigate | 500 | 30s | 5x terlaser_gimble, 2x Beam_AABlue | **554.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 90/20/10/20 |
| GTB Medusa | 350 | LightArmour / Fighter | 530 | 35s | 1x prometheusfs1, 2x miss_Cyclops, 1x prometheusfs1_turret | **212.98** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 230/76/4/85 |
| GTB Medusa (FS1) | 350 | LightArmour / Fighter | 530 | 35s | 1x prometheusfs1, 2x miss_tsunami, 1x prometheusfs1_turret | **165.36** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 230/76/4/85 |
| GTF Myrmidon | 240 | Unarmoured / Fighter | 590 | 36s | 1x subach, 1x prometheusR, 1x miss_tempest, 1x miss_rockeye | **57.0** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 340/94/2.4/85 |
| GTB Artemis | 275 | LightArmour / Fighter | 600 | 37s | 1x prometheusR, 1x miss_Cyclops, 1x miss_Pihrana | **108.74** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 260/76/4/85 |
| GTG Zephyrus | 10000 | MediumArmour / ResourceLarge | 600 | 30s | 2x terlaser_gimble, 2x subach_turret, 1x flak_turret | **207.69** | 0/5 | 0/0 | 0/0 | 5 | 3500/4500 | 160/20/8/60 |
| GTF Hercules Mk. II | 275 | Unarmoured / Fighter | 610 | 37s | 1x prometheusr, 1x subach, 1x miss_hornet, 1x miss_tornado, 1x miss_tempest | **144.5** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 240/90/2/85 |
| GTF Perseus | 265 | Unarmoured / Fighter | 620 | 35s | 1x prometheusR, 1x subach, 1x miss_trebuchet, 1x miss_harpoon | **98.93** | 8/8 | 0/0 | 0/0 | 8 | 3000/4000 | 360/109/2/85 |
| GTT Argo | 13500 | MediumArmour / Frigate | 625 | 37s | 2x flak_turret | **8.7** | 0/0 | 0/0 | 8/0 | 8 | 5000/6000 | 140/40/8/60 |
| GTFr Chronos | 20000 | MediumArmour / ResourceLarge | 625 | 37s | 1x avenger_turret | **23.33** | 0/5 | 0/0 | 0/0 | 5 | 3500/4500 | 190/40/8/60 |
| GTF Hercules | 250 | Unarmoured / Fighter | 660 | 39s | 1x prometheusfs1, 1x avenger, 1x miss_hornet, 1x miss_fury | **86.65** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 228/85/3/85 |
| GTC Leviathan (FS1) | 18000 | MediumArmour / Frigate | 750 | 43s | 8x terlaser_gimble | **640.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 40/9/18/20 |
| GTB Artemis D.H. | 275 | LightArmour / Fighter | 810 | 42s | 1x maxim, 1x miss_Cyclops, 1x miss_Pihrana | **118.74** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 300/100/4/85 |
| GTC Leviathan | 18000 | MediumArmour / Frigate | 850 | 43s | 3x terlaser_gimble, 4x beam_AABlue | **548.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 40/9/18/20 |
| GTF Erinyes | 325 | Unarmoured / Fighter | 900 | 47s | 1x kayser, 1x circe, 1x miss_tornado, 1x miss_harpoon | **136.42** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 270/95/3.6/85 |
| GTB Boanerges | 325 | LightArmour / Fighter | 910 | 44s | 1x maxim, 1x miss_Helios, 1x miss_infyrno | **246.85** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 240/63/4/85 |
| GTF Ares | 425 | Unarmoured / Fighter | 925 | 45s | 1x maxim, 1x prometheusS, 1x miss_trebuchet, 1x miss_tornado | **120.27** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 224/76/2.4/85 |
| GTB Ursa | 550 | MediumArmour / Fighter | 940 | 45s | 2x prometheusfs1, 1x miss_Helios, 1x miss_cyclops, 1x miss_pihrana, 1x prometheusfs1_turret | **353.09** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 210/60/4/85 |
| GTB Ursa (FS1) | 550 | MediumArmour / Fighter | 940 | 45s | 2x prometheusfs1, 1x miss_tsunami, 1x miss_harbinger, 1x miss_pihrana, 1x prometheusfs1_turret | **213.16** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 210/60/4/85 |
| GTF Pegasus | 90 | Unarmoured / Fighter | 1000 | 65s | 1x subach, 1x miss_harpoon, 1x miss_stilettoII | **102.95** | 8/0 | 0/0 | 0/0 | 8 | 9000/11000 | 400/141/2/85 |
| GTC Aeolus | 18000 | MediumArmour / Frigate | 1050 | 47s | 2x beam_AABlue, 2x Flak_Gimble, 2x terhuge_turret, 4x flak_turret | **380.1** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 140/15/8/20 |
| GTSC Faustus | 12000 | MediumArmour / Frigate | 1500 | 35s | 6x terlaser_gimble | **480.0** | 0/0 | 0/0 | 12/0 | 12 | 5000/6000 | 125/20/8/20 |
| GTA Charybdis | 10000 | MediumArmour / Frigate | 2000 | 90s | 6x terlaser_gimble | **480.0** | 0/0 | 0/0 | 12/0 | 12 | 5000/6000 | 140/20/8/20 |
| GTCv Deimos | 85000 | HeavyArmour / SmallCapitalShip | 3000 | 110s | 4x terbig_turret, 6x flak_turret, 3x beam_AABlue, 1x Beam_AABlue, 6x terlaser_gimble, 2x miss_pihrana | **1021.1** | 0/0 | 0/0 | 40/30 | 50 | 6500/7500 | 120/12/8/40 |
| GTSG Mjolnir | 5000 | TurretArmour / Frigate | 3000 | 120s | 1x Beam_MjolnirBeam | **25000.0** | 0/8 | 0/0 | 0/0 | 8 | 0/0 | 0/10/8/90 |
| GTI Arcadia | 200000 | HeavyArmour / BigCapitalShip | 6000 | 100s | 19x terlaser_turret, 5x miss_fighterkiller | **997.0** | 0/5 | 0/0 | 15/0 | 20 | 10000/18000 | 0/5/1/10 |
| NTF Iceni | 150000 | HeavyArmour / SmallCapitalShip | 9000 | 210s | 6x terlaser_turret, 4x beam_AABlue, 2x flak_turret, 1x miss_pihrana, 4x terhugeturretlaser_gimble, 2x miss_fighterkiller, 2x terhuge_turret | **1050.2** | 0/0 | 0/0 | 40/30 | 50 | 6500/7500 | 190/8/8/40 |
| GTD Hecate | 80000 | HeavyArmour / BigCapitalShip | 11000 | 200s | 6x longrangeflak_turret, 6x beam_AABlue, 6x terlaser_gimble, 4x flak_turret | **1144.02** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 60/4.5/20/10 |
| GTD Orion | 80000 | HeavyArmour / BigCapitalShip | 12500 | 215s | 3x beam_AABlue, 3x terlaser_gimble | **471.0** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 60/4.5/20/10 |
| GTD Orion (FS1) | 80000 | HeavyArmour / BigCapitalShip | 12500 | 215s | 6x terlaser_gimble | **480.0** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 60/4.5/20/10 |
| GTD Hades | 400000 | HeavyArmour / BigCapitalShip | 20000 | 280s | 4x terhuge_turret, 1x miss_fighterkiller, 2x miss_infyrno, 6x shivsuperlaser_turret, 4x terlaser_gimble | **1071.0** | 0/0 | 0/5 | 80/60 | 110 | 7000/8000 | 80/3.5/20/10 |
| GTVA Colossus | 1000000 | HeavyArmour / BigCapitalShip | 50000 | 500s | 10x terhuge_turret, 12x flak_turret, 8x terlaser_gimble, 10x beam_AABlue, 2x miss_pihrana, 8x miss_rockeye, 7x beam_slashgreen | **29459.2** | 0/0 | 0/5 | 80/60 | 110 | 18000/20000 | 125/3/20/40 |

## [SHIVAN - Unknown]

| Ship | HP | Armor / Attack Fam | Cost | Time | Guns | DPS | F/AF | C/AC | Fr/AFr | T | Sensors | Spd/Rot/Acc/Bnk |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| SSG Trident | 100 | TurretArmour / Frigate | 50 | 6s | 2x shivsentry_turret | **20.0** | 0/8 | 0/0 | 0/0 | 8 | 2000/2000 | 0/120/0.11/15 |
| SSG Belial | 160 | TurretArmour / Frigate | 75 | 8s | 4x shivsentry_turret | **40.0** | 0/8 | 0/0 | 0/0 | 8 | 2000/2000 | 0/120/0.11/15 |
| ST Azrael | 2000 | ResArmour / Resource | 400 | 25s | 3x shivlightlaser_turret | **68.58** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 200/60/3/30 |
| SFr Mephisto | 10000 | LightArmour / ResourceLarge | 400 | 25s | 4x shivlightlaser_gimble | **23.72** | 0/0 | 10/0 | 0/0 | 10 | 4000/5000 | 210/50/8/60 |
| SF Astaroth | 100 | Unarmoured / Fighter | 420 | 30s | 2x shivlightlaser, 1x miss_rockeye, 1x miss_empadv | **21.15** | 10/12 | 0/0 | 0/0 | 10 | 3000/4000 | 380/109/3/85 |
| SF Scorpion | 90 | Unarmoured / Fighter | 430 | 28s | 2x shivlightlaser, 1x miss_rockeye | **16.86** | 3/0 | 0/0 | 0/0 | 3 | 9000/11000 | 284/180/3/85 |
| SF Manticore | 100 | Unarmoured / Fighter | 450 | 31s | 2x shivlightlaser, 1x miss_trebuchet, 1x miss_harpoon | **85.46** | 15/15 | 0/0 | 0/0 | 15 | 3000/4000 | 414/113/3/85 |
| SFr Asmodeus | 8000 | MediumArmour / Frigate | 550 | 35s | 1x flak_turret, 3x shivheavylaser_gimble | **40.35** | 0/0 | 0/0 | 8/0 | 8 | 5000/6000 | 210/40/8/60 |
| SB Nahema | 300 | LightArmour / Fighter | 550 | 34s | 1x shivmegalaser, 1x miss_infyrno, 1x miss_hornet | **68.12** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 324/60/2.5/85 |
| SF Aeshma | 125 | Unarmoured / Fighter | 570 | 35s | 2x shivmegalaser, 1x miss_hornet, 1x miss_tornado | **126.78** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 272/109/3/85 |
| SC Cain | 18000 | MediumArmour / Frigate | 600 | 34s | 5x shivsuperlaser_turret, 1x beam_AARed, 2x miss_fighterkiller | **399.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 120/20/8/20 |
| SC Cain (FS1) | 18000 | MediumArmour / Frigate | 600 | 34s | 5x shivsuperlaser_turret, 1x shivlightlaser_turret, 2x miss_fighterkiller | **344.86** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 120/20/8/20 |
| SB Taurvi | 600 | LightArmour / Fighter | 600 | 34s | 1x shivmegalaser, 1x shivheavylaser, 1x miss_shivbomb, 1x miss_pihrana | **156.64** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 274/60/4.5/85 |
| SF Basilisk | 100 | Unarmoured / Fighter | 620 | 37s | 2x shivmegalaser, 1x miss_hornet, 1x miss_tempest | **104.43** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 246/103/3/85 |
| SF Dragon | 240 | Unarmoured / Fighter | 670 | 39s | 2x shivheavylaser, 1x miss_harpoon | **112.0** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 330/160/2/85 |
| SG Rahu | 18000 | MediumArmour / ResourceLarge | 800 | 45s | 3x shivheavylaser_turret | **36.0** | 0/5 | 0/0 | 0/0 | 5 | 3500/4500 | 225/18/8/20 |
| SB Shaitan | 400 | LightArmour / Fighter | 830 | 48s | 1x shivheavylaser, 1x disruptorfs1, 1x miss_shivbomb, 1x miss_stiletto | **182.28** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 264/90/4/85 |
| SB Nephilim | 500 | LightArmour / Fighter | 840 | 44s | 1x shivlightlaser, 2x shivlightlaser_turret, 1x miss_pihrana, 1x miss_shivbomb, 1x miss_shivmegabomb | **381.82** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 280/60/4/85 |
| SF Mara | 240 | Unarmoured / Fighter | 860 | 47s | 2x shivheavylaser, 1x miss_harpoon, 1x miss_rockeye | **117.0** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 296/120/2.5/85 |
| SB Seraphim | 500 | LightArmour / Fighter | 880 | 45s | 3x shivlightlaser, 2x shivlightlaser_turret, 1x miss_shivmegabomb, 1x miss_shivbomb, 1x miss_pihrana, 1x miss_trebuchet | **427.28** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 300/60/4/85 |
| SF Gorgon | 240 | Unarmoured / Fighter | 890 | 45s | 2x shivmegalaser, 1x miss_hornet, 1x miss_harpoon | **117.76** | 8/8 | 0/0 | 0/0 | 8 | 3000/4000 | 435/180/3/85 |
| Shivan Comm Node | 40000 | HeavyArmour / BigCapitalShip | 1000 | 70s | None | **0** | 0/5 | 0/0 | 15/0 | 20 | 15000/30000 | 0/5/8/20 |
| SC Rakshasa | 18000 | MediumArmour / Frigate | 1250 | 60s | 8x shivsuperlaser_turret, 1x beam_AARed, 2x shivheavylaser_turret | **501.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 80/15/10/20 |
| SCv Moloch | 85000 | HeavyArmour / SmallCapitalShip | 3000 | 110s | 5x shivsuperlaser_turret, 2x miss_fighterkiller_turret, 4x flak_turret, 2x miss_pihrana | **346.4** | 0/0 | 0/0 | 40/30 | 50 | 6500/7500 | 120/11/8/10 |
| SC Lilith | 18000 | MediumArmour / Frigate | 4000 | 140s | 5x shivsuperlaser_turret, 1x beam_AARed, 2x miss_pihrana | **334.0** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 80/10/10/20 |
| SC Lilith (FS1) | 18000 | MediumArmour / Frigate | 4000 | 140s | 5x shivsuperlaser_turret, 1x shivlightlaser_turret, 2x miss_pihrana | **279.86** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 80/10/10/20 |
| SD Demon | 80000 | HeavyArmour / BigCapitalShip | 11500 | 215s | 2x beam_AARed, 2x shivmegafunk_turret, 4x flak_turret, 10x shivsuperlaser_turret, 5x miss_fighterkiller | **1024.74** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 80/3.5/20/15 |
| SD Demon | 80000 | HeavyArmour / BigCapitalShip | 11500 | 215s | 2x shivlightlaser_turret, 2x shivmegafunk_turret, 4x flak_turret, 10x shivsuperlaser_turret, 5x miss_fighterkiller | **916.46** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 80/3.5/20/15 |
| SD Ravana | 80000 | HeavyArmour / BigCapitalShip | 13000 | 225s | 2x beam_AARed, 17x shivsuperlaser_turret, 5x flak_turret, 1x miss_pihrana, 1x Miss_FighterKiller | **1065.25** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 80/3.5/20/15 |
| SD Lucifer | 500000 | HeavyArmour / BigCapitalShip | 21500 | 305s | 4x shivsuperlaser_gimble, 3x miss_pihrana, 6x shivsuperlaser_turret | **510.5** | 0/0 | 0/5 | 80/60 | 110 | 7000/8000 | 90/3.5/20/10 |
| SJ Sathanas | 1000000 | HeavyArmour / BigCapitalShip | 55000 | 550s | 22x shivsuperlaser_turret, 8x beam_AARed, 11x flak_turret, 5x miss_pihrana, 2x longrangeflak_turret | **1842.89** | 0/0 | 0/5 | 80/60 | 110 | 18000/20000 | 120/3/20/40 |

## [VASUDAN - PVN]

| Ship | HP | Armor / Attack Fam | Cost | Time | Guns | DPS | F/AF | C/AC | Fr/AFr | T | Sensors | Spd/Rot/Acc/Bnk |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| PVSG Ankh | 60 | TurretArmour / Frigate | 30 | 4s | 2x avenger_turret | **46.66** | 0/8 | 0/0 | 0/0 | 8 | 2000/2000 | 0/120/0.11/15 |
| GVSG Edjo | 70 | TurretArmour / Frigate | 45 | 6s | 1x avenger_turret | **23.33** | 0/8 | 0/0 | 0/0 | 8 | 2000/2000 | 0/120/0.11/15 |
| PVNB Geb | 50 | Unarmoured / Utility | 100 | 20s | None | **0** | 0/0 | 0/0 | 0/0 | 0 | 10000/10000 | 500/170/0.11/15 |
| GVS Nephthys | 1000 | LightArmour / Resource | 150 | 9s | None | **0** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 280/95/4/85 |
| PVS Scarab | 1000 | LightArmour / Resource | 150 | 9s | None | **0** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 295/95/4/85 |
| PVFr Bast | 4000 | LightArmour / ResourceLarge | 350 | 22s | 3x subach_turret | **65.01** | 0/0 | 10/0 | 0/0 | 10 | 4000/5000 | 230/50/8/60 |
| PVF Anubis | 300 | Unarmoured / Fighter | 370 | 24s | 1x vll9, 1x miss_rockeye | **25.0** | 12/12 | 0/0 | 0/0 | 12 | 9000/11000 | 330/140/3/85 |
| GVFr Bes | 4500 | LightArmour / ResourceLarge | 400 | 25s | 2x vaslaser_gimble | **43.0** | 0/0 | 10/0 | 0/0 | 10 | 4000/5000 | 210/50/8/60 |
| PVT Isis | 5000 | ResArmour / Resource | 400 | 25s | 2x tercollector_turret | **26.0** | 0/0 | 0/0 | 0/0 | 0 | 3500/4500 | 160/60/3/30 |
| GVC Aten | 18000 | MediumArmour / Frigate | 450 | 30s | 2x vaslaser_turret, 2x vaslaser_gimble, 2x beam_aablue, 2x mekhu_turret | **259.2** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 105/20/10/60 |
| GVC Aten (FS1) | 18000 | MediumArmour / Frigate | 450 | 30s | 2x vaslaser_turret, 2x vaslaser_gimble, 2x mekhu_turret | **105.2** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 105/20/10/60 |
| GVF Horus | 170 | Unarmoured / Fighter | 475 | 32s | 1x prometheusfs1, 1x morningstar, 1x miss_phoenixv, 1x miss_rockeye | **51.34** | 8/8 | 0/0 | 0/0 | 8 | 3000/4000 | 400/100/3/85 |
| GVFr Satis | 10000 | MediumArmour / Frigate | 550 | 35s | 1x vashuge_turret, 4x vaslaser_gimble | **136.0** | 0/0 | 0/0 | 8/0 | 8 | 5000/6000 | 220/40/8/60 |
| GVB Bakha | 440 | LightArmour / Fighter | 570 | 34s | 1x mekhu, 1x miss_Cyclops, 1x miss_stiletto | **141.74** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 260/82/5/85 |
| GVF Seth | 280 | Unarmoured / Fighter | 570 | 35s | 2x Prometheusfs1, 1x miss_hornet, 1x miss_tornado, 1x miss_tempest | **144.17** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 254/80/3/85 |
| GVF Thoth | 240 | Unarmoured / Fighter | 590 | 36s | 1x mekhu, 1x miss_harpoon | **49.6** | 8/8 | 0/0 | 0/0 | 8 | 9000/11000 | 286/133/3/85 |
| GVF Serapis | 220 | Unarmoured / Fighter | 690 | 40s | 1x mekhu, 1x prometheuss, 1x miss_harpoon, 1x miss_empadv | **71.54** | 8/8 | 0/0 | 0/0 | 8 | 3000/4000 | 306/150/3/85 |
| GVB Osiris | 600 | LightArmour / Fighter | 750 | 40s | 1x prometheusfs1, 1x miss_tsunami, 1x miss_synaptic, 2x subach_turret | **129.27** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 228/72/4/85 |
| GVG Anuket | 18000 | MediumArmour / ResourceLarge | 800 | 45s | 2x vaslaser_gimble, 2x subach_turret, 1x flak_turret | **90.69** | 0/5 | 0/0 | 0/0 | 5 | 3500/4500 | 225/18/8/20 |
| PVFr Maat | 18000 | MediumArmour / ResourceLarge | 800 | 45s | 2x vaslaser_gimble, 1x avenger_gimble | **55.8** | 0/5 | 0/0 | 0/0 | 5 | 3500/4500 | 225/18/8/20 |
| GVF Tauret | 300 | Unarmoured / Fighter | 860 | 49s | 1x prometheusR, 1x kayser, 1x miss_tornado, 1x miss_rockeye | **86.42** | 8/2 | 0/6 | 0/6 | 8 | 3000/4000 | 280/81/3/85 |
| GVB Sehkmet | 500 | LightArmour / Fighter | 890 | 46s | 1x prometheusS, 1x miss_Helios, 1x miss_infyrno | **244.5** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 248/90/5/85 |
| GVF Ptah | 90 | Unarmoured / Fighter | 1000 | 65s | 1x mekhu, 1x miss_harpoon, 1x miss_stilettoII | **97.22** | 8/0 | 0/0 | 0/0 | 8 | 9000/11000 | 400/145/2/85 |
| PVB Amun | 625 | LightArmour / Fighter | 1310 | 70s | 1x prometheusfs1, 2x miss_harbinger, 1x miss_infyrno, 2x avenger_turret | **273.12** | 0/0 | 8/0 | 0/8 | 8 | 4000/10000 | 160/60/4/85 |
| GVC Mentu | 18000 | MediumArmour / Frigate | 1475 | 70s | 8x vaslaser_gimble, 1x flak_turret, 1x beam_AABlue, 2x vashuge_turret, 2x vaslaser_turret | **396.35** | 0/12 | 0/0 | 12/0 | 12 | 5000/6000 | 140/12/8/50 |
| PVSC Imhotep | 10000 | MediumArmour / Frigate | 1500 | 35s | 2x vaslaser_gimble, 1x miss_fighterkiller, 2x avenger_gimble | **104.6** | 0/0 | 0/0 | 12/0 | 12 | 5000/6000 | 180/40/8/60 |
| GVA Setekh | 10000 | MediumArmour / Frigate | 1750 | 78s | 2x vaslaser_gimble, 1x vashuge_turret | **93.0** | 0/0 | 0/0 | 12/0 | 12 | 5000/6000 | 165/20/8/20 |
| GVCv Sobek | 85000 | HeavyArmour / SmallCapitalShip | 3000 | 110s | 8x vaslaser_gimble, 4x flak_turret, 4x beam_AABlue, 4x vashuge_turret | **697.4** | 0/0 | 0/0 | 40/30 | 50 | 6500/7500 | 120/12/8/40 |
| GVD Typhon | 80000 | HeavyArmour / BigCapitalShip | 8000 | 175s | 2x vashuge_gimble, 5x flak_turret, 4x miss_fighterkiller, 4x beam_AABlue, 9x vaslaser_gimble, 1x vashuge_turret | **817.25** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 60/4.5/16/10 |
| PVI Karnak | 400000 | HeavyArmour / BigCapitalShip | 10000 | 200s | 21x vaslaser_gimble, 17x miss_fighterkiller | **1063.5** | 0/5 | 0/0 | 15/0 | 20 | 10000/18000 | 0/5/1/10 |
| GVD Typhon (FS1) | 80000 | HeavyArmour / BigCapitalShip | 11000 | 175s | 2x vashuge_gimble, 5x flak_turret, 4x miss_fighterkiller, 13x vaslaser_gimble, 1x vashuge_turret | **595.25** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 60/4.5/16/10 |
| GVD Hatshepsut | 80000 | HeavyArmour / BigCapitalShip | 14000 | 240s | 1x beam_sgold, 5x miss_fluxcannon, 1x heavyflak_turret, 4x beam_AABlue, 6x vashuge_gimble, 10x flak_gimble | **9407.49** | 0/5 | 0/0 | 10/0 | 15 | 5000/6000 | 60/4/20/10 |
| GTVA Colossus | 1000000 | HeavyArmour / BigCapitalShip | 50000 | 500s | 10x terhuge_turret, 12x flak_turret, 8x terlaser_gimble, 10x beam_AABlue, 2x miss_pihrana, 8x miss_rockeye, 7x beam_slashgreen | **29459.2** | 0/0 | 0/5 | 80/60 | 110 | 18000/20000 | 125/3/20/40 |


