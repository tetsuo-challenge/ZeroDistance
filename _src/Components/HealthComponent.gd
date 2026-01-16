class_name HealthComponent
extends Node

## Health Component
##
## Tracks health and signals death.
## Designed to be a child node of any actor (Player, Enemy).

signal health_changed(new_health: float, max_health: float)
signal died

@export var max_health: float = 100.0

var current_health: float

func _ready() -> void:
    current_health = max_health
    # Emit initial state in the next frame to ensure parents are ready
    call_deferred("_emit_health_changed")

func damage(amount: float) -> void:
    current_health = max(0.0, current_health - amount)
    _emit_health_changed()
    
    if current_health <= 0.0:
        died.emit()

func heal(amount: float) -> void:
    if current_health <= 0.0:
        # Do not resurrect dead entities by default
        return
        
    current_health = min(max_health, current_health + amount)
    _emit_health_changed()

func _emit_health_changed() -> void:
    health_changed.emit(current_health) # Changed to match HUD expectation just in case, or update HUD to accept 2 args?
    # Actually, let's keep it clean. HUD.gd: _on_health_changed(new_health: float)
    # Signal: health_changed(new_health, max_health)
    # This works in Godot 4.
