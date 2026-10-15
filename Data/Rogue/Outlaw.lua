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
        { spell = "Adrenaline Rush", text = "Use Adrenaline Rush immediately before or at the pull, ideally at low Combo Points." },
        { spell = "Roll the Bones", text = "Apply Roll the Bones before the pull when possible." },
        { spell = "Slice and Dice", text = "Have Slice and Dice active as the fight begins." },
        { spell = "Between the Eyes", text = "Use Between the Eyes on cooldown at 6+ Combo Points." },
        { spell = "Preparation", text = "Use Preparation to reset Adrenaline Rush, Between the Eyes and other key cooldowns when talented." },
        { spell = "Dispatch", text = "Use Dispatch as the fallback finisher when no higher-priority finisher is ready." },
    },

    singleTarget = {
        { spell = "Adrenaline Rush", text = "Use Adrenaline Rush on cooldown at low Combo Points." },
        { spell = "Between the Eyes", text = "Use Between the Eyes on cooldown with 6+ Combo Points." },
        { spell = "Killing Spree", text = "Use Killing Spree on cooldown with high Combo Points when talented and safe." },
        { spell = "Dispatch", text = "Use Dispatch as your main finisher when other finishers are unavailable." },
        { spell = "Pistol Shot", text = "Use Pistol Shot to consume Opportunity stacks efficiently." },
        { spell = "Sinister Strike", text = "Use Sinister Strike as your default Combo Point builder." },
    },

    aoe = {
        { spell = "Blade Flurry", text = "Maintain Blade Flurry whenever cleave targets are present and will live long enough." },
        { spell = "Between the Eyes", text = "Keep using Between the Eyes on the priority target at high Combo Points." },
        { spell = "Dispatch", text = "Continue your normal finisher flow while Blade Flurry cleaves surrounding targets." },
        { spell = "Pistol Shot", text = "Use Opportunity-enhanced Pistol Shot efficiently without overcapping Combo Points." },
        { spell = "Sinister Strike", text = "Use Sinister Strike to maintain your normal builder/finisher rhythm." },
        { spell = "Adrenaline Rush", text = "Keep Adrenaline Rush cycling to sustain resource flow and cooldown reduction." },
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
