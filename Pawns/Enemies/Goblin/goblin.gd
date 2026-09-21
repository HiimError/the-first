extends CharacterBody2D

@export var damage: float = 10
@export var movement_speed: float = 300
@export var dash_speed_increase: float = 600
@export var goal: Node2D = null

@export var health: float = 100

var dashing: bool = false
var dash_pos

func apply_damage(modifier: float = 0):
	for child in $AttackRotPoint/DamageArea.get_overlapping_bodies():
		if child.has_method("take_damage"):
			child.call("take_damage", damage + modifier)

func dash_attack():
	print("Dash Attacking")
	apply_damage(15)
	

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()

func start_dash() -> void:
	dash_pos = goal.global_position
	dashing = true

func _ready() -> void:
	dash_pos = goal.global_position
	$NavigationAgent2D.target_position = goal.global_position

func _physics_process(delta: float) -> void:
	# Dashing Movement
	if dashing:
		if global_position.distance_to(dash_pos) < 30:
			dashing = false
			dash_attack()
			$DashTimer.start()
			pass
		
		var dash_direction = global_position.direction_to(dash_pos).normalized()
		velocity = dash_direction * (movement_speed + dash_speed_increase)
		
		
	# Normal Movement
	else:
		var nav_point = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = nav_point * movement_speed
	
	move_and_slide()


func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != goal.global_position:
		$NavigationAgent2D.target_position = goal.global_position
	$NavTimer.start()
