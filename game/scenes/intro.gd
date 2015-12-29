
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var ready

func _ready():
	ready = false
	set_process(true)
	
func _process(delta):
	var start = Input.is_action_pressed("ui_accept") or Input.is_mouse_button_pressed(1)

	if(start and ready):
		get_tree().change_scene("res://scenes/previous.scn")
		
func set_ready():
		ready = true