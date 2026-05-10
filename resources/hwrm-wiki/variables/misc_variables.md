# Miscellaneous Variables

> Reference for configuration variables relating to Research, Resources, Speech/Audio logic, and Profiles.

---

## Research Variables (`research.lua`)

Defines the technology tree and unlockable upgrades for a race. Each research node is defined as a table.

- **Name**: The internal identifier of the research item.
- **RequiredResearch**: A string defining dependencies. Can use logical operators: `"ResearchA | ResearchB"` (OR) or `"ResearchA & ResearchB"` (AND).
- **RequiredSubSystems**: Similar to `RequiredResearch`, but checks for active subsystems on ships instead.
- **Cost**: RU cost to start the research.
- **Time**: Seconds to complete.
- **DisplayedName / ShortDisplayedName**: Localization string IDs (e.g., `"$1234"`).
- **DisplayPriority**: Order in the Research Manager UI. **Must be unique**, unless defining sequential upgrade tiers (e.g., Health 1 then Health 2).
- **UpgradeType**: Either `Ability` (unlocks a new capability) or `Modifier` (changes a stat).
- **TargetType**: `AllShips`, `Family`, or `Ship`. Defines the scope of the upgrade.
- **TargetName**: The specific ship (`Hgn_TorpedoFrigate`) or family (`Fighter`) receiving the upgrade.
- **UpgradeName**: The stat to modify (e.g., `MAXSPEED`, `MAXHEALTH`) or ability to unlock (e.g., `UseSpecialWeaponsInNormalAttack`).
- **UpgradeValue**: The multiplier applied to the target stat. Note that multipliers are **not** cumulative; a new research upgrade replaces the previous multiplier.
- **Icon**: Visual UI icon (`Icon_Speed`, `Icon_Health`, `Icon_Tech`, etc.).

---

## Resource & Environment Node Variables

Variables defined in asteroid, salvage, and nebula configuration files.

### Asteroids (`.asteroid`)
```lua
NewResourceType = StartAsteroidConfig()
NewResourceType.resourceValue = 0
```

### Salvage (`.salvage`)
```lua
NewResourceType = StartSalvageConfig()
NewResourceType.resourceValue = 3000
NewResourceType.salvageSpeedFraction = 0.4
NewResourceType.blobRadius = 1000
```

### Dust Clouds (`.dustcloud`)
```lua
NewResourceType = StartDustCloudConfig()
NewResourceType.lightningEffectName = "lightning_combo"
NewResourceType.chargedLightningEffectName = "lightning_charged"
NewResourceType.damageMultiplier = 1
```

### Nebulas (`.nebula`)
```lua
NewNebulaType = StartNebulaConfig()
NewNebulaType.damageMultiplier = 0
```

---

## Audio & Speech Logic (`Data/SoundScripts/`)

Speech scripts map audio events to game states and localize chatter.

### SpeechLogicStatus (`status.html`)
Defines enumerated events for the Intel/Status system.
- `CD_MissileIncoming = 1`
- `CD_DefenseFieldFound = 2`

### SpeechLogicEventText (`eventtext.lua`)
Maps internal event triggers to localization strings for the UI event log.
- `STATUS_FRIGATEDIES_1 = "$5600"`
- `STATUS_CARRIERDIES_1 = "$5603"`

### SpeechLogicCommands (`commands.lua`)
Defines states for command chatter.
- `DEF_on = 0`, `DEF_off = 1`, `DEF_out = 2`, `DEF_low = 3`
