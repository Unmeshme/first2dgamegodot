extends Node


onready var transition = $TransitionScreen
onready var curr_scene = $CurrentNode


func _ready():
	load_scene("res://SplashScreen.tscn")
	$GameMusic.play()
	
	
func load_scene(p_scene_path: String):
	
	transition.fade_dark()
	for m_child in curr_scene.get_children():
		m_child.queue_free()
		
	var m_scene = load(p_scene_path).instance()
	curr_scene.add_child(m_scene)
	
	transition.fade_normal()
	
	if m_scene.has_signal("game_has_loaded"):
		m_scene.connect("game_has_loaded", self, "_on_finished_game_loading")

func _on_finished_game_loading()->void:
	print("Received the signal and entered on finished game loading function")
	load_scene("res://Main.tscn")
	
	
#Artifact form testing
#testing first
#func _on_finished_transition()->void:
	#after transition finished we just clear the child
	#transition.queue_free()
