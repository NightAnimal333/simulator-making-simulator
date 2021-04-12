extends Node2D

var words_list: Array = ["simulate", "recursion", "prototype", "coffee", "cipher", "wasp", "minigame", "game", "program", "while", "godot", "graphics", "sprite", "loop", "controls", "keyboard", "mouse", "monitor", "resolution", "madness", "work"]

var text: String

func _ready():
	
	GlobalSignalManager.connect("game_over", self, "_on_game_over")
	
	randomize()
	
	text = words_list[randi()%words_list.size()]
	var key: int = randi() % 24
	
	$VBoxContainer/Cipher.text = "Encryted text: " + caesars_cypher(text, key)
	
	var options = [text]
	
	var word = text
	
	for i in 3:
		while word in options:
			word = words_list[randi()%words_list.size()]
		options.append(word)
	
	options.shuffle()
	
	$VBoxContainer/Options.text = str(options)

func caesars_cypher(text: String, key: int) -> String:

	var result = ""
   # transverse the plain text
	for i in range(len(text)):
		var character: String = text[i]
	  # Encrypt lowercase characters in plain text
		result += char((ord(character) + key - 97) % 26 + 97)
		
	return result

func submit_deciphered(new_text: String):
	if new_text == text:
		get_parent().get_node("GameScreen").bug = false
		get_parent().get_node("GameScreen").in_minigame = false
		get_parent().get_node("GameScreen").Questionmark.hide()
		get_parent().get_node("GameScreen").game_progress += 4
		get_parent().get_node("GameScreen").madness_progress += 4
		get_parent().get_node("GameScreen").show()
	
		queue_free()

	else:
		$Deciphered.text = ""

func _on_Deciphered_text_entered(new_text):
	submit_deciphered($Deciphered.text)

func _on_Submit_pressed():
	submit_deciphered($Deciphered.text)
		
		
func _on_game_over():
	queue_free()


