@tool
extends Node2D

## Visualizes the Kill Circle.

@export var radius: float = 150.0:
    set(value):
        radius = value
        queue_redraw()

@export var circle_color: Color = Color(0.1, 0.1, 0.1, 0.5) # Dark semi-transparent
@export var border_color: Color = Color(0.8, 0.0, 0.0, 1.0) # Red rim

func _draw() -> void:
    draw_circle(Vector2.ZERO, radius, circle_color)
    draw_arc(Vector2.ZERO, radius, 0.0, TAU, 64, border_color, 2.0)
