
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	add_to_group("signals")
	connect("body_enter", self, "enter")
	
func enter():
	get_node("AnimationPlayer").play("enter")


