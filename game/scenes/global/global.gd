extends Node


var currentScene = null
var current_level = 1

func _ready():
	currentScene = get_tree().get_root().get_child(0)
#	set_process_input(true)
	
func _input(event):
	var cancel = event.is_action_pressed("ui_cancel")


	if(cancel):
		get_tree().quit()

	
   #On load set the current scene to the last scene available
   
#
#   
# create a function to switch between scenes 
#func setScene(scene):
#   #clean up the current scene
#   currentScene.queue_free()
#   #load the file passed in as the param "scene"
#   var s = ResourceLoader.load(scene)
#   #create an instance of our scene
#   currentScene = s.instance()
#   # add scene to root
#   get_tree().get_root().add_child(currentScene)

func get_current_level():
	return str(current_level)
	
func next_level():
	current_level +=1