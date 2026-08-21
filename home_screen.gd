extends CanvasLayer

signal game_started_from_home
signal play_sfx

onready var progress_bar: ProgressBar = $progress_bar
onready var start_button: Button = $start_button

func _on_start_button_pressed() ->void :
	emit_signal("play_sfx")
	start_button.queue_free()

	var m_tween = create_tween()
	m_tween.tween_property(progress_bar, "value", 100.0, 5.0)
	
	yield(m_tween, "finished")
	emit_signal("game_started_from_home")
