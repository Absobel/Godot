extends CharacterBody2D

@export (int) var speed = 10
@export (int) var jump_speed = -10
@export (int) var gravity = 10
@export (float, 0, 1.0) var friction = 0.1
@export (float, 0, 1.0) var acceleration = 0.25


var velocity = Vector2.ZERO
var screen_size

func get_input():
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# $AnimatedSprite.play("jump")
			velocity.y = jump_speed

	var collision = move_and_collide(velocity)
	if collision:
		velocity = Vector2(velocity.x, 0)




func _process(_delta):
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")
