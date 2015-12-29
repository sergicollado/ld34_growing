
extends Navigation2D


var points = []
var player
var nav
var min_len = 5
var speed = 200
var is_pressed = false

func _ready():
	player = get_node("Props/Fox")
	set_process_input(true)
	set_fixed_process(true)

func clean_path():
	points.clear()

	
		
func _input(ev):
	
	if Input.is_mouse_button_pressed(1):
		is_pressed = true
		
		points = get_simple_path(player.get_global_pos(),get_global_mouse_pos(), true)
		points = Array(points)
		points.invert()
	if is_pressed == true and !Input.is_mouse_button_pressed(1):
        print("button 1 is released")
        is_pressed = false
	   
func _fixed_process(delta):
	if points.size() > 1:
		var to = points[points.size()-2]
		if(player.get_global_pos().distance_to(to)<min_len):
			points.remove(points.size()-1)
			return
		var direction = (to - player.get_global_pos()).normalized()
		var motion = direction*speed
		player.go(motion*delta)
		update()
	else:
		points.clear()
		player.stop()
 
func _draw():
	if points.size() > 1:
		for p in points:
			draw_circle(p-get_global_pos() , 8, Color(1, 0, 0))