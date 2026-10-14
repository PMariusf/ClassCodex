local addonName, CC = ...

CC.data.ROGUE = CC.data.ROGUE or {}

CC.data.ROGUE[260] = {
    title = "Outlaw",
    subtitle = "Rogue",

    overview = {
        "Fast-paced sustained melee specialization built around Combo Point spending, cooldown reduction and cleave.",
        "Outlaw rewards constant resource flow and clean execution more than saving everything for one huge burst window.",
    },

    opener = {
        "Enter combat with your core maintenance buffs prepared when possible.",
        "Activate Adrenaline Rush early enough to gain full value from the opening window.",
        "Build and spend Combo Points quickly to start Restless Blades cooldown reduction.",
        "Use Between the Eyes and other finishers without wasting Combo Points.",
        "Keep the rotation flowing instead of pooling excessively unless a mechanic requires it.",
    },

    singleTarget = {
        "Keep your core maintenance buffs active and avoid unnecessary downtime.",
        "Spend Combo Points frequently to benefit from Restless Blades cooldown reduction.",
        "Avoid capping Energy and Combo Points.",
        "Use finishers at the correct Combo Point threshold for your active talents and Hero Talent setup.",
        "Maintain high uptime: Outlaw gains value from sustained execution rather than long idle pooling periods.",
    },

    aoe = {
        "Maintain Blade Flurry whenever cleave targets are present and will live long enough.",
        "Continue the normal Combo Point builder/finisher flow while cleaving through Blade Flurry.",
        "Avoid overpaying for Blade Flurry on very short-lived or low-target situations.",
        "Use priority-target finishers while letting cleave handle surrounding enemies.",
        "Keep cooldown reduction rolling by spending Combo Points consistently.",
    },

    stats = {
        priority = {
            "Item Level / Agility",
            "Critical Strike — aim roughly toward 40% before its value drops",
            "Haste — around 25% for Mythic+; raid setups can value closer to 30%",
            "Versatility",
            "Mastery",
        },
        note = "Patch 12.1.5 guidance. Crit and Haste are the key secondaries, with Haste losing value after the GCD breakpoint range during Adrenaline Rush. Sim your character for exact gearing choices.",
    },

    recommendedBuilds = {
        raid = {
            key = "raid",
            label = "Raid",
            name = "Trickster — Single Target / Raid",
            heroTree = "Trickster",
            patch = "12.1.5",
            source = "Icy Veins — current 12.1.5 talents",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMmZmtZmZmZMmF4BmZbaZw2MAAAAAALLzMzwMzMziZmZbAAAAYmBAjZxwADMLsQLsxAMzgBG",
            note = "Trickster is the recommended high-end single-target/raid option in current 12.1.5 tuning.",
        },
        mythicplus = {
            key = "mythicplus",
            label = "Mythic+",
            name = "Trickster — AoE / Mythic+",
            heroTree = "Trickster",
            patch = "12.1.5",
            source = "Icy Veins — current 12.1.5 talents",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMjZmtZmZMzMzsAmZbaZw2MAAAAAALLzMzwMzMziZmZbAAAAYmBAjZxwADMLsQLsxAMzgBG",
            note = "Recommended Mythic+ setup. Trickster has the stronger AoE ceiling in current tuning, while Fatebound remains a viable lower-complexity alternative.",
        },
    },

    defensives = {
        "Feint — frequent mitigation for predictable incoming damage.",
        "Cloak of Shadows — strong magic defensive and removal tool.",
        "Evasion — avoidance against many physical attacks.",
        "Crimson Vial — personal self-heal.",
        "Vanish — defensive escape and access to stealth tools when appropriate.",
    },

    utility = {
        "Kick — interrupt.",
        "Sap — pre-combat crowd control.",
        "Blind — long crowd control.",
        "Cheap Shot / Kidney Shot — stuns and control.",
        "Grappling Hook — strong mobility and repositioning tool.",
        "Distract — useful pre-combat positioning and patrol control.",
    },

    macros = {
        {
            name = "Cursor Grappling Hook",
            body = "#showtooltip Grappling Hook\n/cast [@cursor] Grappling Hook",
        },
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
