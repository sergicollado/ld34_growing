
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var shader
var shader_cubs
const AURA_WIDTH=6 

func _ready():
	shader = get_node("burrow_sprite").get_material()
	shader_cubs = get_node("cubs").get_material()
	set_contact_monitor(true)
	pass
	
func fox_enter():
	shader.set_shader_param("aura_width",AURA_WIDTH)
	shader_cubs.set_shader_param("aura_width",AURA_WIDTH/2)


func fox_exit():
	shader.set_shader_param("aura_width",0)
	shader_cubs.set_shader_param("aura_width",0)
	
func fadeout():
	get_node("AnimationPlayer").play("fadeout")