
extends Node2D

export var INITIAL_HANGRY_TIME=10
export var growing_meta = 100

const STATUS_PLAYING = 0
const STATUS_GAMEOVER = 1
const STATUS_SUCCESS = 2
var status 

var burrow
var player
var inventory
var cam
var fx
var floor_map
var hangry_timer
var ui_timer
var ui_growing
var ui_success
var hangry_alert
var growing_amount=0
var food = []

func _ready():
	status = STATUS_PLAYING
	cam = get_node("Camera2D")
	player = get_node("Props/Fox")
	burrow = get_node("Props/Burrow")
	burrow.get_node("Area2D").connect("body_enter", self, "_burrow_enter")
	burrow.get_node("Area2D").connect("body_exit", self, "_burrow_exit")
	inventory = get_node("Control/UI/Inventory")
	ui_timer = get_node("Control/UI/Hangry")
	ui_growing = get_node("Control/UI/Growing")
	floor_map = get_node("Floor")
	hangry_timer = get_node("HangryTimer")
	hangry_alert = get_node("Control/UI/HangryAlert")
	ui_success = get_node("Control/UI/Success")
	fx = get_node("SamplePlayer")
	
	hangry_timer.set_wait_time(INITIAL_HANGRY_TIME)
	hangry_timer.start()
	
	hangry_timer.connect("timeout", self, "gameover")
	
	for food in get_tree().get_nodes_in_group("Food"):
		food.connect("has_got_it", self, "food_has_got_it")
	
	for signal_comeback in get_tree().get_nodes_in_group("signals"):
		signal_comeback.connect("body_enter", self, "comeback")
		
	set_fixed_process(true)

func comeback(body):
	player.set_pos(Vector2(burrow.get_pos().x, burrow.get_pos().y+130))
	
func gameover():
	print("gameover")
	status= STATUS_GAMEOVER
	get_node("GameOver").show_messages()
	set_fixed_process(false)

func food_has_got_it(food):
	player.set_food()
	self.food.append(food.food_amount)
	
	var panel = TextureFrame.new()
	panel.set_texture(food.icon)
	inventory.add_child(panel)
	
func _burrow_enter(body):
	if(body.get_name() != 'Fox'):
		return
		
	for food_amount in food:
		hangry_timer.set_wait_time(hangry_timer.get_time_left()+ (food_amount/2))
		growing_amount += food_amount
	for child in inventory.get_children():
		child.queue_free()
		
	
	food.clear()
	
	player.let_food()
	hangry_timer.start()	
	burrow.fox_enter()
	
func _burrow_exit(body):
	burrow.fox_exit()

func check_danger_tiles():
	var player_map_pos = floor_map.world_to_map(player.get_global_pos())
	var cell = floor_map.get_cell(player_map_pos.x, player_map_pos.y)
	if(cell == 3):
		fx.play("shot")
		gameover()
		player.status = player.STATUS_DIED
		player.get_shot()
		

func _fixed_process(delta):
	if(status != STATUS_PLAYING):
		return


	check_danger_tiles()

	cam.set_pos(player.get_pos())
	if(hangry_timer.get_time_left() < 10 ):
		hangry_alert.show()
	else:
		hangry_alert.hide()
	
	ui_timer.set_text("hangry: "+str( round(hangry_timer.get_time_left())))
	ui_growing.set_text("growing: "+ str(growing_meta) +" / "+str(growing_amount ))
	hangry_alert.set_text(str( round(hangry_timer.get_time_left())))
	
	if(growing_amount >= growing_meta):
		status = STATUS_SUCCESS
		ui_success.show_message()
		get_node("AnimationPlayer").play("zoom_out")
	
	update() # we update the node so it has to draw it self again


func next_level():
	if(get_node("/root/global").get_current_level() == str(5)):
		get_node("Finish").finish()
		return
		
	get_node("/root/global").next_level()
	get_tree().change_scene("res://scenes/previous.scn")
	
func _draw():
	pass