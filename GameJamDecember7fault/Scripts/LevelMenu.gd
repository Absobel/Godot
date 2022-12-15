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


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_1_pressed():
	Globals.level_number = 1
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_2_pressed():
	Globals.level_number = 2
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_3_pressed():
	Globals.level_number = 3
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_4_pressed():
	Globals.level_number = 4
	get_tree().change_scene("res://Scenes/Main.tscn")
