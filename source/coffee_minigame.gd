extends Node2D

var pouring_state: bool = true

func _ready():
	GlobalSignalManager.connect("game_over", self, "_on_game_over")
	
	$Cup.value = 0
	$Press.value = 100

# Called when the node enters the scene tree for the first time.
func _process(delta):
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("pour") and pouring_state:
		$Cup.value += 5
		$Press.value -= 3
		if not MusicPlayer.get_node("WaterSounds").is_playing():
			MusicPlayer.get_node("WaterSounds").play()
		
		if $Cup.value >= 100:
			pouring_state = false
			$Hint.animation = "spacebar"
			$Hint.scale = Vector2(2, 2)
		
	if Input.is_action_just_pressed("action") and not pouring_state:
		$Cup.value -= 3
		if not MusicPlayer.get_node("Drink").is_playing():		
			MusicPlayer.get_node("Drink").play()
		
		
		if $Cup.value <= 0:
			get_parent().get_node("GameScreen").show()
			get_parent().get_node("GameScreen").coffee_progress += 40
			get_parent().get_node("GameScreen").in_minigame = false
			queue_free()

func _on_game_over():
	queue_free()
