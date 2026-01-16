class_name Player
extends CharacterBody2D

## Player Controller
##
## Handles high-friction "snappy" movement and the Kill Circle logic.

@export_group("Movement")
@export var max_speed: float = 600.0
@export var acceleration: float = 8000.0 # Doubled
@export var friction: float = 8000.0 # Doubled

@export_group("Combat")
@export var kill_circle_radius: float = 150.0

# Node References
@onready var kill_circle_visual: Node2D = $KillCircleVisual
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

func _ready() -> void:
	add_to_group("Player")
	
	# Connect signals
	if hurtbox_component:
		hurtbox_component.hit_received.connect(_on_hit_received)
	
	# Initialize visuals
	if kill_circle_visual:
		kill_circle_visual.radius = kill_circle_radius

func _on_hit_received(hitbox: HitboxComponent) -> void:
	# print("DEBUG: Player took damage from ", hitbox.name)
	# GameManager.hit_stop used to be here, but user requested no hit stop on damage.
	# Add simple flash later?
	pass

func _physics_process(delta: float) -> void:
	# Priority: Counter Rush > Dodge > Movement
	if GameManager.is_slow_motion:
		_check_counter_rush()
			
	_handle_movement(delta)
	
	# Only check Just Dodge if NOT in slow motion (don't stack slow mo)
	if not GameManager.is_slow_motion:
		_check_just_dodge()

func _check_counter_rush() -> void:
	if Input.is_action_just_pressed("dodges"):
		var enemies = get_tree().get_nodes_in_group("Enemy")
		var hit_count = 0
		
		for enemy in enemies:
			# Kill all enemies within the Kill Circle Instantly
			var dist_sq = global_position.distance_squared_to(enemy.global_position)
			if dist_sq <= get_kill_circle_radius_squared():
				if enemy.has_method("queue_free"): # Simple kill for now. Or use damage.
					# Use take_damage if available to be polite, or just force death
					var health = enemy.get_node_or_null("HealthComponent")
					if health:
						health.damage(9999) # Omae wa mou shindeiru
					else:
						enemy.queue_free()
					hit_count += 1
		
		if hit_count > 0:
			pass
			# Maybe restore time early? Or keep it slow to enjoy the destruction?
			# Let's keep it slow.

func _check_just_dodge() -> void:
	if Input.is_action_just_pressed("dodges"):
		var enemies = get_tree().get_nodes_in_group("Enemy")
		for enemy in enemies:
			# Distance Check (Squared is faster)
			var dist_sq = global_position.distance_squared_to(enemy.global_position)
			if dist_sq <= get_kill_circle_radius_squared():
				# State Check (Risk)
				if enemy.has_method("is_dodgeable") and enemy.is_dodgeable():
					# SUCCESS (Return)
					# 3.0s duration, 10% speed
					GameManager.start_slow_motion(3.0, 0.1) 
					return

func _handle_movement(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector != Vector2.ZERO:
		# Accelerate
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		# Friction
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()

# Called by Game Loop when inside Kill Circle logic check is needed
func get_kill_circle_radius_squared() -> float:
	return kill_circle_radius * kill_circle_radius
