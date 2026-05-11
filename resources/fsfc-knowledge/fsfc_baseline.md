# FSFC Project Baseline (Current Mod State)

This document establishes the baseline of what is currently implemented in the **Freespace: Fleet Command** mod. Use this as a reference before migrating or adding new features from the original mod.

## 1. AI Architecture Baseline

The AI now uses a custom override of the vanilla Homeworld Remastered engine to support the specific needs of Freespace gameplay.

- **Custom Engine Overrides**:
  - `source/ai/default/cpubuild.lua`: Removes rigid HW2 research dependencies and adds the `Util_PickBestShip` logic for era-aware construction.
  - `source/ai/default/cpuresource.lua`: Optimized resourcing with era-aware collector fallbacks.
- **Dynamic Era Variables**:
  - The AI now uses `k*FS1` and `k*FS2` variables in `ai_build.lua`.
  - `CpuBuild_UpdateRaceVariables()` is called every cycle to ensure the AI targets the best buildable ship for the current match settings.

## 2. Research Baseline (Active Nodes)

The following research nodes are currently active and recognized by the engine.

### Terran (GTA/GTVA)

- **Eras**: `FS1`, `FS2`
- **Tech**: `FighterDesign`, `BomberDesign`, `CapitalShipDesign`, `AdvancedSuperiority`, `AntiFighterMissiles`, `AntiBomberMissiles`, `MultiRoleSwarmMissiles`, `AdvancedResearch`, `HeavyCruiser`
- **Fighters**: Perseus, Apollo, Myrmidon, Hercules (Mk1/Mk2), Ares, Erinyes, Valkyrie, Pegasus, Loki, Ulysses.
- **Bombers**: Artemis (Std/DH), Medusa, Ursa, Boanerges, Athena, Zeus.
- **Warships**: Fenris, Leviathan, Aeolus, Deimos, Orion, Hecate, Hades, Colossus.
- **Installations**: Arcadia, Faustus.
- **Utility**: Elysium (Collector), Zephyrus (Refinery), Argo (Transport), Poseidon (Freighter), Charybdis (AWACS), Hygeia (Repair), Chronos (Collector), Centaur (Support).
- **Platforms**: Mjolnir (Beam), Alastor (Sentry), Pharos (Nav Buoy).

### Vasudan (PVE/PVN)

- **Eras**: `FS1`, `FS2`
- **Tech**: `FighterDesign`, `BomberDesign`, `CapitalShipDesign`, `CruiserDesign`, `SuperCapitalShipDesign`
- **Fighters**: Serapis, Horus, Thoth, Tauret.
- **Bombers**: Sehkmet, Bakha, Osiris, Seth.
- **Warships**: Aten, Mentu, Sobek, Typhon, Hatshepsut, Colossus.
- **Installations**: Karnak.
- **Utility**: Isis (Collector), Anuket (Refinery), Satis (Freighter), Bes (Transport), Setekh (AWACS), Nephthys (Support), Geb (Freighter), Maat (Freighter), Scarab (Support), Imhotep (Research).
- **Platforms**: Bast (Sentry).

### Shivan

- **Eras**: `FS1`, `FS2`
- **Tech**: `FighterDesign`, `BomberDesign`, `CruiserDesign`, `CapitalShipDesign`, `SuperCapitalShipDesign`
- **Fighters**: Astaroth, Scorpion, Manticore, Basilisk, Mara, Dragon.
- **Bombers**: Nahema, Taurvi, Nephilim, Seraphim, Shaitan.
- **Warships**: Rakshasa, Cain, Lilith, Moloch, Demon, Ravana, Sathanas, Lucifer.
- **Installations**: Comm Node.
- **Utility**: Azrael (Collector), Rahu (Refinery), Gorgon (Support), Trident (Transport).
- **Platforms**: Mephisto (Sentry), Belial (Sentry), Asmodeus (Sentry).

## 3. Subsystem Baseline

The following subsystems are currently defined in the `source/subsystem/` directory and buildable.

- **Production**: `FighterProduction`, `BomberProduction`, `FrigateProduction`, `CapShipProduction`
- **Sensors**: `AdvancedSensors`, `AWACS`, `Cloak`
- **Research**: `Research`, `AdvancedResearch`
- **Misc**: `ShieldGenerator`, `EngineSubsystem`, `WeaponSubsystem`

## 4. Ship Class & AI Role Mapping

FreeSpace ship classes are "shifted" when mapped to the Homeworld engine to ensure the AI uses them correctly (e.g., FS Corvettes are handled as HW Frigates due to their size and firepower).

### Strike Craft (Small Ships)

| FreeSpace Class            | HW Engine Type | AI Role                        | Example Ships                    |
| -------------------------- | -------------- | ------------------------------ | -------------------------------- |
| **Interceptor**            | `eFighter`     | Anti-Interceptor / Anti-Bomber | Perseus, Apollo, Horus, Scorpion |
| **Space Superiority**      | `eFighter`     | General combat / Escort        | Myrmidon, Valkyrie, Serapis      |
| **Assault / Heavy Bomber** | `eCorvette`    | Anti-Capital / Siege           | Ursa, Artemis, Seth, Shaitan     |

### Capital Ships (Large Ships)

| FreeSpace Class                   | HW Engine Type   | AI Role                     | Example Ships                        |
| --------------------------------- | ---------------- | --------------------------- | ------------------------------------ |
| **Cruiser / Corvette**            | `eFrigate`       | Fleet Backbone / Screening  | Deimos, Fenris, Sobek, Moloch        |
| **Destroyer / Carrier**           | `eDestroyer`     | Mobile Base / Heavy Assault | Hecate, Orion, Typhon, Demon, Ravana |
| **Super Destroyer / Juggernauts** | `eBattleCruiser` | Flagship / Endgame Siege    | Hades, Colossus, Lucifer, Sathanas   |

## 5. Key Ships by Era (AI Logic Targets)

The AI dynamically targets these specific ships based on which Era is active in the game rules.

| Role (AI Variable) | Terran (FS2 / FS1)          | Vasudan (FS2 / FS1) | Shivan (FS2 / FS1)       |
| ------------------ | --------------------------- | ------------------- | ------------------------ |
| `kScout`           | Loki                        | Ptah                | Scorpion                 |
| `kInterceptor`     | Perseus / Valkyrie          | Serapis / Horus     | Astaroth / Manticore     |
| `kHeavyFighter`    | HerculesMkII / Hercules     | Tauret / Thoth      | Mara / Basilisk          |
| `kBomber`          | Medusa / Artemis            | Sehkmet / Seth      | Nahema / Shaitan         |
| `kFrigate`         | Fenris / Aeolus / Leviathan | Aten / Amun         | Rakshasa / Cain / Lilith |
| `kDestroyer`       | Deimos / Leviathan          | Sobek / Aten        | Moloch / Lilith          |
| `kCarrier`         | Hecate / Orion              | Typhon / Harshepsut | Demon / Ravana           |
| `kBattleCruiser`   | Hades / Colossus            | Colossus            | Sathanas / Lucifer       |

---

> [!IMPORTANT]
> **Constraint**: Do not add new ships or research nodes to this list unless they are fully implemented with HOD models and `def_build.lua` entries.
