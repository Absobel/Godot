extends Node

const LIVING_BLOC_SIZE = 64
enum {EMPTY, LIVING_RED, LIVING_GREY, FINISH, PLAYER}

var level_size
var level_array
var finish_coords



func load_level(lvl_number):
	# Load the level from a json file
	var file = File.new()
	var level_path = "res://Levels/level%d.json" % lvl_number
	file.open(level_path, File.READ)
	var text = file.get_as_text()
	var dict = parse_json(text)
	file.close()

	# Get level information
	level_size = dict["level_size"]
	level_array = dict["level_array"]

	# Create the level
	load_from_array()


static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func load_from_array():
	delete_children(self)
	var color
	var packed_llb = load("res://Scenes/LivingLevelBloc.tscn")
	var packed_player = load("res://Scenes/Player.tscn")
	var packed_finish = load("res://Scenes/Finish.tscn")
	var img_llb_grey = load("res://Assets/LLB_Grey.png")
	var img_llb_red_on_finish = load("res://Assets/LLB_Red_on_Finish.png")
	var img_player_on_finish = load("res://Assets/player_on_finish.png")
	for i in range(level_size[0]):
		for j in range(level_size[1]):
			color = level_array[i][j]
			if color != EMPTY:
				if color == LIVING_GREY or color == LIVING_RED:
					var llb = packed_llb.instance()
					var llb_sprite = llb.get_node("Sprite")
					if level_array[i][j] == LIVING_GREY:
						llb_sprite.set_texture(img_llb_grey)
					elif level_array[i][j] == LIVING_RED and [j,i] == finish_coords:
						llb_sprite.set_texture(img_llb_red_on_finish)
					llb.position = Vector2((j+0.5)*LIVING_BLOC_SIZE, (i+0.5)*LIVING_BLOC_SIZE)
					self.add_child(llb)
				elif color == PLAYER:
					var player = packed_player.instance()
					if [j,i] == finish_coords:
						player.get_node("Sprite").set_texture(img_player_on_finish)
					player.position = Vector2((j+0.5)*LIVING_BLOC_SIZE, (i+0.5)*LIVING_BLOC_SIZE)
					self.add_child(player)
				elif color == FINISH:
					var finish = packed_finish.instance()
					finish_coords = [j,i] 
					finish.position = Vector2((j+0.5)*LIVING_BLOC_SIZE, (i+0.5)*LIVING_BLOC_SIZE)
					self.add_child(finish)






# Movement

func move_left():
	for j in range(level_size[1]):
		for i in range(level_size[0]):
			if level_array[i][j] == LIVING_RED and j-1 > 0:
				if level_array[i][j-1] == EMPTY or level_array[i][j-1] == FINISH:
					level_array[i][j] = EMPTY if [j,i] != finish_coords else FINISH
					level_array[i][j-1] = LIVING_RED
				elif level_array[i][j-1] == PLAYER and j-2 > 0 and (level_array[i][j-2] == EMPTY or level_array[i][j-2] == FINISH):
					level_array[i][j] = EMPTY
					level_array[i][j-1] = LIVING_RED
					level_array[i][j-2] = PLAYER
	load_from_array()

func move_right():
	for j in range(level_size[1]-1, -1, -1):
		for i in range(level_size[0]):
			if level_array[i][j] == LIVING_RED and j+1 < level_size[1]:
				if level_array[i][j+1] == EMPTY or level_array[i][j+1] == FINISH:
					level_array[i][j] = EMPTY if [j,i] != finish_coords else FINISH
					level_array[i][j+1] = LIVING_RED
				elif level_array[i][j+1] == PLAYER and j+2 < level_size[1] and (level_array[i][j+2] == EMPTY or level_array[i][j+2] == FINISH):
					level_array[i][j] = EMPTY
					level_array[i][j+1] = LIVING_RED
					level_array[i][j+2] = PLAYER
	load_from_array()

func move_up():
	for i in range(level_size[0]):
		for j in range(level_size[1]):
			if level_array[i][j] == LIVING_RED and i-1 > 0:
				if level_array[i-1][j] == EMPTY or level_array[i-1][j] == FINISH:
					level_array[i][j] = EMPTY if [j,i] != finish_coords else FINISH
					level_array[i-1][j] = LIVING_RED
				elif level_array[i-1][j] == PLAYER and i-2 > 0 and (level_array[i-2][j] == EMPTY or level_array[i-2][j] == FINISH):
					level_array[i][j] = EMPTY
					level_array[i-1][j] = LIVING_RED
					level_array[i-2][j] = PLAYER
	load_from_array()

func move_down():
	for i in range(level_size[0]-1, -1, -1):
		for j in range(level_size[1]):
			if level_array[i][j] == LIVING_RED and i+1 < level_size[0]:
				if level_array[i+1][j] == EMPTY or level_array[i+1][j] == FINISH:
					level_array[i][j] = EMPTY if [j,i] != finish_coords else FINISH
					level_array[i+1][j] = LIVING_RED
				elif level_array[i+1][j] == PLAYER and i+2 < level_size[0] and (level_array[i+2][j] == EMPTY or level_array[i+2][j] == FINISH):
					level_array[i][j] = EMPTY
					level_array[i+1][j] = LIVING_RED
					level_array[i+2][j] = PLAYER
	load_from_array()



func check_win():
	if $Player.position == Vector2((finish_coords[0]+0.5)*LIVING_BLOC_SIZE, (finish_coords[1]+0.5)*LIVING_BLOC_SIZE):
		return true
	return false


# Getters
func get_level_size():
	return level_size
func get_level_array():
	return level_array



# Called when the node enters the scene tree for the first time.
func _ready():
	pass





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
