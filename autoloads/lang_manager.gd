extends Node

const SAVE_PATH := "user://settings.cfg"

const UI_STRINGS := {
	"START": "ابدأ",
	"EXIT": "خروج",
	"MUSIC: ON": "الموسيقى: تشغيل",
	"MUSIC: OFF": "الموسيقى: إيقاف",
	"Game Over": "انتهت اللعبة",
	"Press R to Restart": "اضغط R لإعادة التشغيل",
	"Press E to interact": "اضغط E للتفاعل",
	"Play": "العب",
}

var current_locale := "en"


func _ready() -> void:
	_register_translations()
	current_locale = _load_locale()
	TranslationServer.set_locale(current_locale)


func _register_translations() -> void:
	var ar := Translation.new()
	ar.locale = "ar"
	for key in UI_STRINGS:
		ar.add_message(key, UI_STRINGS[key])
	TranslationServer.add_translation(ar)


func toggle() -> String:
	current_locale = "ar" if current_locale == "en" else "en"
	TranslationServer.set_locale(current_locale)
	_save_locale()
	return current_locale


func _load_locale() -> String:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		return cfg.get_value("settings", "locale", "en")
	return "en"


func _save_locale() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("settings", "locale", current_locale)
	cfg.save(SAVE_PATH)
