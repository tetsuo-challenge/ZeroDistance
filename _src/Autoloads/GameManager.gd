extends Node

## Game Manager
##
## Handles global game state and time manipulation.
## Registered as an Autoload/Singleton.

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS # Keep running even when game is paused

func hit_stop(duration: float, scale: float = 0.05, zoom_intensity: float = 0.1) -> void:
	# Slow down time drastically to simulate a "stop"
	Engine.time_scale = scale
	
	# Camera Zoom (Impact)
	var camera = get_viewport().get_camera_2d()
	var original_zoom = Vector2.ONE
	if camera:
		original_zoom = camera.zoom
		camera.zoom = original_zoom * (1.0 + zoom_intensity)
	
	# Wait for duration (using real time, not game time)
	# ignore_time_scale is true, so we pass the full duration in seconds
	await get_tree().create_timer(duration, true, false, true).timeout
	
	# Restore Camera
	if camera:
		camera.zoom = original_zoom
		
	# Restore time
	Engine.time_scale = 1.0


var is_slow_motion: bool = false

func start_slow_motion(duration: float = 1.0, scale: float = 0.1) -> void:
	is_slow_motion = true
	Engine.time_scale = scale
	
	# 1. Screen Flash (Flashbang)
	var canvas = CanvasLayer.new()
	var color_rect = ColorRect.new()
	color_rect.color = Color.WHITE
	color_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(color_rect)
	get_tree().root.add_child(canvas)
	
	# Tween Flash
	var tween = create_tween().set_ignore_time_scale(true)
	tween.tween_property(color_rect, "modulate:a", 0.0, 0.3).from(1.0)
	tween.tween_callback(canvas.queue_free)
	
	# 2. Chromatic Aberration (Distortion)
	# Hacky way to find WorldEnvironment in current scene for prototype
	var world_env = get_tree().root.find_child("WorldEnvironment", true, false)
	var initial_ca = 0.0
	
	if world_env and world_env.environment:
		# Safer access using get() to avoid crash if property invalid
		var env = world_env.environment
		if "chromatic_aberration_strength" in env:
			initial_ca = env.chromatic_aberration_strength
			# Tween IN
			var env_tween = create_tween().set_ignore_time_scale(true)
			env_tween.tween_property(env, "chromatic_aberration_strength", 1.0, 0.2)
		else:
			print("DEBUG: Attribute 'chromatic_aberration_strength' missing on Environment resource.")

	# Wait for duration (using real time)
	await get_tree().create_timer(duration, true, false, true).timeout
	
	# Tween OUT Distortion
	if world_env and world_env.environment:
		var env = world_env.environment
		if "chromatic_aberration_strength" in env:
			var out_tween = create_tween().set_ignore_time_scale(true)
			out_tween.tween_property(env, "chromatic_aberration_strength", initial_ca, 0.5)

	Engine.time_scale = 1.0
	is_slow_motion = false
