extends Area2D
signal hit

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var hitbox: CollisionShape2D = $CollisionShape2D

export var speed :int = 400 #player movement speed
var screen_size: Vector2 = Vector2.ZERO
var collision_radius: float = 0.0
var collision_height: float = 0.0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	collision_radius = hitbox.shape.radius
	collision_height = hitbox.shape.height

	
func _process(p_delta: float) -> void:
	var p_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		p_velocity.y += 1
	if Input.is_action_pressed("move_up"):
		p_velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		p_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		p_velocity.x -= 1
		
	if p_velocity.length() > 0:
		p_velocity = p_velocity.normalized() * speed
		animated_sprite.play()
	else:
		animated_sprite.stop()
		
	position += p_velocity* p_delta
	position.x = clamp(position.x , 0 + collision_radius, screen_size.x - collision_radius)
	position.y = clamp(position.y , 0 + collision_height * 2 , screen_size.y - collision_height * 2)
	
	if p_velocity.x != 0: #body is moving
		animated_sprite.animation = "walk"
		animated_sprite.flip_v = false
		
		animated_sprite.flip_h = p_velocity.x < 0
	elif p_velocity.y !=0: #body is moving but in different axis
		animated_sprite.animation = "up"
		animated_sprite.flip_v = p_velocity.y > 0


func _on_Player_body_entered(_body: RigidBody2D) -> void:
	hide()
	emit_signal("hit")
	hitbox.set_deferred("disabled", true)

func start(p_pos: Vector2) ->void :
	position = p_pos
	show()
	hitbox.disabled = false


