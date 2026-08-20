extends Node

signal game_music_toggled
signal music_toggled #this is toggle for death sound now

onready var music_button = $music_button
onready var game_sound_button = $game_sound_button
onready var sfx_button = $SFX_button


func _ready():
	music_button.pressed = SettingsManager.music_enabled
	game_sound_button.pressed = SettingsManager.game_music_enabled
	sfx_button.pressed = SettingsManager.sfx_enabled
	

func _on_exit_button_pressed():
	get_tree().quit()


func _on_music_button_toggled(p_button_pressed):
	#then release a signal from here
	#also set the state of music button on settingsManager
	SettingsManager.music_enabled = p_button_pressed
	emit_signal("music_toggled")
	

func _on_game_sound_button_toggled(p_button_pressed):
	SettingsManager.game_music_enabled = p_button_pressed
	emit_signal("game_music_toggled")


func _on_SFX_button_toggled(p_button_pressed):
	#sounds when buttons are clicked
	SettingsManager.sfx_enabled = p_button_pressed
