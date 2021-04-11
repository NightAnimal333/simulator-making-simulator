extends Node

signal game_over

func emit_game_over():
	emit_signal("game_over")
