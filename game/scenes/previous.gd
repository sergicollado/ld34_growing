
extends Node2D
export var month_number=1

var sec = 0.3
var amount = 0
var map

func _ready():
	map = get_node("TileMap")
	get_node("bigLabel").set_text("MONTH "+str(month_number))
	set_process(true)

func _process(delta):
	amount += delta
	if(amount > sec):
		randomize()
		var width = rand_range(0,1280)
		var height = rand_range(0,720)
		var cell = map.world_to_map(Vector2(width, height))
		map.set_cell(cell.x,cell.y, rand_range(0,2))
		amount = 0

func show_message():
	get_node("AnimationPlayer").play("show")
	
	
func next_scene():
	get_tree().change_scene("res://scenes/level_0"+str(month_number)+".scn")
	