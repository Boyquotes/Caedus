extends Node2D


var time_left = 120
var insects_captured = 0
var insect_num = randi_range(4, 8)
var score = 0
var play_once = true

@onready var ant_scene = preload("res://ant.tscn")
@onready var ant2_scene = preload("res://ant2.tscn")
@onready var beetle_scene = preload("res://beetle.tscn")
@onready var game_over = $CanvasLayer/GameOver


func _ready():
	for i in range(insect_num):
		var insect_instance
		var insect_type = randi_range(0, 2)
		if insect_type == 0:
			insect_instance = ant_scene.instantiate()
		elif insect_type == 1:
			insect_instance = ant2_scene.instantiate()
		else:
			insect_instance = beetle_scene.instantiate()
		insect_instance.position = Vector2(randf_range(60, 580), randf_range(280, 30))
		if randi_range(0, 1) == 0:
			insect_instance.get_child(0).flip_h = true
		get_child(1).add_child(insect_instance)


func _process(delta):
	$CanvasLayer/Label.text = str(time_left)
	
	if insects_captured == insect_num:
		$CanvasLayer/Timer.stop()
		score = (insects_captured * time_left) / 10
		for i in $Ants.get_children():
			await get_tree().create_timer(.2).timeout
			$Ants.hide()
		$CanvasLayer/Win.show()
		$CanvasLayer/Win/Score.text = str(score)
		await get_tree().create_timer(1).timeout
		$CanvasLayer/Win/Button.show()
	
	if time_left == 0:
		if play_once:
			$CanvasLayer/Timer.stop()
			$CanvasLayer/Label.hide()
			game_over.start_dialouge()
			play_once = false
	
	for i in $Ants.get_children():
		if i.global_position.x > 640 or i.global_position.x < 0 or i.global_position.y > 480 or i.global_position.y < 0:
			insect_num -= 1
			i.queue_free()


func _on_insects_entered(area):
	insects_captured += 1

func _on_insects_exited(area):
	insects_captured -= 1

func _on_onesec_timeout():
	time_left -= 1

func _on_play_again_pressed():
	for i in $Ants.get_children():
		queue_free()
	get_tree().reload_current_scene()
