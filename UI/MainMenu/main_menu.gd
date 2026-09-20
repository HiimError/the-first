extends Control

@export var click_sound: AudioStreamPlayer2D


func _on_start_game() -> void:
	click_sound.play()
	get_tree().change_scene_to_file("res://game.tscn")


func _quit_game() -> void:
	click_sound.play()
	get_tree().quit()
