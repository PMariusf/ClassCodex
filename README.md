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
- Saved window position

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

## Development plan

1. Test the active Talents / Hero Talents reader in Retail.
2. Improve talent sorting/grouping and add richer WoW-style UI components.
3. Add recommended talent-build data alongside the player's current loadout.
4. Add Assassination and Outlaw.
5. Use Rogue as the template for all remaining classes and specs.
6. Add optional content-mode profiles such as Mythic+, Raid and Open World.

## Important

Class Codex is intended as a reference and learning addon. Recommended stats and rotations should be versioned by patch and treated as guidance rather than a replacement for character-specific simulation.
