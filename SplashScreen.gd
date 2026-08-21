extends TextureRect

signal game_has_loaded
signal play_sfx

onready var play_button: Button = $play_button

func _on_ExitButton_pressed() -> void:
	#exit game
	emit_signal("play_sfx")
	get_tree().quit()


func _on_play_button_pressed() -> void:
	emit_signal("play_sfx")
	emit_signal("game_has_loaded")
