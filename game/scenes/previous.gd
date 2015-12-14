
extends Node2D
export var month_number=1

var sec = 0.3
var amount = 0
var map
var current_level
var timer
var voice

func _ready():
	current_level = get_node("/root/global").get_current_level()
	map = get_node("TileMap")
	get_node("CanvasLayer/bigLabel").set_text("MONTH "+current_level)
	set_process(true)
	
	timer = get_node("Timer")	
	timer.start()
	yield(timer, "timeout")
	if(current_level == str(1)):
		voice = get_node("voice_month_1")
		voice.play()
	if(current_level == str(3)):
		voice = get_node("voice_month_3")
		voice.play()
	if(current_level == str(5)):
		voice = get_node("voice_month_5")
		voice.play()

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
	if(voice):
		if(voice.is_playing()):
			timer.start()
			yield(timer, "timeout")
	get_tree().change_scene("res://scenes/level_0"+current_level+".scn")
	