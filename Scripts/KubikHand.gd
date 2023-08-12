extends Node3D

# addib kopsudele kemikaale
func _on_character_kimu():
	if Global.KimuPuffs < 500:
		Global.KimuPuffs += 1
	else:
		Global.KimuSmoke = true
	
	if Global.KimuCapacity > 1.0:
		Global.KimuCapacity -= 0.02
		print(Global.KimuCapacity)
	
func _on_interact_ray_kubikrefill():
	Global.KimuCapacity = 100.0
	
func _process(delta):
	# kood, et vaadata kas inimene kimub v mitte, todo: rework
	if Global.KimuSmoke == true && Global.KimuPuffs > 1:
		# votab kopsudest kemikaale valja
		Global.KimuPuffs -= 1
		
	if Global.KimuPuffs < 2:
		# lopetada kimu particleid kui kemikaalid saavad otsa
		Global.KimuSmoke = false
		
	if Global.KimuCapacity <= 1.0:
		# tappa kimumine ara kui vedla otsas
		Global.KubikPickup = false


