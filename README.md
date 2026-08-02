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
autoloads/        Global autoload (dialogs/voice helpers)
bosses/           per-boss scenes + scripts
  coffin/         Coffinator fight
  cow_cactus/     quick-draw fight
  coyote/         projectile/orb fight
dialogs/          SproutyDialogs data, characters, custom dialog boxes, voices
player/           player + bullet scenes/scripts
scenes/           main game scene (test_fight) and test scenes
UI/               menus and UI prototypes
addons/           SproutyDialogs dialog addon
```

## Dialogs & voice acting

Dialogs use the [SproutyDialogs](addons/sprouty_dialogs/) addon. Dialog files live in
`dialogs/` and character data in `dialogs/characters/`.

Voice acting is handled globally by the `Voice` autoload (`dialogs/voices/voice.gd`),
which hooks into dialog line events and plays a clip per line. Clips are named
`<dialog_name>_<dialog_key>.ogg`, e.g. `coyote_intro_1_DIALOG_1.ogg` for the first
line of `dialogs/coyote_intro.tres`. To add voice for a new dialog:

1. Place an `.ogg` named `<dialog_name>_<dialog_key>.ogg` in `dialogs/voices/`.
2. It will be picked up automatically the next time the project is opened.

Existing placeholders are generated test tones — replace them with real recordings.

## Progress

See [TODO.md](TODO.md) for the current progress list.
