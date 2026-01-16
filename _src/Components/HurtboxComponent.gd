class_name HurtboxComponent
extends Area2D

## Hurtbox Component
##
## Detects incoming HitboxComponents and relays damage to a HealthComponent.
## Requires a CollisionShape2D as a child and a linked HealthComponent.

signal hit_received(hitbox: HitboxComponent)

@export var health_component: HealthComponent

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    if not area is HitboxComponent:
        return
    
    var hitbox: HitboxComponent = area as HitboxComponent
    
    if not hitbox.is_active:
        return
        
    if health_component:
        health_component.damage(hitbox.damage_amount)
    
    hit_received.emit(hitbox)
