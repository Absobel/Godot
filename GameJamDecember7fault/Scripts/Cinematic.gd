extends CanvasLayer

var dialogue_array = []
var dialogue_index = 0

func toggle_visible(node):
	node.visible = not node.visible

func load_dialogue():
	for i in range(9):
		dialogue_array.append(get_node(str(i+1)))

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialogue()
	OS.delay_msec(1000)
	toggle_visible(dialogue_array[dialogue_index])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_index < len(dialogue_array)-1:
		if Input.is_action_just_pressed("skip"):
			dialogue_index += 1
			toggle_visible(dialogue_array[dialogue_index])
			toggle_visible(dialogue_array[dialogue_index-1])
			OS.delay_msec(400)
	else:
		OS.delay_msec(600)
		Globals.level_number = 1
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
