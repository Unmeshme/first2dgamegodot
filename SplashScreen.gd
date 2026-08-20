extends TextureRect

signal game_has_loaded

onready var progress_bar = $ProgressBar

func _on_ProgressBar_game_has_loaded():
	emit_signal("game_has_loaded")
	print("Game has loaded signal emitted from SpalshScreen as well")


func _on_ExitButton_pressed():
	#exit game
	get_tree().quit()
