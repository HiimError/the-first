extends CharacterBody2D

@export var health: float = 100


func take_damage(amount: float):
	health -= amount
	if health <= 0:
		queue_free()
	else:
		print("ow, I took %s damage!" % amount)
