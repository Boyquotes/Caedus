extends Node2D


var messages = ["your time has run out, and the insects escaped!"]
var typing_speed = 0.1
var read_time = 2
var current_message = 0
var display = ""
var current_char = 0


func start_dialouge():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.wait_time = typing_speed
	$next_char.start()


func stop_dialouge():
	queue_free()


func _on_next_char_timeout():
	if current_char < len(messages[current_message]):
		var next_char = messages[current_message][current_char]
		display += next_char
		$Label2.text = display
		current_char += 1
	else:
		$Button.show()
