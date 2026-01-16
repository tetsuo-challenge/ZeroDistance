class_name HitboxComponent
extends Area2D

## Hitbox Component
##
## Defines an area that can inflict damage.
## Requires a CollisionShape2D as a child.

@export var damage_amount: float = 10.0
@export var is_active: bool = true:
    set(value):
        is_active = value
        _update_collision_shape()

func _ready() -> void:
    _update_collision_shape()

func _update_collision_shape() -> void:
    var shape = get_node_or_null("CollisionShape2D")
    if shape:
        # deferred is required for changing physics state during physics step
        shape.set_deferred("disabled", !is_active)
    
    # Also toggle monitorable for good measure
    monitorable = is_active
