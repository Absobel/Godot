extends Node2D

const LIVING_BLOC_SIZE = 64

func load_level(level_number):
	var packed_living_level = load("res://Scenes/LivingLevel.tscn")
	var living_level = packed_living_level.instance()

	# Instance the level
	living_level.load_level(level_number)
	var level_size = living_level.get_level_size()
	var size_max = max(level_size[0], level_size[1])
	self.add_child(living_level)

	# Create the background
	var fond = $WhiteSquare
	var fond_size = fond.get_rect().size
	fond.scale = Vector2(size_max*LIVING_BLOC_SIZE/fond_size.x, size_max*LIVING_BLOC_SIZE/fond_size.y)
	fond_size = fond.get_rect().size
	fond.offset = Vector2(fond_size.x/2, fond_size.y/2)

	# Change camera size
	var camera = $Camera2D
	var camera_size = camera.get_viewport_rect().size
	var size_min_camera = min(camera_size.x,camera_size.y)
	camera.zoom = Vector2(size_max*LIVING_BLOC_SIZE/size_min_camera, size_max*LIVING_BLOC_SIZE/size_min_camera)
	camera_size = camera.get_viewport_rect().size
	camera.offset = Vector2(size_min_camera*camera.zoom.x/2, size_min_camera*camera.zoom.y/2)


# Called when the node enters the scene tree for the first time.
func _ready():
	load_level(Globals.get_level_number())






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var living_level = $LivingLevel

	if Input.is_action_just_pressed("move_left"):
		living_level.move_left()

	if Input.is_action_just_pressed("move_right"):
		living_level.move_right()

	if Input.is_action_just_pressed("move_up"):
		living_level.move_up()

	if Input.is_action_just_pressed("move_down"):
		living_level.move_down()

	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

	if living_level.check_win():
		OS.delay_msec(1000)
		
		var lvl = Globals.get_level_number()
		var new_level_number = lvl+1 if lvl+1 <= 3 else 1
		Globals.set_level_number(new_level_number)
		get_tree().reload_current_scene()



