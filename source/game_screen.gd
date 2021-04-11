extends Node2D

const GAME_COMPLETION_RATE: float = 0.4
const COFFEE_DEPLETION_RATE: float = 1.1
const MADNESS_GROWTH_RATE: float = 0.6
const FOOD_DEPLETION_RATE: float = 0.3
const TEMP_CHANGE_RATE: float = 0.4

var game_frozen: bool = false
var coffee_frozen: bool = false
var madness_frozen: bool = false
var food_frozen: bool = false

onready var GameProgressBar: ProgressBar = $GameProgress
var game_progress: float = 0

onready var CoffeeProgressBar: ProgressBar = $CoffeeProgress
var coffee_progress: float = 100

onready var MadnessProgressBar: ProgressBar = $MadnessProgress
var madness_progress: float = 0

onready var TemperatureBar: TextureProgress = $Temperature
var temperature: float = 21
var window_open: bool = false

onready var Questionmark: TextureRect = $Questionmark
var bug: bool = false

var Wasp: Wasp = null
var wasp: bool = false

var in_minigame: bool = false

var lying: bool = false

func _ready():
	randomize()
	
func _process(delta):
	
	if game_progress >= 100:
		var next_screen = preload("res://source/victory_screen.tscn").instance() as VictoryScreen
		next_screen.ending = VictoryScreen.Endings.VICTORY
		get_parent().add_child(next_screen)
		queue_free()
	elif temperature >= 31 or temperature <= 10:
		var next_screen = preload("res://source/victory_screen.tscn").instance() as VictoryScreen
		next_screen.ending = VictoryScreen.Endings.DEFEAT
		get_parent().add_child(next_screen)
		queue_free()
	elif coffee_progress <= 0:
		var next_screen = preload("res://source/victory_screen.tscn").instance() as VictoryScreen
		next_screen.ending = VictoryScreen.Endings.DEFEAT
		get_parent().add_child(next_screen)
		queue_free()
	
	if not wasp and not game_frozen and not bug and not lying:
		game_progress += GAME_COMPLETION_RATE * delta
		
	if not coffee_frozen:
		coffee_progress -= COFFEE_DEPLETION_RATE * delta
	
	if not lying:
		madness_progress += MADNESS_GROWTH_RATE * delta
	else:
		madness_progress -= MADNESS_GROWTH_RATE * delta
		
	if window_open == true:
		temperature -= TEMP_CHANGE_RATE * delta
	else:
		temperature += TEMP_CHANGE_RATE * delta
		
	if (not wasp) and (window_open) and ((randi() % 1000) > 995):
		wasp = true
		Wasp = preload("res://source/wasp.tscn").instance() as Wasp
		Wasp.position = $WaspGenerator.position
		Wasp.get_node("Pressable").connect("pressed", self, "_on_Wasp_killed")
		add_child(Wasp)
		
	if (not bug) and (not in_minigame) and (not lying) and ((randi() % 1000) > 997):
		Questionmark.show()
		bug = true

func _physics_process(delta):
	GameProgressBar.value = game_progress
	CoffeeProgressBar.value = coffee_progress
	MadnessProgressBar.value = madness_progress
	
	TemperatureBar.value = temperature
	if temperature < 16:
		TemperatureBar.modulate = Color.blue
	elif temperature < 23:
		TemperatureBar.modulate = Color.yellow
	else:
		TemperatureBar.modulate = Color.red
		
		

func _on_PC_pressed():
	if lying or not bug:
		return
	self.hide()
	get_parent().add_child(preload("res://source/chipher_minigame.tscn").instance())
	in_minigame = true


func _on_Window_pressed():
	window_open = $Window.toggle_open()


func _on_Cup_pressed():
	self.hide()
	get_parent().add_child(preload("res://source/coffee_minigame.tscn").instance())
	in_minigame = true	
	
func _on_Wasp_killed():
	Wasp.get_node("Pressable").disconnect("pressed", self, "_on_Wasp_killed")
	MusicPlayer.get_node("Wasp").stop()
	MusicPlayer.get_node("Splat").play()
	Wasp.queue_free()
	wasp = false


func _on_Bed_pressed():
	if not lying:
		$Programmer.hide()
		$ProgrammerLying.show()
		lying = true
		
	else:
		$Programmer.show()
		$ProgrammerLying.hide()
		lying = false
