#honestly happy with the current implementation
extends Node

onready var transition_manager = $TransitionManager
onready var curr_scene = $CurrentNode

##stack to hold previous scene
var stack = []
var current_scene_path = ""

##ok initially, tested and wrote implementation with queue free but certain pages like settings page need to save ui elements
##lets check for the name of the scene we are loading and accordingly for now just hide it

func _ready():
	#start by hiding the button
	$settings_button.hide()
	$back_button.hide()
	load_scene("res://SplashScreen.tscn", false)
	$GameMusic.play()
	
	
#load scene will also act as push
func load_scene(p_scene_path: String, p_is_back: bool)->void:
	
	if !p_is_back && current_scene_path != "":
		_stack_push(current_scene_path)
	
	current_scene_path = p_scene_path
	
	var m_transition_instance = _load_transition_manager("res://TransitionScreen.tscn")
	yield(m_transition_instance.fade_dark(), "completed")
	
	for m_child in curr_scene.get_children():
		m_child.queue_free()
		
	var m_scene = load(p_scene_path).instance()
	curr_scene.add_child(m_scene)
	

	if m_scene.has_signal("game_has_loaded"):
		m_scene.connect("game_has_loaded", self, "_on_finished_game_loading")
		
	if m_scene.has_signal("game_music_toggled"):
		m_scene.connect("game_music_toggled", self, "_toggle_game_music")
	
	$settings_button.visible = (p_scene_path != "res://settings_menu.tscn")
	$back_button.visible = !stack.empty()
	
	yield(m_transition_instance.fade_normal(), "completed")
	_empty_transition_manager()


func _toggle_game_music()->void:
	$GameMusic.stream_paused = !SettingsManager.game_music_enabled


func _on_finished_game_loading()->void:
	load_scene("res://Main.tscn", false)


func _load_transition_manager(p_transition_scene_path)->Node:
	var m_transition_scene = load(p_transition_scene_path).instance()
	transition_manager.add_child(m_transition_scene)
	return m_transition_scene


func _empty_transition_manager()->void:
	for m_child in transition_manager.get_children():
		m_child.queue_free()


func _on_settings_button_pressed():
	#if settigs button is pressed then load the settings menu
	load_scene("res://settings_menu.tscn", false)

func _stack_push(p_scene_path : String) ->void:
	stack.append(p_scene_path)
	
	for item in stack:
		print("path: %s " %item)
	
	
func _stack_pop()-> String:
	if stack.empty():
		return ""
	return stack.pop_back()


#when this button is pressed the stack removes its child and we load that scene
func _on_back_button_pressed():
	var m_previous_scene = _stack_pop()
	if m_previous_scene != "":
		load_scene(m_previous_scene, true)
