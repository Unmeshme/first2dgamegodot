extends RigidBody2D


onready var animated_sprite: AnimatedSprite = $AnimatedSprite




# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.playing = true
	var m_mob_types = animated_sprite.frames.get_animation_names()
	animated_sprite.animation = m_mob_types[randi() % m_mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
