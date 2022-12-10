extends Node2D

const LIVING_BLOC_SIZE = 64


func load_level(level_number):
	var packed_living_level = load("res://Scenes/LivingLevel.tscn")
	var living_level = packed_living_level.instance()

	# Instance the level
	living_level.load_level(level_number)
	var level_size = living_level.get_level_size()
	self.add_child(living_level)

	# Create the background
	var fond = $WhiteSquare
	var fond_size = fond.get_rect().size
	fond.scale = Vector2(level_size[0]*LIVING_BLOC_SIZE/fond_size.x, level_size[1]*LIVING_BLOC_SIZE/fond_size.y)
	fond_size = fond.get_rect().size
	fond.offset = Vector2(fond_size.x/2, fond_size.y/2)

	# Change camera size
	var camera = $Camera2D
	var camera_size = camera.get_viewport_rect().size
	camera.zoom = Vector2(level_size[0]*LIVING_BLOC_SIZE/camera_size.x, level_size[1]*LIVING_BLOC_SIZE/camera_size.y)
	camera_size = camera.get_viewport_rect().size
	camera.offset = Vector2(camera_size.x*camera.zoom.x/2, camera_size.y*camera.zoom.y/2)


# Called when the node enters the scene tree for the first time.
func _ready():
	load_level(1)






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var living_level = $LivingLevel
	



