# Copysin selle kusagilt
# HTML buildi vist local save ei lisa vist
# Edu kui exe vormis on ja seda peab repurposima 
extends Node
const savefile = "user://SAVEFILE.save"
var game_data = {}

func _ready():
	load_data()

func load_data():
	var file = File.new()
	if !file.file_exists(savefile):
		game_data = {
			"fullscreen": true,
			"vsync": false,
			"master_vol": -10,
			"music_vol": -10,
			"sfx_vol": -10,
		}
		save_data()
	file.open(savefile, File.READ)
	game_data = file.get_var()
	file.close()

func save_data():
	var file = File.new()
	file.open(savefile, File.WRITE)
	file.store_var(game_data)
	file.close
