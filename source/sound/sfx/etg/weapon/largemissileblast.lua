-- LuaDC version 0.9.19
-- 5/23/2004 7:29:12 PM
-- LuaDC by Age2uN
-- on error send source file (compiled lua) and this outputfile to Age2uN@gmx.net
--
version = 4
volume = 1
volumeRand = 0.2
maxPolyphony = 8
envelope =
{
    {
        distance = 0,
        volume = 0.7,
        reverb = 0,
        duration = 0,
        equalizer =
        { 1, 1, 1, 1, 1, 1, 1, 1, },
    },
    {
        distance = 700,
        volume = 0.6,
        reverb = 0,
        duration = 0,
        equalizer =
        { 1, 1, 1, 1, 1, 0.89, 0.8, 0.61, },
    },
    {
        distance = 1500,
        volume = 0.4,
        reverb = 0,
        duration = 0,
        equalizer =
        { 1, 1, 1, 1, 0.7, 0.67, 0.69, 0.56, },
    },
    {
        distance = 2500,
        volume = 0.2,
        reverb = 0,
        duration = 0,
        equalizer =
        { 1, 1, 1, 1, 0.71, 0.56, 0.46, 0.29, },
    },
    {
        distance = 3500,
        volume = 0,
        reverb = 0,
        duration = 0,
        equalizer =
        { 1, 1, 1, 1, 0.4, 0, 0, 0, },
    },
}
randSampContainer = 0
