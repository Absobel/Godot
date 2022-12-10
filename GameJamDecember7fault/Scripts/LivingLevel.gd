extends Node

const LIVING_BLOC_SIZE = 64
enum {EMPTY, LIVING_RED, LIVING_GREY}

var level_size
var level_array



func load_level(level_number):
	# Load the level from a json file
	var file = File.new()
	var level_path = "res://Levels/level%d.json" % level_number
	file.open(level_path, File.READ)
	var text = file.get_as_text()
	var dict = parse_json(text)
	file.close()

	# Get level information
	level_size = dict["level_size"]
	level_array = dict["level_array"]

	# Create the level
	var packed_llb = load("res://Scenes/LivingLevelBloc.tscn")
	var img_llb_grey = load("res://Assets/LLB_Grey.png")
	var img_llb_red = load("res://Assets/LLB_Red.png")
	for i in range(level_size[0]):
		for j in range(level_size[1]):
			if level_array[i][j] != EMPTY:
				var llb = packed_llb.instance()
				var llb_sprite = llb.get_node("Sprite")
				if level_array[i][j] == LIVING_GREY:
					llb_sprite.set_texture(img_llb_grey)
				elif level_array[i][j] == LIVING_RED:
					llb_sprite.set_texture(img_llb_red)
				llb.position = Vector2((i+0.5)*LIVING_BLOC_SIZE, (j+0.5)*LIVING_BLOC_SIZE)
				self.add_child(llb)


func get_llb(x,y):
	pass




# Called when the node enters the scene tree for the first time.
func _ready():
	pass





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
