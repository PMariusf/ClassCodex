local addonName, CC = ...

CC.data.ROGUE = CC.data.ROGUE or {}

CC.data.ROGUE[259] = {
    title = "Assassination",
    subtitle = "Rogue",

    overview = {
        "Damage-over-time melee specialization focused on bleeds, poisons and deliberate burst windows.",
        "Assassination rewards planning: establish your damage-over-time effects, pool resources and commit cooldowns when they can run their full value.",
    },

    opener = {
        { spell = "Garrote", text = "Open from Stealth with Garrote." },
        { spell = "Mutilate", text = "Build to 5+ Combo Points with Mutilate." },
        { spell = "Rupture", text = "Apply Rupture at 5+ Combo Points." },
        { spell = "Garrote", text = "Refresh Garrote during the Improved Garrote window." },
        { spell = "Envenom", text = "Build again and cast Envenom at high Combo Points." },
        { spell = "Deathmark", text = "Use Deathmark once your core bleeds are established." },
        { spell = "Kingsbane", text = "Follow with Kingsbane and continue the Envenom/Mutilate cycle." },
    },

    singleTarget = {
        { spell = "Rupture", text = "Keep Rupture active on the primary target." },
        { spell = "Garrote", text = "Keep Garrote active and refresh intelligently." },
        { spell = "Envenom", text = "Chain Envenom cleanly at high Combo Points and avoid waste." },
        { spell = "Kingsbane", text = "Use Kingsbane on cooldown when the target will live for the full effect." },
        { spell = "Deathmark", text = "Use Deathmark on cooldown with your core damage-over-time effects established." },
        { spell = "Mutilate", text = "Use Mutilate as your primary single-target Combo Point builder." },
    },

    aoe = {
        { spell = "Garrote", text = "Spread Garrote to targets that will live long enough to justify it." },
        { spell = "Rupture", text = "Maintain Rupture on durable priority targets." },
        { spell = "Crimson Tempest", text = "Use Crimson Tempest for multi-target bleed pressure when appropriate." },
        { spell = "Fan of Knives", text = "Use Fan of Knives to build Combo Points efficiently on packs." },
        { spell = "Envenom", text = "Use Envenom for priority-target pressure and poison amplification." },
        { spell = "Deathmark", text = "Commit Deathmark to important priority targets or high-value pack windows." },
    },

    stats = {
        priority = {
            "Item Level / Agility",
            "Critical Strike",
            "Haste",
            "Mastery",
            "Versatility",
        },
        note = "Patch 12.1.5 guidance: Assassination generally wants Crit and Haste, with Mastery close behind and Versatility typically weakest. There is no fixed Haste breakpoint; sim your character for final gearing decisions.",
    },

    recommendedBuilds = {
        raid = {
            key = "raid",
            label = "Raid",
            name = "Fatebound — Raid",
            heroTree = "Fatebound",
            patch = "12.1.5",
            source = "Icy Veins — Beginner Raid build",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAY2GsNDAAAAAIbzMzMzMjxyMzMbzsMzMPwYMzYMmZGjBYzsMwAWALDTghFDmZAGjB",
            note = "Balanced Fatebound raid setup with strong single-target plus useful cleave/AoE coverage.",
        },
        mythicplus = {
            key = "mythicplus",
            label = "Mythic+",
            name = "Fatebound — Mythic+",
            heroTree = "Fatebound",
            patch = "12.1.5",
            source = "Icy Veins — Beginner Mythic+ build",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAY2GsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAbmlBGwCYZYCMsYwMDwYMA",
            note = "Mythic+ setup focused on strong priority-target damage while retaining useful AoE pressure.",
        },
    },

    defensives = {
        "Feint — frequent mitigation for predictable incoming damage.",
        "Cloak of Shadows — strong magic defensive and removal tool.",
        "Evasion — avoidance against many physical attacks.",
        "Crimson Vial — personal self-heal.",
        "Vanish — defensive escape, threat drop and access to stealth utility when appropriate.",
    },

    utility = {
        "Kick — interrupt.",
        "Sap — pre-combat crowd control.",
        "Blind — long crowd control.",
        "Cheap Shot / Kidney Shot — stuns and control.",
        "Shiv — poison/enrage-related utility; in current 12.1.x PvE it is primarily utility rather than a core DPS button.",
        "Distract — useful pre-combat positioning and patrol control.",
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
