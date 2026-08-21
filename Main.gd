extends Node


export(PackedScene) var mob_scene

onready var player: Area2D = $Player
onready var mob_timer: Timer = $MobTimer
onready var score_timer: Timer = $ScoreTimer
onready var start_timer: Timer = $StartTimer
onready var death_sound: AudioStreamPlayer = $DeathSound
onready var HUD: CanvasLayer = $HUD
onready var start_position: Position2D = $StartPosition


var score: int = 0


func _ready() -> void:
	#a countdown of 3 second here will work the best
	player.hide()
	randomize()
	#bind it here ig?
	self.connect("music_toggled", self, "_on_music_toggle")
	yield(get_tree().create_timer(4.0), "timeout")
	new_game()


func game_over() -> void:
	score_timer.stop()
	mob_timer.stop()
	HUD.show_game_over()
	player.hide()
	if(SettingsManager.music_enabled):
		death_sound.play()
	
func new_game() -> void:
	score = 0
	_reset_player()
	start_timer.start()
	HUD.update_score(score)
	HUD.show_message("Get Ready")

	get_tree().call_group("mobs", "queue_free")

func _on_MobTimer_timeout() ->void:
	var m_mob = mob_scene.instance()
	var m_mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	m_mob_spawn_location.offset = randi()
	
	var m_direction = m_mob_spawn_location.rotation + PI/2
	m_mob.position = m_mob_spawn_location.position
	
	m_direction += rand_range(-PI / 4, PI / 4)
	
	m_mob.rotation = m_direction
	
	var m_velocity = Vector2(rand_range(150, 250), 0)
	m_mob.linear_velocity = m_velocity.rotated(m_direction)
	
	
	add_child(m_mob)


func _on_ScoreTimer_timeout() -> void:
	score += 1
	HUD.update_score(score)

func _on_StartTimer_timeout() -> void:
	mob_timer.start()
	score_timer.start()
	
func _on_music_toggle() -> void:
	death_sound.stream_paused = !SettingsManager.game_music_enabled

func _reset_player() -> void:
	#reset the orientation
	player.animated_sprite.stop()
	player.animated_sprite.rotation = 0
	player.animated_sprite.flip_h = 0
	player.animated_sprite.flip_v = 0
	#place the player in their position
	player.start(start_position.position)
	#show player for new game
	player.show()
