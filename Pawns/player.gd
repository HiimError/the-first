extends CharacterBody2D

signal player_died


@export var speed: float = 700.0

@export var max_health: float = 100
@export var health: float = 10
@export var damage: float = 10

var dealing_damage: bool = false

func _ready() -> void:
	health = max_health
	$CanvasLayer/Control/Label.text = "Health: {0}/{1}".format([health, max_health])

func attempt_attack():
	# Check if attack cooldown has finished
	if $AttackReset.time_left != 0:
		pass # pass just exits the function without continuing down the function
	
	# Get all bodies that overlap the damage aread
	var overlapping_bodies: Array[Node2D] = $AttackRotPoint/Area2D.get_overlapping_bodies()
	# Foreach body overlapping the damage area
	for body in overlapping_bodies:
		if body == self: # if the overlapped body is the player, just move to next body in the loop
			continue
		# Check if the current body being looped over has the take damage function
		# and if so call it, providing the damage amount the player deals
		if body.has_method("take_damage"):
			body.call("take_damage", damage)




# this function is used to subtracting health and checking if dead
func take_damage(amount: int) -> void:
	health -= amount
	$CanvasLayer/Control/Label.text = "Health: {0}/{1}".format([health, max_health])
	if health <= 0:
		die()


func die():
	emit_signal("player_died")
	print("Character is dead")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attempt_attack()

# Movement
func _physics_process(_delta: float) -> void:
	
	# calculate the direction and movement speed for the player
	var input_vector = Input.get_vector("left" , "right" , "up" , "down")
	var move_direction := input_vector.normalized()
	velocity = speed * move_direction
	
	# Update attack rot, rotates the attack hitbox to face
	# the same direction that the player is facing
	if velocity.length() > 0:
		update_attack_rot(input_vector.normalized())
	
	# Process movement
	move_and_slide()


# this function takes in the direction the player is moving 
# and rotates the attack box to face the same direction as the movement
func update_attack_rot(direction: Vector2):
	var rounded = snapped(rad_to_deg(direction.angle()), 90)
	$AttackRotPoint.rotation_degrees = rounded
