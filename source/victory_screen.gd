extends Node2D

class_name VictoryScreen

enum Endings{
	VICTORY,
	DEFEAT
}

var texts: Dictionary = {Endings.VICTORY: "Congratulations! You have finished your simulator! It's ready to ship!",
						Endings.DEFEAT: "You didn't manage to finish your game, too many disctractions! Better luck next time!"}

var ending = Endings.VICTORY

func _ready():
	MusicPlayer.get_node("Music").stop()
	GlobalSignalManager.emit_game_over()
	$Label.text = texts[ending]

func _on_BactToMainMenu_pressed():
	get_parent().add_child(load("res://source/main_menu.tscn").instance())
	queue_free()
