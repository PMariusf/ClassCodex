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
        "Enter from Stealth and establish your core bleed/poison effects immediately.",
        "Avoid wasting Combo Points while setting up the first finisher cycle.",
        "Pool Energy before major cooldown windows instead of entering them nearly empty.",
        "Align your major offensive cooldowns only when the target will live long enough for the full effect.",
        "Refresh important damage-over-time effects before they expire, but avoid clipping large portions of their duration unnecessarily.",
    },

    singleTarget = {
        "Keep Rupture and Garrote active on the primary target.",
        "Chain Envenom casts cleanly and refresh late rather than letting the buff fall unnecessarily.",
        "Avoid capping Energy and Combo Points while preserving enough resources for upcoming cooldown windows.",
        "Use Kingsbane and Deathmark on cooldown when the target will survive their full value.",
        "Prefer target uptime and clean damage-over-time maintenance over frantic button usage.",
    },

    aoe = {
        "Spread your important bleeds across targets that will live long enough to justify the setup time.",
        "Use Crimson Tempest to establish or spread bleed pressure before settling into your AoE builder flow.",
        "Use Fan of Knives efficiently without overcapping Combo Points.",
        "Prioritize the dangerous target while maintaining useful damage-over-time coverage on the pack.",
        "Do not spend globals applying long-duration effects to enemies that are about to die.",
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
