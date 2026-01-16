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
@onready var health_component: HealthComponent = $HealthComponent
@onready var weapon_pivot: WeaponComponent = $WeaponPivot

func _ready() -> void:
	add_to_group("Player")
	
	# Connect signals
	if hurtbox_component:
		hurtbox_component.hit_received.connect(_on_hit_received)
	
	# Initialize visuals
	if kill_circle_visual:
		kill_circle_visual.radius = kill_circle_radius

	if health_component:
		health_component.died.connect(_on_death)

func _on_death() -> void:
	GameManager.trigger_game_over()
	# queue_free() # Don't free to keep camera active
	hide()
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	if hurtbox_component:
		hurtbox_component.set_deferred("monitorable", false)
		hurtbox_component.set_deferred("monitoring", false)

func _on_hit_received(hitbox: HitboxComponent) -> void:
	# Impact Feedback
	# GameManager.hit_stop(0.15, 0.05, 0.0) # Disabled to fix blackout bug
	# GameManager.shake_camera(0.6) # Disabled to fix blackout bug
	
	# 3. Hit Flash (Visual)
	# Dark Red Flash (No HDR)
	var tween = create_tween()
	$Sprite2D.modulate = Color(1.0, 0.0, 0.0) # Standard Red Flash
	tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.3)

func _physics_process(delta: float) -> void:
	# Priority: Counter Rush > Dodge > Attack > Movement
	if GameManager.is_slow_motion:
		_check_counter_rush()
	else:
		_check_weapon_attack()
			
	_handle_movement(delta)
	
	# Only check Just Dodge if NOT in slow motion (don't stack slow mo)
	if not GameManager.is_slow_motion:
		_check_just_dodge()

func _check_weapon_attack() -> void:
	if Input.is_action_just_pressed("attack"): # Assuming 'attack' action exists or we use Left Click
		if weapon_pivot:
			# Attack towards mouse
			var mouse_pos = get_global_mouse_position()
			var direction = (mouse_pos - global_position).normalized()
			weapon_pivot.attack(direction)

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
		
		# Ghost Trail Effect (Juice)
		if GameManager.is_slow_motion:
			_spawn_ghost_trail()
	else:
		# Friction
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()

var _ghost_timer: float = 0.0
func _spawn_ghost_trail() -> void:
	_ghost_timer += get_process_delta_time() # Use raw delta?
	if _ghost_timer < 0.05: return
	_ghost_timer = 0.0
	
	# Create Sprite Copy
	var ghost = Sprite2D.new()
	ghost.texture = $Sprite2D.texture
	ghost.scale = $Sprite2D.scale
	ghost.global_position = global_position
	ghost.modulate = Color(0.5, 1.0, 1.0, 0.5) # Cyan Ghost
	ghost.z_index = z_index - 1
	
	# Attach Script for Auto-Fade
	ghost.set_script(load("res://_src/Effects/GhostTrail.gd"))
	
	get_parent().add_child(ghost)

# Called by Game Loop when inside Kill Circle logic check is needed
func get_kill_circle_radius_squared() -> float:
	return kill_circle_radius * kill_circle_radius
