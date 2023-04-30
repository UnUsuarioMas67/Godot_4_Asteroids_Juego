extends EffectLoop


func create():
	tween = create_tween().bind_node(self)
	tween.tween_callback(target.hide).set_delay(0.1)
	tween.tween_callback(target.show).set_delay(0.1)
	tween.set_loops()
	
	stop()


func stop():
	super.stop()
	target.show()
