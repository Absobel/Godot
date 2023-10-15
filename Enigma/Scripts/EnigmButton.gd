extends StaticBody2D

signal button_pressed
signal button_unpressed


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _area_entered(_area:Area2D):
	$Sprite2D.texture = load("res://Resources/buttonYellow_pressed.png")
	emit_signal("button_pressed")

func _area_exited(_area:Area2D):
	$Sprite2D.texture = load("res://Resources/buttonYellow.png")
	emit_signal("button_unpressed")
