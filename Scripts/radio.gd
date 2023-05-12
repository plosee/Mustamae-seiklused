extends AudioStreamPlayer3D
var play = false
var rng = RandomNumberGenerator.new()
var song = 0

var maryanne: AudioStream = preload("res://Misc/Music/Maryanne.mp3")
var alabama: AudioStream = preload("res://Misc/Music/Sweet Home Alabama.mp3")
var dream: AudioStream = preload("res://Misc/Music/Dreamscape.mp3")

func _on_InteractRay_radio():
	play = !play
	if play:
		song = rng.randi_range(1,3)
		rng.randomize()
		if song == 1:
			self.set_stream(maryanne)
		elif song == 2:
			self.set_stream(alabama)
		elif song == 3:
			self.set_stream(dream)
		play()
	else:
		stop()
