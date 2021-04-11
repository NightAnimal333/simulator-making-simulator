extends Node


func set_volume_percentage(percentage: float):
	var volume_db = -60 + (60 * percentage/100)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

