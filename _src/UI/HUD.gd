extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var score_label: Label = $Control/ScoreLabel

# Dependencies (to be injected or found)
var player_health_component: HealthComponent

func _ready() -> void:
    # Find dependencies if not manually connected
    var player = get_tree().get_first_node_in_group("Player")
    if player:
        player_health_component = player.get_node("HealthComponent")
        if player_health_component:
            _setup_health_bar(player_health_component)
    
    # Connect to Game Manager for score
    GameManager.score_updated.connect(_update_score)
    
    # Init Score
    _update_score(0)

func _setup_health_bar(health_comp: HealthComponent) -> void:
    health_bar.max_value = health_comp.max_health
    health_bar.value = health_comp.current_health
    health_comp.health_changed.connect(_on_health_changed)

func _on_health_changed(new_health: float) -> void:
    health_bar.value = new_health
    
    # Visual Flair: Change color if low?
    if new_health <= health_bar.max_value * 0.3:
        health_bar.modulate = Color(1, 0, 0) # Red
    else:
        health_bar.modulate = Color(1, 1, 1) # White

func _update_score(new_score: int) -> void:
    score_label.text = "KILLS: %d" % new_score
