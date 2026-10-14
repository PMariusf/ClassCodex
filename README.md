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
- Draggable in-game window
- Overview
- Opener
- Single Target
- AoE
- Stats
- Talents placeholder
- Hero Talents placeholder
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
│   └── Database.lua
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

1. Finish the Subtlety talent and Hero Talent pages.
2. Add spell icons and richer WoW-style UI components.
3. Add Assassination and Outlaw.
4. Use Rogue as the template for all remaining classes and specs.
5. Add optional content-mode profiles such as Mythic+, Raid and Open World.

## Important

Class Codex is intended as a reference and learning addon. Recommended stats and rotations should be versioned by patch and treated as guidance rather than a replacement for character-specific simulation.
