
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass


func finish():
	get_node("AnimationPlayer").play("start")