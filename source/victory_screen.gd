extends Node2D

class_name VictoryScreen

enum Endings{
	VICTORY,
	DEFEAT_COFFEE,
	DEFEAT_MADNESS,
	DEFEAT_TEMPERATURE_LOW,
	DEFEAT_TEMPERATURE_HIGH,
}

var texts: Dictionary = {Endings.VICTORY: "Congratulations! You have finished the game jam!",
						Endings.DEFEAT_COFFEE: "You couldn't manage to feed your coffee addiction!",
						Endings.DEFEAT_MADNESS: "Too much work drove you completely insane!",
						Endings.DEFEAT_TEMPERATURE_LOW: "You froze to death in your room!",
						Endings.DEFEAT_TEMPERATURE_HIGH: "You burned alive in your room!"}

var ending = Endings.VICTORY

func _ready():
	MusicPlayer.get_node("Music").stop()
	if ending == Endings.VICTORY:
		MusicPlayer.get_node("Fanfare").play()
	else:
		MusicPlayer.get_node("Defeat").play()
	GlobalSignalManager.emit_game_over()
	$VBoxContainer/Label.text = texts[ending]

func _on_BactToMainMenu_pressed():
	get_parent().add_child(load("res://source/main_menu.tscn").instance())
	queue_free()
