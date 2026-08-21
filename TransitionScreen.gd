extends CanvasLayer

signal faded_to_normal
signal faded_to_dark


onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_dark():
	animation_player.play("fade_to_black")
	yield(self, "faded_to_dark")

func fade_normal():
	animation_player.play("fade_to_normal")
	yield(self, "faded_to_normal")

func _on_AnimationPlayer_animation_finished(p_anim_name: String):
	if p_anim_name == "fade_to_normal":
		emit_signal("faded_to_normal")
	elif p_anim_name == "fade_to_black":
		emit_signal("faded_to_dark")
