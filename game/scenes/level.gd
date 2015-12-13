
extends Node2D


var points = []
var navigation
var player
var motion
var begin = Vector2()
var end = Vector2()

func _ready():
	navigation = get_node("Navigation2D")
	player = get_node("Navigation2D/props/Fox")
	set_fixed_process(true)

func _fixed_process(delta):
	# refresh the points in the path
	if(Input.is_mouse_button_pressed(1)):
		print("click")
		begin = player.get_global_pos()
		end = get_global_mouse_pos()
		var p = get_node("Navigation2D").get_simple_path(begin, end)
		points = Array(p) # Vector2array too complex to use, convert to regular array
		points.invert()
		print('POINTS:',points)
#		print(points[0])
		if points.size() > 1:
			print('points')
			player.move_to(points[1])
			
	update() # we update the node so it has to draw it self again

func _draw():
	# if there are points to draw
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)