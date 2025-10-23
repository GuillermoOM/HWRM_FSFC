function StartWeaponConfig(
    WeaponName="NewWeaponType",
    WeaponType="Gimble|AnimatedTurret|Fixed",
    WeaponFireType="InstantHit|Bullet|Mine|Missile|SphereBurst",
    WeaponFireName="weaponfire_script",
    Activation="Normal|Special Attack|Normal Only|Dropped",
    WeaponFireSpeed="100",
    WeaponFireRage="100",
    WeaponFireRadius="10",
    WeaponFireLifetime="10",
    WeaponFireMisc="10",
    WeaponFireAxis="0|1|2",
    MaxEffectsSpawned="30",
    UseVelocityPred="1|0",
    CheckLineOfFire="1|0",
    FireTime="5",
    BurstFireTime="5",
    BurstWaitTime="5",
    ShootAtSecondaries="1|0",
    ShootAtSurroundings="1|0",
    MaxAzimuthSpeed="100",
    MaxDeclinationSpeed='100',
    SpeedMultiplierWhenPointingAtTarget="0.01",
    WeaponShiledPenetration="Normal|Enhanced|Bypass",
    TrackTargetsOutsideRange="1|0",
    WaitUntilCodeRedState="1|0",
    InstantHitThreshold="2000"
)
end

function AddWeaponResult(
    Weapon="NewWeaponType",
    Condition="Hit|Miss",
    Effect="DamageHealth|Disable|Push|SpawnWeaponFire",
    Target="Target|Owner",
    MinimumEffect="0.0",
    MaximumEffect="0.0",
    SpawnedWeaponEffect="WeaponName"

)
end

function setAngles(
    ObjectType="NewWeaponType",
    TriggerHappy="90",
    MinAzimuth="-180",
    MaxAzimuth="180",
    MinDeclination="-5",
    MaxDeclination="60"
)
end

function setMiscValues(
    ObjectType="NewWeaponType",
    RecoilDistance="0",
    SlaveFireDelay="0"
)
end

function setBallistics(
    WeaponTable="NewWeaponType",
    Enabled="1|0",
    FireAhead="0.01",
    FireBehind="0.01")
end

setPenetration(
	NewWeaponType,
	30,
	1,
	{ Unarmoured = 1 },
	{ Unarmoured_hw1 = 1 },
	{ LightArmour = 1 },
	{ LightArmour_hw1 = 1 },
	{ MediumArmour = 1 },
	{ HeavyArmour = 1 },
	{ SubSystemArmour = 0.3 },
	{ TurretArmour = 0.3 },
	{ ResArmour = 1 },
	{ MoverArmour = 1 },
	{ PlanetKillerArmour = 2 },
	{ MineArmour = 1 },
	{ ChunkArmour = 1 },
	{ ResourceArmour = 1 },
	{ GravityWellArmour = 1 },
	{ SwarmerArmor = 1 },
	{ SpaceMineArmor = 1 },
	{ TorpedoArmor = 1 },
	{ HeavyMissileArmor = 1 },
	{ SmallMissileArmor = 1 })

setAccuracy(
	NewWeaponType,
	1,
	{ Fighter = 0.3 },
	{ Corvette = 0.4 },
	{ Fighter_hw1 = 0.3 },
	{ Corvette_hw1 = 0.4 },
	{ Frigate = 1 },
	{ Utility = 1 },
	{ munition = 0.1 },
	{ SmallCapitalShip = 1 },
	{ BigCapitalShip = 1 },
	{ Mothership = 1 },
	{ Emplacement = 0.5 },
	{ UnAttackable = 0 },
	{ SubSystem = 0 },
	{ Resource = 1 },
	{ ResourceLarge = 1 },
	{ Capturer = 1 },
	{ Chimera = 1 })