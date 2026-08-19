extends Area2D
signal hit


export var speed = 400 #player movement speed
var screen_size #size of game window
var collision_radius
var collision_height

func _ready():
	screen_size = get_viewport_rect().size
	collision_radius = $CollisionShape2D.shape.radius
	collision_height = $CollisionShape2D.shape.height

	
func _process(p_delta) :
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
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += p_velocity* p_delta
	position.x = clamp(position.x , 0 + collision_radius, screen_size.x - collision_radius)
	position.y = clamp(position.y , 0 + collision_height * 2 , screen_size.y - collision_height * 2)
	
	if p_velocity.x != 0: #body is moving
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		
		$AnimatedSprite.flip_h = p_velocity.x < 0
	elif p_velocity.y !=0: #body is moving but in different axis
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = p_velocity.y > 0


func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(p_pos):
	position = p_pos
	show()
	$CollisionShape2D.disabled = false


