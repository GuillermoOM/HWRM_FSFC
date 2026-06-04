import os, glob

music_hook = """

-- [FSFC] Safely inject FS music while preserving all vanilla level generation
local original_NonDetermChunk = NonDetermChunk
function NonDetermChunk()
    if original_NonDetermChunk then original_NonDetermChunk() end

    local ambientTracks = {
        "data:sound/music/fs2_aquits",
        "data:sound/music/fs2_bastion",
        "data:sound/music/fs2_bfield",
        "data:sound/music/fs2_deadspace",
        "data:sound/music/fs2_deadspaceb",
        "data:sound/music/fs2_deuteronomy",
        "data:sound/music/fs2_exodus",
        "data:sound/music/fs2_genesis",
        "data:sound/music/fs2_joshua",
        "data:sound/music/fs2_leviticus",
        "data:sound/music/fs2_numbers",
        "data:sound/music/fs2_revelation",
        "data:sound/music/fs2_vasuda",
        "data:sound/music/fs1_chaser",
        "data:sound/music/fs1_fortress",
        "data:sound/music/fs1_haunted",
        "data:sound/music/fs1_marauder",
        "data:sound/music/fs1_march",
        "data:sound/music/fs1_monolith",
        "data:sound/music/fs1_mystic",
        "data:sound/music/fs1_spook",
        "data:sound/music/fs1_strike",
        "data:sound/music/fs1_threat",
        "data:sound/music/fs1_worldsapart",
        "data:sound/music/fs1_worldsapartalt",
    }
    
    local battleTracks = {
        "data:sound/music/battle/fs2_deuteronomybattle",
        "data:sound/music/battle/fs2_exodusbattle",
        "data:sound/music/battle/fs2_genesisbattle",
        "data:sound/music/battle/fs2_joshuabattle",
        "data:sound/music/battle/fs2_leviticusbattle",
        "data:sound/music/battle/fs2_numbersbattle",
        "data:sound/music/battle/fs2_revelationbattle",
        "data:sound/music/battle/fs1_chaserbattle",
        "data:sound/music/battle/fs1_fortressbattle",
        "data:sound/music/battle/fs1_hauntedbattle",
        "data:sound/music/battle/fs1_marauderbattle",
        "data:sound/music/battle/fs1_marchbattle",
        "data:sound/music/battle/fs1_monolithbattle",
        "data:sound/music/battle/fs1_spookbattle",
        "data:sound/music/battle/fs1_strikebattle",
        "data:sound/music/battle/fs1_threatbattle",
        "data:sound/music/battle/fs1_worldsapartbattle",
    }

    local ambIndex = random(1, getn(ambientTracks))
    local battleIndex = random(1, getn(battleTracks))
    
    setDefaultMusic(ambientTracks[ambIndex])
    setBattleMusic(battleTracks[battleIndex])
end
"""

count = 0
for file in glob.glob('source/leveldata/multiplayer/deathmatchhw2/*.level'):
    with open(file, 'a') as f:
        f.write(music_hook)
    count += 1

print(f"Patched {count} level files with safe Lua music hook!")
