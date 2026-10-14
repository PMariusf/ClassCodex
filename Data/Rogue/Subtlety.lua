local addonName, CC = ...

CC.data.ROGUE = CC.data.ROGUE or {}

CC.data.ROGUE[261] = {
    title = "Subtlety",
    subtitle = "Rogue",

    overview = {
        "Burst-focused melee specialization built around stealth windows, combo points and finishers.",
        "Patch 12.x Subtlety centers its major damage around Shadow Dance, Secret Technique, Shadow Blades and Deathstalker/Trickster Hero Talent interactions.",
    },

    opener = {
        { spell = "Shadowstrike", text = "Open from Stealth with Shadowstrike to apply Deathstalker's Mark." },
        { spell = "Goremaw's Bite", text = "Use Goremaw's Bite just before your major burst cooldowns when available." },
        { spell = "Shadow Dance", text = "Enter Shadow Dance when Secret Technique is ready or Shadow Blades is active." },
        { spell = "Shadow Blades", text = "Use Shadow Blades during Shadow Dance." },
        { spell = "Secret Technique", text = "Cast Secret Technique during Shadow Dance at high Combo Points." },
        { spell = "Eviscerate", text = "Spend at high Combo Points; prioritize Darkest Night empowered Eviscerate when active." },
    },

    singleTarget = {
        { spell = "Goremaw's Bite", text = "Use Goremaw's Bite before your other cooldowns when ready." },
        { spell = "Shadow Dance", text = "Use Shadow Dance around Secret Technique and Shadow Blades windows." },
        { spell = "Shadow Blades", text = "Use Shadow Blades during Shadow Dance." },
        { spell = "Secret Technique", text = "Use Secret Technique during Shadow Dance with 6+ Combo Points." },
        { spell = "Coup de Grace", text = "Use Coup de Grace with high Combo Points when available." },
        { spell = "Eviscerate", text = "Primary single-target finisher at high Combo Points." },
        { spell = "Shadowstrike", text = "Use Shadowstrike whenever available; otherwise build with Backstab." },
    },

    aoe = {
        { spell = "Goremaw's Bite", text = "Use Goremaw's Bite before your major AoE burst window." },
        { spell = "Shadow Dance", text = "Use Shadow Dance when Secret Technique or Shadow Blades can be paired with it." },
        { spell = "Secret Technique", text = "Use Secret Technique during Shadow Dance with high Combo Points." },
        { spell = "Black Powder", text = "Use Black Powder as the main AoE finisher at high Combo Points." },
        { spell = "Shuriken Storm", text = "Use Shuriken Storm to build Combo Points on multiple targets." },
        { spell = "Eviscerate", text = "Use empowered Eviscerate for priority-target damage when appropriate." },
    },

    stats = {
        priority = {
            "Item Level / Agility",
            "Mastery",
            "Haste — aim roughly for 700–1100 rating in Season 2",
            "Versatility",
            "Critical Strike",
        },
        note = "General Patch 12.1.5 guidance. Your best upgrade can vary by build and gear, so simming remains more accurate than following a fixed stat order.",
    },

    recommendedBuilds = {
        raid = {
            key = "raid",
            label = "Raid",
            name = "Deathstalker — Raid / Single Target",
            heroTree = "Deathstalker",
            patch = "12.1.5",
            source = "Icy Veins / current Midnight Season 2 guidance",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMDDzMzMzw8AbzYGbbzMzMzMjBjZ2GAAAAGMmFzyADYBsMMBmFMDzMAzYA",
            note = "Recommended for raid and single-target. Current 12.1.5 guidance continues to favor Deathstalker for most raid encounters.",
        },
        mythicplus = {
            key = "mythicplus",
            label = "Mythic+",
            name = "Deathstalker — High-key Mythic+",
            heroTree = "Deathstalker",
            patch = "12.1.5",
            source = "Icy Veins / current Midnight Season 2 guidance",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbLjxMDjZmZmZGGbzYGbbzMzMzMjBjZ2GAAAAGMmFzyADYBsMMBmFMDzMAzYA",
            note = "Recommended for higher keys when priority-target damage and sustained AoE matter. Trickster remains a viable burst-oriented alternative for weekly keys.",
            alternative = {
                name = "Trickster — Weekly Mythic+",
                heroTree = "Trickster",
                importString = "CUQA5HmDzx68KWyrW/8Y781L7Dgx2MAAAAAwsMGLTMbLjxMMjZmZmZGGbzYGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA",
            },
        },
    },

    defensives = {
        "Feint — frequent mitigation for predictable incoming damage.",
        "Cloak of Shadows — strong magic defensive and removal tool.",
        "Evasion — avoidance against many physical attacks.",
        "Crimson Vial — personal self-heal.",
        "Vanish — defensive utility and access to stealth tools.",
    },

    utility = {
        "Kick — interrupt.",
        "Sap — pre-combat crowd control.",
        "Blind — long crowd control.",
        "Cheap Shot / Kidney Shot — stuns.",
        "Shiv — class utility depending on effects and talents.",
        "Distract — useful pre-combat enemy positioning tool.",
    },

    macros = {
        {
            name = "Focus Kick",
            body = "#showtooltip Kick\n/cast [@focus,exists,harm,nodead][] Kick",
        },
        {
            name = "Mouseover Tricks",
            body = "#showtooltip Tricks of the Trade\n/cast [@mouseover,help,nodead][@focus,help,nodead][] Tricks of the Trade",
        },
    },
}
