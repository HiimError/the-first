extends CharacterBody2D
@export var speed := 700.0


func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("left" , "right" , "up" , "down")
	var move_direction := input_vector.normalized()
	velocity = speed * move_direction
	move_and_slide()
