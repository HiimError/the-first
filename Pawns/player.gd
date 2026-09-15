extends CharacterBody2D

signal player_died


@export var speed: float = 700.0

@export var max_health: float = 100
@export var health: float = 10


# Movement
func _physics_process(delta: float) -> void:
	
	# calculate the direction and movement speed for the player
	var input_vector = Input.get_vector("left" , "right" , "up" , "down")
	var move_direction := input_vector.normalized()
	velocity = speed * move_direction
	
	# Update attack rot, rotates the attack hitbox to face
	# the same direction that the player is facing
	update_attack_rot(input_vector.normalized())
	move_and_slide()


# this function takes in the direction the player is moving 
# and rotates the attack box to face the same direction as the movement
func update_attack_rot(direction: Vector2):
	$AttackRotPoint.rotation = direction.angle()


# this function is used to subtracting health and checking if dead
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
	pass


func die():
	emit_signal("player_died")
	print("Character is dead")
	
