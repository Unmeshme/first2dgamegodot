extends Control

signal play_sfx


onready var animation_player: AnimationPlayer = $base/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _play_on_to_off_animation() -> void:
	animation_player.play("on_to_off")
	yield(animation_player, "finished")

func _play_off_to_on_animation() -> void:
	animation_player.play("off_to_on")
	yield(animation_player, "finished")


#TODO: Implement it later
func _on_base_toggled(button_pressed):
	pass
