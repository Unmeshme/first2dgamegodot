#honestly happy with the current implementation
extends Node

onready var transition_manager: Node = $TransitionManager
onready var curr_scene: Node = $CurrentNode
onready var game_music: AudioStreamPlayer = $GameMusic
onready var settings_button: TextureButton = $ui_elements/settings_button
onready var back_button: TextureButton = $ui_elements/back_button
onready var sfx_sound: AudioStreamPlayer = $sfx_sound

##stack to hold previous scene
var stack: Array = []
var current_scene_path: String  = ""

func _ready() -> void:
	#start by hiding the button
	settings_button.visible = false
	back_button.visible = false
	load_scene("res://SplashScreen.tscn", false)
	game_music.play()
	
	
#load scene will also act as push
func load_scene(p_scene_path: String, p_is_back: bool) -> void:
	
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


	if m_scene.has_signal("game_started_from_home"):
		m_scene.connect("game_started_from_home", self, "_on_game_started_from_home")
	
	if m_scene.has_signal("play_sfx"):
		m_scene.connect("play_sfx", self, "_play_sfx_music")
	
	settings_button.visible = (p_scene_path != "res://settings_menu.tscn")
	back_button.visible = !stack.empty()
	
	yield(m_transition_instance.fade_normal(), "completed")
	_empty_transition_manager()


func _toggle_game_music() -> void:
	game_music.stream_paused = !SettingsManager.game_music_enabled


func _on_finished_game_loading() -> void:
	load_scene("res://home_screen.tscn", false)


func _on_game_started_from_home() -> void:
	load_scene("res://Main.tscn", false)

func _load_transition_manager(p_transition_scene_path: String ) -> Node:
	var m_transition_scene = load(p_transition_scene_path).instance()
	transition_manager.add_child(m_transition_scene)
	return m_transition_scene


func _empty_transition_manager() -> void:
	for m_child in transition_manager.get_children():
		m_child.queue_free()


func _on_settings_button_pressed() -> void:
	_play_sfx_local()
	load_scene("res://settings_menu.tscn", false)

func _stack_push(p_scene_path : String) -> void:
	stack.append(p_scene_path)
	
	for item in stack:
		print("path: %s " %item)
	
	
func _stack_pop()-> String:
	if stack.empty():
		return ""
	return stack.pop_back()


#when this button is pressed the stack removes its child and we load that scene
func _on_back_button_pressed() -> void:
	_play_sfx_local()
	var m_previous_scene = _stack_pop()
	if m_previous_scene != "":
		load_scene(m_previous_scene, true)

func _play_sfx_music() -> void:
	if SettingsManager.sfx_enabled:
		sfx_sound.play()
		yield(sfx_sound, "finished")

func _play_sfx_local() -> void:
	if SettingsManager.sfx_enabled:
		sfx_sound.play()
		yield(sfx_sound, "finished")
