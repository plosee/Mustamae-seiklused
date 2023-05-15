extends Node

func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
