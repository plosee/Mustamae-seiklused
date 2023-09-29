extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	$MapSprite.hide()
	$MapSprite/PlayerIndicator.position = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventKey && event.pressed:
		if event.keycode==4194306:
			$MapSprite.visible = !$MapSprite.visible
func _process(delta):
	if $MapSprite.visible:
##indicator bottom 200, 704
##indicator top 1545, -110
##global bottom -750 375
##global top 825, -525
#need peaks õiged olema
		$MapSprite/PlayerIndicator.position = Vector2(Global.PlayerLoc)
		
		
		
