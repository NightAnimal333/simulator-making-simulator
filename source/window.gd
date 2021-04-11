extends TextureButton


var open: bool = false

var open_tex: Texture = preload("res://assets/window_open.png")
var open_aura_tex: Texture = preload("res://assets/window_open_aura.png")
var closed_tex: Texture = preload("res://assets/window_closed.png")
var closed_aura_tex: Texture = preload("res://assets/window_closed_aura.png")

func toggle_open() -> bool:
	if open:
		open = false
		texture_normal = closed_tex
		texture_hover = closed_aura_tex
		return false
	else:
		open = true
		texture_normal = open_tex
		texture_hover = open_aura_tex
		return true
