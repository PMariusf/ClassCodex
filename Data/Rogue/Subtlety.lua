local addonName, CC = ...

CC.data.ROGUE = CC.data.ROGUE or {}

CC.data.ROGUE[261] = {
    title = "Subtlety",
    subtitle = "Rogue",

    overview = {
        "Burst-focused melee specialization built around stealth windows, combo points and finishers.",
        "Class Codex is designed as an in-game learning and reference guide.",
    },

    opener = {
        "Enter combat from Stealth.",
        "Build resources for the first burst window.",
        "Align Symbols of Death with your planned burst.",
        "Use Shadow Dance to access stealth abilities.",
        "Spend Combo Points efficiently and avoid resource waste.",
    },

    singleTarget = {
        "Avoid capping Energy.",
        "Avoid wasting Combo Points.",
        "Maintain important effects when appropriate.",
        "Plan major cooldowns around burst windows.",
        "Use your strongest finisher at high Combo Points.",
    },

    aoe = {
        "Generate Combo Points efficiently across the pack.",
        "Use AoE finishers when target count makes them worthwhile.",
        "Plan Shadow Dance for important packs.",
        "Keep resources available for priority targets.",
    },

    stats = {
        priority = {
            "Item Level / Agility",
            "Mastery",
            "Haste — aim roughly for the current recommended breakpoint/range",
            "Versatility",
            "Critical Strike",
        },
        note = "General Patch 12.1.5 guidance. Your best upgrade can vary by build and gear, so simming remains more accurate than following a fixed stat order.",
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
