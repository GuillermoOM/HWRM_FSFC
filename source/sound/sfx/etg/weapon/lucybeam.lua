-- LuaDC version 0.9.19
-- 5/23/2004 7:29:12 PM
-- LuaDC by Age2uN
-- on error send source file (compiled lua) and this outputfile to Age2uN@gmx.net
--
version = 4
volume = 0.6
volumeRand = 1
maxPolyphony = 8
envelope = 
    { 
    { 
        distance = 0, 
        volume = 1, 
        reverb = 0, 
        duration = 0, 
        equalizer = 
            { 1, 1, 1, 1, 1, 1, 1, 1, }, }, 
    { 
        distance = 2500, 
        volume = 0.8, 
        reverb = 0, 
        duration = 0, 
        equalizer = 
            { 1, 1, 1, 1, 0.97, 1, 1, 1, }, }, 
    { 
        distance = 4000, 
        volume = 0.6, 
        reverb = 0, 
        duration = 0, 
        equalizer = 
            { 1, 1, 1, 1, 0.84, 0.87, 0.77, 0.81, }, }, 
    { 
        distance = 5500, 
        volume = 0.4, 
        reverb = 0, 
        duration = 0, 
        equalizer = 
            { 1, 1, 1, 0.64, 0.42, 0.31, 0.16, 0, }, }, 
    { 
        distance = 6000, 
        volume = 0.2, 
        reverb = 0, 
        duration = 0, 
        equalizer = 
            { 1, 1, 1, 0, 0, 0, 0, 0, }, }, 
    }
randSampContainer = 0

