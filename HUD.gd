extends CanvasLayer

signal start_game
signal play_sfx


onready var message: Label = $Message
onready var score_label: Label = $ScoreLabel
onready var message_timer: Timer = $MessageTimer
onready var start_button: Button = $StartButton
onready var count_down: Label = $count_down

func _ready() -> void:
	#create timer and show the time value
	_time_down(3.0)
	start_button.hide()


func show_message(p_text: String) -> void:
	message.text = p_text
	message.show()
	message_timer.start()
	
func show_game_over() -> void:
	show_message("Game Over")
	
	yield(message_timer, "timeout")
	
	message.text = "Dodge The\nCreeps"
	message.show()
	
	#yield(get_tree().create_timer(1), "timeout")
	start_button.show()

func _time_down(p_time: float) -> void:
	for m_i in range(p_time, 0, -1):
		count_down.text = str(m_i)
		yield(get_tree().create_timer(1), "timeout")
	count_down.text = "GO!"
	yield(get_tree().create_timer(1), "timeout")
	count_down.hide()

func _on_MessageTimer_timeout() -> void:
	message.hide()


func _on_StartButton_pressed() -> void:
	emit_signal("play_sfx")
	start_button.hide()
	emit_signal("start_game")


func update_score(p_score: int) -> void:
	score_label.text = str(p_score)
