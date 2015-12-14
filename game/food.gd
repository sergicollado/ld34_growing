
extends Area2D

export(Texture)  var icon
export var food_amount = 30
const STATUS_NORMAL = 0
const STATUS_ENTER = 1

var status

var player
signal has_got_it(texture)
	
func _ready():
	add_to_group("Food")
	status = STATUS_NORMAL
	player = get_node("AnimationPlayer")
	connect("body_enter", self, "_on_enter")

func _on_enter(body):
	if(not  body.can_carry() or status == STATUS_ENTER):
		if(not body.can_carry()):
			player.play("show_no_more")
		return
	status=STATUS_ENTER
	emit_signal("has_got_it", self)
	get_node("Sprite").set_z(5)
	player.play("enter")

func remove():
	queue_free()