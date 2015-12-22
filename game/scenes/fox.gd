
extends KinematicBody2D


export var speed = 70
var velocity
var friction = 0.85
var player
var current_scale
var food_amount = 0
const MAX_FOOD=3

const STATUS_LIFE =0
const STATUS_DIED =1
var status
var click_motion = false

func _ready():
	status = STATUS_LIFE
	velocity = Vector2(0,0)
	player = get_node("AnimationPlayer")
	current_scale = get_scale()
	set_fixed_process(true)

func can_carry():
	return food_amount < MAX_FOOD


func set_food():
	food_amount +=1

func let_food():
	food_amount = 0
	
func get_shot():
	set_fixed_process(false)
	player.play("get_shot")
	
func go(motion):
	if(status == STATUS_DIED):
		return
		
	click_motion=true
	var speed=motion.normalized()
	var angle = atan2(speed.x, speed.y)

	#left
	if (angle < 0):
		set_scale(Vector2(-current_scale.x,current_scale.y))
	else:
		set_scale(Vector2(current_scale.x,current_scale.y))
		
	if(player.get_current_animation() != "run"):
		player.play("run")
	move(motion)
	
	if (is_colliding()):
        var n = get_collision_normal()
#        motion = n.slide( motion ) 
        motion = n.slide( motion )
        move( motion )

func stop():
	click_motion=false	
func _fixed_process(delta):
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var move_up = Input.is_action_pressed("ui_up")
	var move_down = Input.is_action_pressed("ui_down")
	var cancel = Input.is_action_pressed("ui_cancel")

	if(cancel):
		get_tree().quit()
	if(status == STATUS_DIED):
		return
	
	if(move_right):
		velocity.x += speed*delta
		set_scale(Vector2(current_scale.x,current_scale.y))
		if(player.get_current_animation() != "run"):
			player.play("run")

	if(move_left):
		set_scale(Vector2(-current_scale.x,current_scale.y))
		velocity.x -= speed*delta
		if(player.get_current_animation() != "run"):
			player.play("run")
	if(not move_right and not move_left and not move_up and not move_down and not click_motion):
		if(player.get_current_animation() == "run"):
			player.play("idle")		

	if(move_up):
		velocity.y -= speed*delta
		if(player.get_current_animation() != "run"):
			player.play("run")

	if(move_down):
		velocity.y += speed*delta
		if(player.get_current_animation() != "run"):
			player.play("run")
			
	velocity.x *= friction
	velocity.y *= friction
	
	move(velocity)
	if (is_colliding()):
        var n = get_collision_normal()
#        motion = n.slide( motion ) 
        velocity = n.slide( velocity )
        move( velocity )

