extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.cinematic = true
	OS.delay_msec(1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("skip"):
		get_tree().change_scene("res://Scenes/Cinematic.tscn")
