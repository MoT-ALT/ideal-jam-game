# SproutyDialogs Translation Template

> This document lists every SproutyDialogs dialog and character display name in the project, with its English (`default`) text. The `"ar"` entries below are currently populated in the `.tres` files (applied via `apply_translations.py`); the empty `"ar"` placeholders shown here reflect the source template only.

## How to add translations

Edit each `.tres` file. Each dialog key holds a dictionary like:

```
"DIALOG_KEY": {
    "": "",
    "default": "English text",
    "en": "English text",
    "ar": "",
}
```

Character files use `display_name = { "default": "Name", "en": "Name", "ar": "Arabic" }`.

**IMPORTANT:** With `use_csv_files=false`, SproutyDialogs reads `dialogs[key][locale]`. If `en` is empty, English dialogs render blank, so always fill `en` and `ar` together.

Also set in `project.godot` under `[sprouty_dialogs]`: `translation/enable_translations=true`, `translation/csv_files/use_csv_files=false`, `translation/characters/translate_character_names=true`, `translation/localization/locales=["en", "ar"]`.

---

## `dialogs/Town_Dialogs/Bartender_intro.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "You the new sheriff they sent?",
    "en": "You the new sheriff they sent?",
    "ar": "",
}
```

### Dialog: `1_DIALOG_10`

```
"1_DIALOG_10": {
    "": "",
    "default": "You go up against him, you'd better have fast hands. Slow ones just end up buried.",
    "en": "You go up against him, you'd better have fast hands. Slow ones just end up buried.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_11`

```
"1_DIALOG_11": {
    "": "",
    "default": "You can find him taking over the Bank in the [color=#ab1200][shake]South[/shake]",
    "en": "You can find him taking over the Bank in the [color=#ab1200][shake]South[/shake]",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Well, you can turn right back around. They already sent one before you. Didn't end well.",
    "en": "Well, you can turn right back around. They already sent one before you. Didn't end well.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_5`

```
"1_DIALOG_5": {
    "": "",
    "default": "What, they didn't tell you about her? A woman, sent here to do exactly what you're about to do. Those things out there made quick work of her.",
    "en": "What, they didn't tell you about her? A woman, sent here to do exactly what you're about to do. Those things out there made quick work of her.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_6`

```
"1_DIALOG_6": {
    "": "",
    "default": "We managed to pull her out while they weren't looking. But I don't think she's gonna make it.",
    "en": "We managed to pull her out while they weren't looking. But I don't think she's gonna make it.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_7`

```
"1_DIALOG_7": {
    "": "",
    "default": "Anyway if you still wanna do this after hearing that, I've got some information that might help.\n\n",
    "en": "Anyway if you still wanna do this after hearing that, I've got some information that might help.\n\n",
    "ar": "",
}
```

### Dialog: `1_DIALOG_8`

```
"1_DIALOG_8": {
    "": "",
    "default": "Huh. Guess you've got some meat on your bones after all.\n\n",
    "en": "Huh. Guess you've got some meat on your bones after all.\n\n",
    "ar": "",
}
```

### Dialog: `1_DIALOG_9`

```
"1_DIALOG_9": {
    "": "",
    "default": " happen to know one of the monsters. Calls himself Cow Cact now. Used to be a regular in here fastest gunslinger this town ever saw. Man didn't want anybody messing with him, or his hat , [color=#ab1200][shake]Especially[/shake][/color] the hat.",
    "en": " happen to know one of the monsters. Calls himself Cow Cact now. Used to be a regular in here fastest gunslinger this town ever saw. Man didn't want anybody messing with him, or his hat , [color=#ab1200][shake]Especially[/shake][/color] the hat.",
    "ar": "",
}
```

### Dialog: `1_OPT1_1`

```
"1_OPT1_1": {
    "": "",
    "default": "Do it",
    "en": "Do it",
    "ar": "",
}
```

### Dialog: `1_OPT1_2`

```
"1_OPT1_2": {
    "": "",
    "default": "Turn back and leave",
    "en": "Turn back and leave",
    "ar": "",
}
```

### Dialog: `UNPLUGGED_DIALOG_2`

```
"UNPLUGGED_DIALOG_2": {
    "": "",
    "default": "Nods",
    "en": "Nods",
    "ar": "",
}
```

### Dialog: `UNPLUGGED_DIALOG_4`

```
"UNPLUGGED_DIALOG_4": {
    "": "",
    "default": "Confused",
    "en": "Confused",
    "ar": "",
}
```

## `dialogs/Town_Dialogs/cactus_npc_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Heavy on the heel, light on the toe. That's a lawman's walk.",
    "en": "Heavy on the heel, light on the toe. That's a lawman's walk.",
    "ar": "ثقيل على الكعب، خفيف على الأصابع. تلك مشية رجل القانون.",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "New sheriff, huh. They keep sendin' 'em.",
    "en": "New sheriff, huh. They keep sendin' 'em.",
    "ar": "شريف جديد، هاه. ما زالوا يرسلونهم.",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Woman before you had good hands. Almost fast enough.",
    "en": "Woman before you had good hands. Almost fast enough.",
    "ar": "المرأة التي سبقتك كانت ماهرة. كادت تكون سريعة بما يكفي.",
}
```

### Dialog: `1_DIALOG_4`

```
"1_DIALOG_4": {
    "": "",
    "default": "Walk out that door, or pull. Find out if \"almost\" runs in the family.",
    "en": "Walk out that door, or pull. Find out if \"almost\" runs in the family.",
    "ar": "اخرج من ذلك الباب، أو اسحب سلاحك. واكتشف ما إذا كان \"كاد\" يتوارث في العائلة.",
}
```

### Dialog: `1_DIALOG_5`

```
"1_DIALOG_5": {
    "": "",
    "default": "Well now. Guess that answers that.",
    "en": "Well now. Guess that answers that.",
    "ar": "حسناً الآن. أظن أن هذا أجاب على ذلك.",
}
```

### Dialog: `1_DIALOG_6`

```
"1_DIALOG_6": {
    "": "",
    "default": "Don't touch the hat. Everything else is fair game.",
    "en": "Don't touch the hat. Everything else is fair game.",
    "ar": "لا تلمس القبعة. كل شيء آخر مسموح.",
}
```

## `dialogs/Town_Dialogs/cactus_win_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Slow hands.",
    "en": "Slow hands.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Told you how this'd go.\n\n",
    "en": "Told you how this'd go.\n\n",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Bury this one proper.",
    "en": "Bury this one proper.",
    "ar": "",
}
```

## `dialogs/Town_Dialogs/coyote_win_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Slow hands.",
    "en": "Slow hands.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Told you how this'd go.\n\n",
    "en": "Told you how this'd go.\n\n",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Bury this one proper.",
    "en": "Bury this one proper.",
    "ar": "",
}
```

## `dialogs/barman_intro.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Welcome to my saloon, stranger. Quiet night tonight.",
    "en": "Welcome to my saloon, stranger. Quiet night tonight.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "...",
    "en": "...",
    "ar": "",
}
```

## `dialogs/bartender_after_boss.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "...To think I ever doubted you.",
    "en": "...To think I ever doubted you.",
    "ar": "...أن أظن أنني شككت فيك يوماً.",
}
```

## `dialogs/bartender_before_boss.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "That's all I know.",
    "en": "That's all I know.",
    "ar": "هذا كل ما أعرفه.",
}
```

## `dialogs/bobo.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "hoho",
    "en": "hoho",
    "ar": "هوهو",
}
```

## `dialogs/bosses_dialogs/cactus_lose_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Ain't that somethin'.",
    "en": "Ain't that somethin'.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Nobody's touched that hat in a long while.",
    "en": "Nobody's touched that hat in a long while.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Town's yours. For now.",
    "en": "Town's yours. For now.",
    "ar": "",
}
```

## `dialogs/bosses_dialogs/cactus_win_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Slow hands.",
    "en": "Slow hands.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Told you how this'd go.\n\n",
    "en": "Told you how this'd go.\n\n",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Bury this one proper.",
    "en": "Bury this one proper.",
    "ar": "",
}
```

## `dialogs/bosses_dialogs/coyote_lose_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Ain't that somethin'.",
    "en": "Ain't that somethin'.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Nobody's touched that hat in a long while.",
    "en": "Nobody's touched that hat in a long while.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "Town's yours. For now.",
    "en": "Town's yours. For now.",
    "ar": "",
}
```

## `dialogs/cactus_intro.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Well now. Guess that answers that.",
    "en": "Well now. Guess that answers that.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Don't touch the hat. Everything else is fair game.",
    "en": "Don't touch the hat. Everything else is fair game.",
    "ar": "",
}
```

## `dialogs/characters/Player_Talking_to_cactus.tres`

### Character: `Player_Talking_to_cactus`

```
display_name = {
    "default": "Player",
    "en": "",
    "ar": "اللاعب",
}
```

## `dialogs/characters/barman.tres`

### Character: `barman`

```
display_name = {
    "default": "Barman",
    "en": "",
    "ar": "النادل",
}
```

## `dialogs/characters/bartender.tres`

### Character: `bartender`

```
display_name = {
    "default": "Bartender",
    "en": "",
    "ar": "الساقي",
}
```

## `dialogs/characters/cactus.tres`

### Character: `cactus`

```
display_name = {
    "default": "Cow Cactus",
    "en": "",
    "ar": "صبار البقرة",
}
```

## `dialogs/characters/cow_cactus_npc.tres`

### Character: `cow_cactus_npc`

```
display_name = {
    "default": "Cow Cactus",
    "en": "",
    "ar": "صبار البقرة",
}
```

## `dialogs/characters/coyote.tres`

### Character: `coyote`

```
display_name = {
    "default": "Coyote",
    "en": "",
    "ar": "الذئب",
}
```

## `dialogs/characters/coyote_in_town.tres`

### Character: `coyote_in_town`

```
display_name = {
    "default": "Coyote",
    "en": "",
    "ar": "الذئب",
}
```

## `dialogs/characters/ggg.tres`

### Character: `ggg`

```
display_name = {
    "default": "gggg",
    "en": "",
    "ar": "gggg",
}
```

## `dialogs/characters/grave_digger.tres`

### Character: `grave_digger`

```
display_name = {
    "default": "Grave Digger",
    "en": "",
    "ar": "حفّار القبور",
}
```

## `dialogs/characters/player.tres`

### Character: `player`

```
display_name = {
    "default": "Player",
    "en": "",
    "ar": "اللاعب",
}
```

## `dialogs/coffinator.tres`

## `dialogs/coyote_intro.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Surprised? You really didn't see it comin'?",
    "en": "Surprised? You really didn't see it comin'?",
    "ar": "متفاجئ؟ ألم ترَ الأمر قادماً حقاً؟",
}
```

## `dialogs/coyote_lose_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "This town was mine... I built it from nothing...",
    "en": "This town was mine... I built it from nothing...",
    "ar": "هذه المدينة كانت ملكي... بنيتها من لا شيء...",
}
```

## `dialogs/coyote_outro.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "No... no, this ain't — I've outrun sheriffs before, outrun the law itself...",
    "en": "No... no, this ain't — I've outrun sheriffs before, outrun the law itself...",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "You didn't outrun nothin'. You just hadn't met the right one yet.",
    "en": "You didn't outrun nothin'. You just hadn't met the right one yet.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "The desert remembers me, lawdog. Long after your bones are dust, they'll still be tellin' tales of the coyote who danced with death...",
    "en": "The desert remembers me, lawdog. Long after your bones are dust, they'll still be tellin' tales of the coyote who danced with death...",
    "ar": "",
}
```

### Dialog: `1_DIALOG_4`

```
"1_DIALOG_4": {
    "": "",
    "default": "Maybe. But it'll be a story that ends right here.",
    "en": "Maybe. But it'll be a story that ends right here.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_5`

```
"1_DIALOG_5": {
    "": "",
    "default": "Heh... heh heh heh... this ain't over, tin star... it's never over...",
    "en": "Heh... heh heh heh... this ain't over, tin star... it's never over...",
    "ar": "",
}
```

## `dialogs/coyote_win_dialog.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Should've turned back when you had the chance.",
    "en": "Should've turned back when you had the chance.",
    "ar": "كان عليك أن تعود أدراجك عندما أتيحت لك الفرصة.",
}
```

## `dialogs/grave_digger_after_cactus.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Heard you got one of 'em.",
    "en": "Heard you got one of 'em.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Never thought I'd live long enough to see this town breathe free again.",
    "en": "Never thought I'd live long enough to see this town breathe free again.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_3`

