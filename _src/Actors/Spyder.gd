class_name Enemy
extends CharacterBody2D

## Enemy AI (Spyder)
##
## Pursues player with steering behaviors and performs telegraphed attacks.

# Stats
@export var max_speed: float = 250.0
@export var acceleration: float = 800.0
@export var friction: float = 1200.0

# Components
@onready var health_component: HealthComponent = $HealthComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var visual_sprite: Sprite2D = $Sprite2D

# State Machine
enum State { CHASE, TELEGRAPH, ATTACK, COOLDOWN }
var current_state: State = State.CHASE

# Timers
var attack_timer: float = 0.0
const TELEGRAPH_DURATION: float = 0.5
const ATTACK_DURATION: float = 0.2
const COOLDOWN_DURATION: float = 1.0

# Target
var player: Player = null

func _ready() -> void:
	# Auto-find player for now (Simple prototype approach)
	player = get_tree().get_first_node_in_group("Player")
	add_to_group("Enemy") # For separation logic
	
	if health_component:
		health_component.died.connect(_on_death)

func _on_death() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	match current_state:
		State.CHASE:
			_process_chase_state(delta)
		State.TELEGRAPH:
			_process_telegraph_state(delta)
		State.ATTACK:
			_process_attack_state(delta)
		State.COOLDOWN:
			_process_cooldown_state(delta)
	
	move_and_slide()

# --- State Logic ---

func _process_chase_state(delta: float) -> void:
	if not player:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		return
		
	var direction_to_player = global_position.direction_to(player.global_position)
	var dist_to_player = global_position.distance_to(player.global_position)
	
	# Steering Behavior: Seek + Separation
	var desired_velocity = direction_to_player * max_speed
	
	# Separation Force (Soft Collision)
	var separation = _calculate_separation() * 1.5 
	desired_velocity += separation * max_speed
	
	# Apply velocity
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	
	# Transition to Attack
	# Condition: Close enough AND random chance or simple cooldown? 
	# Transition to Attack
	# Condition: Close enough AND random chance or simple cooldown? 
	# For prototype: Attack if within range 80px
	if dist_to_player < 80.0:
		_change_state(State.TELEGRAPH)

func _process_telegraph_state(delta: float) -> void:
	# Stop moving (Charge up)
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	attack_timer -= delta
	if attack_timer <= 0:
		_change_state(State.ATTACK)

func _process_attack_state(delta: float) -> void:
	# Lunge momentum is set in _change_state. 
	# Just slide here to let friction slow it down slightly or keep it constant?
	# Let's keep it constant for the short duration of the attack (0.2s)
	
	attack_timer -= delta
	if attack_timer <= 0:
		_change_state(State.COOLDOWN)

func _process_cooldown_state(delta: float) -> void:
	# Recover
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	attack_timer -= delta
	if attack_timer <= 0:
		_change_state(State.CHASE)

func _change_state(new_state: State) -> void:
	current_state = new_state
	
	match current_state:
		State.CHASE:
			visual_sprite.modulate = Color.WHITE
			hitbox_component.is_active = false
		State.TELEGRAPH:
			visual_sprite.modulate = Color(10.0, 0.5, 0.5) # Flash Bright Red (HDR)
			attack_timer = TELEGRAPH_DURATION
			hitbox_component.is_active = false
		State.ATTACK:
			visual_sprite.modulate = Color.RED
			attack_timer = ATTACK_DURATION
			hitbox_component.is_active = true # KILL!
			
			# LUNGE: Calculate burst velocity towards player
			if player:
				var lung_dir = global_position.direction_to(player.global_position)
				velocity = lung_dir * 500.0 # High burst speed
		State.COOLDOWN:
			visual_sprite.modulate = Color.GRAY
			attack_timer = COOLDOWN_DURATION
			hitbox_component.is_active = false

# --- Utility ---

func _calculate_separation() -> Vector2:
	var separation_force = Vector2.ZERO
	var neighbors = get_tree().get_nodes_in_group("Enemy")
	var count = 0
	var separation_radius = 60.0
	
	for neighbor in neighbors:
		if neighbor == self:
			continue
			
		var dist = global_position.distance_to(neighbor.global_position)
		if dist < 0.1: dist = 0.1 # Prevent div by zero
		
		if dist < separation_radius:
			var away = global_position - neighbor.global_position
			separation_force += away.normalized() / dist # Weaker as it gets further
			count += 1
			
	if count > 0:
		return separation_force.normalized()
	return Vector2.ZERO

# --- Public Queries ---

func is_dodgeable() -> bool:
	# Valid for Just Dodge if currently attacking (Hitbox is active)
	return current_state == State.ATTACK
