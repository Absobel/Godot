extends Node


var P2 = preload("res://Scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_EnigmButton_button_pressed():
	var instance = P2.instance()
	add_child(instance)
	instance.position = Vector2(0,0)


func _on_EnigmButton_button_unpressed():
	pass;
