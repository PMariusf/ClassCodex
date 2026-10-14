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
        "Keep your important bleeds and poison-related effects active on the primary target.",
        "Avoid capping Energy and Combo Points, but do not spend so aggressively that you starve your next setup window.",
        "Use finishers at high Combo Points whenever practical.",
        "Pool resources ahead of planned burst and cooldown windows.",
        "Prefer target uptime and clean damage-over-time maintenance over frantic button usage.",
    },

    aoe = {
        "Spread your important bleeds across targets that will live long enough to justify the setup time.",
        "Use Fan of Knives-style multi-target generation efficiently without overcapping Combo Points.",
        "Prioritize the dangerous target while maintaining useful damage-over-time coverage on the pack.",
        "Do not spend globals applying long-duration effects to enemies that are about to die.",
        "Pool resources before important priority-target or pack burst windows.",
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
        "Shiv — valuable poison/enrage-related utility depending on encounter and talents.",
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
