extends CanvasLayer

signal start_game

func _ready():
	#create timer and show the time value
	_time_down(3.0)
	$StartButton.hide()


func show_message(p_text: String):
	$Message.text = p_text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge The\nCreeps"
	$Message.show()
	
	#yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func _time_down(p_time: float):
	for m_i in range(p_time, 0, -1):
		$count_down.text = str(m_i)
		yield(get_tree().create_timer(1), "timeout")
	$count_down.text = "GO!"
	yield(get_tree().create_timer(1), "timeout")
	$count_down.hide()

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
func update_score(p_score: int):
	$ScoreLabel.text = str(p_score)
