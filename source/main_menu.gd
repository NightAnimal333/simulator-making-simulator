extends Node2D


func _ready():
	MusicPlayer.reset()
	MusicPlayer.get_node("Music").play()

func _on_StartGame_pressed():
	get_parent().add_child(load("res://source/game_screen.tscn").instance())
	queue_free()


func _on_QuitGame_pressed():
	get_tree().quit()


func _on_HSlider_value_changed(value):
	MusicPlayer.set_volume_percentage(value)
