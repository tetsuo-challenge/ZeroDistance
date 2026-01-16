extends Sprite2D

func _ready() -> void:
    # Quick fade out
    var tween = create_tween()
    tween.tween_property(self, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
    tween.tween_callback(queue_free)
