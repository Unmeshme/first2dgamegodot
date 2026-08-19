extends ProgressBar
signal game_has_loaded

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	#we should first drop the play button and then show the progress bar
	$"../Button".queue_free()
	$"../splashScreenItem".queue_free()
	show()
	
	var m_tween = create_tween()
	m_tween.tween_property(self, "value", 100.0, 5.0)
	
	yield(m_tween, "finished")
	emit_signal("game_has_loaded")
	print("Game has loaded signal is emitted")

