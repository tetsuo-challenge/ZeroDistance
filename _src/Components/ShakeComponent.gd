class_name ShakeComponent
extends Node

## Shake Component
##
## Applies shake effect to a target Node2D (usually Camera2D).
## Uses FastNoiseLite for smooth random movement.

@export var target: Node2D
@export var noise: FastNoiseLite

@export var shake_decay: float = 5.0
@export var max_offset: Vector2 = Vector2(10.0, 10.0)
@export var max_roll: float = 0.0

var trauma: float = 0.0 # 0.0 to 1.0 (Current intensity)
var noise_y: float = 0.0

func _ready() -> void:
    if not noise:
        noise = FastNoiseLite.new()
        noise.noise_type = FastNoiseLite.TYPE_PERLIN
        noise.frequency = 0.5
        noise.seed = randi()

func _process(delta: float) -> void:
    if trauma > 0.0:
        trauma = max(trauma - shake_decay * delta, 0.0)
        _shake()
    elif target and (target.offset != Vector2.ZERO or target.rotation != 0.0):
        # Reset
        target.offset = Vector2.ZERO
        target.rotation = 0.0

func add_trauma(amount: float) -> void:
    trauma = min(trauma + amount, 1.0)

func _shake() -> void:
    if not target: return
    
    var amount = pow(trauma, 2) # Quadratic falloff (feel better)
    
    noise_y += 1.0
    
    var rotation_z = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
    var offset_x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
    var offset_y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)
    
    target.rotation = rotation_z
    target.offset = Vector2(offset_x, offset_y)
