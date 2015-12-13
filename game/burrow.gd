
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var shader
const AURA_WIDTH=6 

func _ready():
	shader = get_node("Sprite").get_material()
	set_contact_monitor(true)
	pass
	
func fox_enter():
	shader.set_shader_param("aura_width",AURA_WIDTH)


func fox_exit():
	shader.set_shader_param("aura_width",0)