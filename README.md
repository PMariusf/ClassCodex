# Class Codex

Class Codex is an in-game World of Warcraft Retail reference addon for class, specialization, talents, stats, rotation notes, defensives, utility and macros.

## Current development version

`0.3.0-dev`

The current working implementation now covers all three Rogue specializations:

- Assassination
- Outlaw
- Subtlety

## Features

- `/codex` and `/classcodex` slash commands
- Automatic class and specialization detection
- Active talent config detection
- Active Hero Talent tree detection
- Reads selected talent nodes from the active loadout
- Reads selected Hero Talents from the active Hero Talent subtree
- Generates the active talent import string through the Retail API
- Raid / Mythic+ recommended-build selector
- Exact active-loadout comparison against the selected recommendation
- Recommended build import codes with click-to-select fields
- Ability-icon rows for Opener, Single Target and AoE priorities
- Ability tooltips on rotation rows when the Retail spell API resolves the spell
- Talent rows with spell icons and ranks
- Spell tooltip on talent hover when a spell ID is available
- Scrollable content area for long pages
- Draggable in-game window
- Overview
- Opener
- Single Target
- AoE
- Stats
- Talents
- Hero Talents
- Defensives
- Utility
- Macros
- Saved window position and recommended content mode

## Project structure

```text
ClassCodex/
├── ClassCodex.toc
├── Core.lua
├── Core/
│   ├── Player.lua
│   ├── Database.lua
│   └── Talents.lua
├── Data/
│   └── Rogue/
│       ├── Assassination.lua
│       ├── Outlaw.lua
│       └── Subtlety.lua
└── UI/
    ├── MainFrame.lua
    └── Pages.lua
```

## Install for testing

Copy the repository folder into:

```text
World of Warcraft/_retail_/Interface/AddOns/ClassCodex
```

Restart WoW or reload the UI, then type:

```text
/codex
```

Reset the saved window position with:

```text
/codex reset
```

## Recommended build data

Rogue recommendations are patch-versioned for Patch 12.1.5 / Midnight Season 2. The addon compares the full active talent export string against the chosen recommendation, so an exact-match result represents the complete class/spec/Hero Talent loadout rather than a partial name-based comparison.

Current profiles include:

- Assassination: Fatebound Raid and Mythic+
- Outlaw: Trickster Raid/Single Target and Mythic+/AoE
- Subtlety: Deathstalker Raid and high-key Mythic+, with a Trickster Mythic+ alternative

Recommended build information should be reviewed whenever Blizzard tuning or talent changes land.

## Rotation presentation

Rotation entries can now carry a Retail spell name as metadata. Class Codex resolves the spell at runtime through `C_Spell.GetSpellInfo`, displays its icon, and provides a normal WoW spell tooltip on hover. If a spell cannot be resolved, the guide text still renders with a question-mark icon instead of failing.

Subtlety rotation notes were refreshed for the current 12.x design; removed abilities such as Symbols of Death are no longer referenced.

## Development plan

1. Test all three Rogue specs, the active Talents / Hero Talents reader, exact build comparison and ability-icon rows in Retail.
2. Improve talent sorting/grouping and add richer WoW-style UI components.
3. Add cooldown/resource callouts and more compact visual rotation cards.
4. Use Rogue as the template for the remaining classes and specs.
5. Add optional additional content profiles such as Delves and alternative raid encounters.

## Offline development note

The addon can be developed and reviewed without World of Warcraft installed. Runtime API behavior and visual layout still require an in-game verification pass before a release is considered stable.

## Important

Class Codex is intended as a reference and learning addon. Recommended stats, talents and rotations are patch-specific guidance rather than a replacement for character-specific simulation.

No packaged downloads are produced during development; GitHub remains the single source of truth until a tested release is ready.
