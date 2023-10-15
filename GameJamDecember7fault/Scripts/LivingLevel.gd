extends Node

const LIVING_BLOC_SIZE = 64
enum {EMPTY, LIVING_RED, LIVING_GREY, FINISH, PLAYER, BOX}



var level_size
var level_array
var array_of_previous_level_arrays = []
var finish_coords
var pre_moved = []
var moved
var is_first_load = true



func load_level(lvl_number):
	# Load the level from a json file
	var level_path = "res://Levels/level%d.json" % lvl_number
	var file = FileAccess.open(level_path, FileAccess.READ)
	var text = file.get_as_text()
	var test_json_conv = JSON.new()
	test_json_conv.parse(text)
	var dict = test_json_conv.get_data()
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
	var pos
	var packed_llb = load("res://Scenes/LivingLevelBloc.tscn")
	var packed_player = load("res://Scenes/Player.tscn")
	var packed_finish = load("res://Scenes/Finish.tscn")
	var packed_box = load("res://Scenes/Box.tscn")
	var img_llb_grey = load("res://Assets/LLB_Grey.png")
	var img_llb_red_on_finish = load("res://Assets/LLB_Red_on_Finish.png")
	var img_player_on_finish = load("res://Assets/player_on_finish.png")
	var img_box_on_finish = load("res://Assets/box_on_finish.jpg")
	for i in range(level_size[0]):
		for j in range(level_size[1]):
			color = level_array[i][j]
			pos = Vector2((j+0.5)*LIVING_BLOC_SIZE, (i+0.5)*LIVING_BLOC_SIZE)
			if color != EMPTY:
				if color == LIVING_GREY or color == LIVING_RED:
					var llb = packed_llb.instantiate()
					var llb_sprite = llb.get_node("Sprite2D")
					if level_array[i][j] == LIVING_GREY:
						llb_sprite.set_texture(img_llb_grey)
					elif level_array[i][j] == LIVING_RED and [j,i] == finish_coords:
						llb_sprite.set_texture(img_llb_red_on_finish)
					llb.position = pos
					self.add_child(llb)
				elif color == PLAYER:
					var player = packed_player.instantiate()
					if [j,i] == finish_coords:
						player.get_node("Sprite2D").set_texture(img_player_on_finish)
					player.position = pos
					self.add_child(player)
				elif color == BOX:
					var box = packed_box.instantiate()
					if [j,i] == finish_coords:
						box.get_node("Sprite2D").set_texture(img_box_on_finish)
					box.position = pos
					self.add_child(box)
				elif color == FINISH:
					var finish = packed_finish.instantiate()
					if is_first_load:
						finish_coords = [j,i]
					finish.position = pos
					self.add_child(finish)
	is_first_load = false



# Movement

func move_bloc(bloc,i,j,di,dj):
	var next_i = fposmod(i+di,len(level_array))
	var next_j = fposmod(j+dj,len(level_array[0]))
	var next_bloc = level_array[next_i][next_j]
	var has_moved = true

	if next_bloc == LIVING_GREY:
		has_moved = false
	else: # EMPTY | FINISH | BOX | PLAYER
		if next_bloc == BOX or next_bloc == PLAYER or next_bloc == LIVING_RED:
			has_moved = move_bloc(next_bloc,next_i,next_j,di,dj)
		if has_moved:
			level_array[i][j] = EMPTY if [j,i] != finish_coords else FINISH
			level_array[next_i][next_j] = bloc
			moved[next_i][next_j] = true
		else:
			moved[i][j] = true
	return has_moved

func move(direction):
	var di = direction[0]
	var dj = direction[1]
	array_of_previous_level_arrays.append(level_array.duplicate(true))
	moved = pre_moved.duplicate(true)

	for j in range(level_size[1]):
		for i in range(level_size[0]):
			if moved[i][j] == false and level_array[i][j] == LIVING_RED:
				move_bloc(LIVING_RED,i,j,di,dj)
	load_from_array()


# Others

func undo():
	if not array_of_previous_level_arrays.is_empty():
		level_array = array_of_previous_level_arrays.pop_back()
		load_from_array()


func check_win():
	for i in range(level_size[0]):
		for j in range(level_size[1]):
			if level_array[i][j] == PLAYER and [j,i] == finish_coords:
				return true
	return false

# Getters
func get_level_size():
	return level_size
func get_level_array():
	return level_array



# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(level_size[0]):
		pre_moved.append([])
		for _j in range(level_size[1]):
			pre_moved[i].append(false)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

