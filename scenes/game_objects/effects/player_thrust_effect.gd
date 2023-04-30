extends EffectLoop


func create():
	tween = create_tween().bind_node(self)
	tween.tween_property(target, "modulate", Color(Color.WHITE, 0.25), 0).set_delay(0.06)
	tween.tween_property(target, "modulate", Color(Color.WHITE, 1), 0).set_delay(0.06)
	tween.set_loops()
