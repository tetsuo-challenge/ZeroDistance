class_name WeaponComponent
extends Node2D

## Weapon Component
##
## Handles weapon logic, visuals (swing), and hitbox activation.
## Intended to be a child of the Player or Enemy.

@export var damage: float = 10.0
@export var cooldown: float = 0.4
@export var swing_duration: float = 0.15
@export var swing_angle: float = 120.0

@onready var visual_sprite: Sprite2D = $Sprite2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent
var cooldown_timer: Timer

var is_attacking: bool = false

func _ready() -> void:
	# Ensure hitbox is disabled initially
	if hitbox_component:
		hitbox_component.damage_amount = damage
		hitbox_component.is_active = false
	else:
		push_error("WeaponComponent: HitboxComponent not found!")
		
	if not cooldown_timer:
		cooldown_timer = Timer.new()
		cooldown_timer.one_shot = true
		add_child(cooldown_timer)

func attack(direction: Vector2) -> void:
	if is_attacking or not cooldown_timer.is_stopped():
		return
		
	is_attacking = true
	cooldown_timer.start(cooldown)
	
	# Visual Swing Logic
	# 1. Rotate entire weapon to face target direction
	rotation = direction.angle()
	
	# 2. Calculate local swing range
	# Start back (-60) swing to front (+60)
	var start_angle = -deg_to_rad(swing_angle / 2.0)
	var end_angle = deg_to_rad(swing_angle / 2.0)
	
	# We rotate the visual_sprite (or the whole node?)
	# Rotating 'self' rotates the pivot. So we can just tween rotation.
	
	# BUT wait, we just set rotation to direction.angle().
	# So we want to animate from (direction - 60) to (direction + 60).
	var target_base_rot = rotation
	
	rotation = target_base_rot + start_angle
	
	# ACTIVATE HITBOX
	if hitbox_component:
		hitbox_component.is_active = true
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# Tween to end angle
	tween.tween_property(self, "rotation", target_base_rot + end_angle, swing_duration)
	
	tween.tween_callback(func():
		if hitbox_component:
			hitbox_component.is_active = false
		is_attacking = false
	)
