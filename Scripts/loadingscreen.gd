extends Control

const target_scene_path = "res://Scenes/DebugWorld.tscn"

var loading_status : int
var progress : Array[float]

@onready var progress_bar : ProgressBar = $ProgressBar

func _ready():
	# request to load scene
	ResourceLoader.load_threaded_request(target_scene_path)
	
func _process(_delta : float):
	# update progress bar]
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path,progress)
	
	#check loading
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("putsis")
