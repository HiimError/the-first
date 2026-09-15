extends Control

@export var click_sound: AudioStreamPlayer2D


func _on_start_game() -> void:
	click_sound.play()


func _quit_game() -> void:
	click_sound.play()
	get_tree().quit()
