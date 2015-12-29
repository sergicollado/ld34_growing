
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var could_restart = false

func _ready():
	set_process(true)

func show_messages():
	get_node("CanvasLayer/Control").show()
	
func _process(delta):
	var restart = Input.is_action_pressed("ui_accept") or Input.is_mouse_button_pressed(1) and could_restart

	if(restart):
		get_tree().change_scene("res://scenes/level_0"+get_node("/root/global").get_current_level()+".scn")


