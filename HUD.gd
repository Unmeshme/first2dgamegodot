extends CanvasLayer

signal start_game

func _ready():
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


func _on_MessageTimer_timeout():
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
func update_score(p_score: int):
	$ScoreLabel.text = str(p_score)
