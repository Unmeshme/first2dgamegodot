extends Node

export(PackedScene) var mob_scene
var score


func _ready():
	#can call my splash screen there
	randomize()
	new_game()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

	get_tree().call_group("mobs", "queue_free")

func _on_MobTimer_timeout():
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


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
