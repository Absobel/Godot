extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Explanations.tscn")


func _on_Levels_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelMenu.tscn")
