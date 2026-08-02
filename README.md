# Game Jam

An old-west themed boss-fight game built for a game jam. Made with [Godot 4.7](https://godotengine.org) (Forward Plus renderer).

## Running

1. Install Godot 4.7 (or newer 4.x).
2. Open the project folder in the Godot editor.
3. Press F5 (or run `godot res://scenes/test_fight.tscn`).

The main scene is `scenes/test_fight.tscn`.

## Controls

| Action | Key |
| --- | --- |
| Move | W / A / S / D |
| Shoot | Space or Left Mouse Button |
| Advance dialog | Space / Enter / Left Mouse Button |

## Gameplay

Boss fights, one per encounter:

- **Cow Cactus** — quick-draw duel.
- **Coffinator** *(rename pending)* — duck-hunt style; it digs down to escape your shots.
- **Coyote** *(rename pending)* — Donkey Kong style; it shoots magic projectiles and chases down its orbs.

## Project structure

```
autoloads/        Global autoload
bosses/           per-boss scenes + scripts
  coffin/         Coffinator fight
  cow_cactus/     quick-draw fight
  coyote/         projectile/orb fight
dialogs/          SproutyDialogs data, characters, custom dialog boxes
player/           player + bullet scenes/scripts
scenes/           main game scene (test_fight) and test scenes
UI/               menus and UI prototypes
addons/           SproutyDialogs dialog addon
```

## Dialogs

Dialogs use the [SproutyDialogs](addons/sprouty_dialogs/) addon. Dialog files live in
`dialogs/` and character data in `dialogs/characters/`.

## Progress

See [TODO.md](TODO.md) for the current progress list.
