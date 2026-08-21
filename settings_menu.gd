extends Node

signal game_music_toggled
signal music_toggled #this is toggle for death sound now
signal play_sfx


onready var music_button = $music_button
onready var game_sound_button = $game_sound_button
onready var sfx_button = $sfx_button

#TODO: fix broken settings window. Since now we are now properly using control block for UI elements
#seems like the fix is simple just move the implementation to the toggle_button


#settings screen breaks the game right now
func _ready() -> void:
	#music_button.base.pressed = SettingsManager.music_enabled
	#game_sound_button.base.pressed = SettingsManager.game_music_enabled
	#sfx_button.base.pressed = SettingsManager.sfx_enabled
	pass
	

func _on_exit_button_pressed() -> void:
	emit_signal("play_sfx")
	get_tree().quit()


func _on_music_button_toggled(p_button_pressed: bool) -> void:
	#then release a signal from here
	#also set the state of music button on settingsManager
	SettingsManager.music_enabled = p_button_pressed
	emit_signal("play_sfx")
	emit_signal("music_toggled")
	

func _on_game_sound_button_toggled(p_button_pressed: bool) -> void:
	SettingsManager.game_music_enabled = p_button_pressed
	emit_signal("play_sfx")
	emit_signal("game_music_toggled")


func _on_SFX_button_toggled(p_button_pressed: bool) -> void:
	#sounds when buttons are clicked
	emit_signal("play_sfx")
	SettingsManager.sfx_enabled = p_button_pressed
	