```
"1_DIALOG_3": {
    "": "",
    "default": "...I've got some information on that damn loose coffin roaming the outskirts on the [color=#ab1200][wave]East[/wave][/color]. Might seem impossible to put down, but ",
    "en": "...I've got some information on that damn loose coffin roaming the outskirts on the [color=#ab1200][wave]East[/wave][/color]. Might seem impossible to put down, but ",
    "ar": "",
}
```

### Dialog: `1_DIALOG_4`

```
"1_DIALOG_4": {
    "": "",
    "default": "Hit the hole in the coffin. That ought to do enough damage to send him back where he came from.",
    "en": "Hit the hole in the coffin. That ought to do enough damage to send him back where he came from.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_5`

```
"1_DIALOG_5": {
    "": "",
    "default": "Six feet under. Where he belongs.",
    "en": "Six feet under. Where he belongs.",
    "ar": "",
}
```

## `dialogs/grave_digger_after_coffinator.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Well, well. Just as I expected  from someone who could take down my fastest gunslinger.",
    "en": "Well, well. Just as I expected  from someone who could take down my fastest gunslinger.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "I won't let you take this town from me!",
    "en": "I won't let you take this town from me!",
    "ar": "",
}
```

## `dialogs/grave_digger_before_cactus.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "Get him first, and I might have some information on that handsome cat who caused all this.",
    "en": "Get him first, and I might have some information on that handsome cat who caused all this.",
    "ar": "",
}
```

### Dialog: `1_DIALOG_2`

```
"1_DIALOG_2": {
    "": "",
    "default": "Go Talk to the Bartender",
    "en": "Go Talk to the Bartender",
    "ar": "",
}
```

## `dialogs/grave_digger_before_coffinator.tres`

### Dialog: `1_DIALOG_1`

```
"1_DIALOG_1": {
    "": "",
    "default": "The loose coffin's still out there, wandering the outskirts. Remember what I told you  hit the hole in the coffin.",
    "en": "The loose coffin's still out there, wandering the outskirts. Remember what I told you  hit the hole in the coffin.",
    "ar": "النعش المارق ما زال هناك، يتجول في الأطراف. تذكر ما قلته لك — اضرب الثقب في النعش.",
}
```

## `dialogs/new_theme.tres`
