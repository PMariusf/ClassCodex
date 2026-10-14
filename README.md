# Class Codex

Class Codex is an in-game World of Warcraft Retail reference addon for class, specialization, talents, stats, rotation notes, defensives, utility and macros.

## Current development version

`0.3.0-dev`

The current working implementation focuses on **Rogue / Subtlety** as the first complete spec template.

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
- Mythic+ alternative build support
- Talent rows with spell icons and ranks
- Spell tooltip on talent hover when a spell ID is available
- Scrollable content area for long talent lists
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

The current Subtlety template includes Raid and Mythic+ recommendations for Patch 12.1.5 / Midnight Season 2. The addon compares the full active talent export string against the chosen recommendation, so an exact-match result represents the complete class/spec/Hero Talent loadout rather than a partial name-based comparison.

The primary profiles currently use Deathstalker for Raid and high-key Mythic+. Trickster is included as a Mythic+ alternative for a more burst-oriented weekly-key profile.

Recommended build information is patch-versioned and should be reviewed whenever Blizzard tuning or talent changes land.

## Development plan

1. Test the active Talents / Hero Talents reader and exact build comparison in Retail.
2. Improve talent sorting/grouping and add richer WoW-style UI components.
3. Add Assassination and Outlaw.
4. Use Rogue as the template for all remaining classes and specs.
5. Add optional additional content profiles such as Delves and alternative raid encounters.

## Offline development note

The addon can be developed and reviewed without World of Warcraft installed. Runtime API behavior and visual layout still require an in-game verification pass before a release is considered stable.

## Important

Class Codex is intended as a reference and learning addon. Recommended stats, talents and rotations are patch-specific guidance rather than a replacement for character-specific simulation.

No packaged downloads are produced during development; GitHub remains the single source of truth until a tested release is ready.
