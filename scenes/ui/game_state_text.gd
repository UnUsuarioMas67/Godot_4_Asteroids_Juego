extends CanvasLayer


func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	stop_everything_else()


func stop_everything_else():
	var tree = get_tree()
	
	tree.paused = true
	
	var entities_layer = tree.get_first_node_in_group("entities_layer") as Node2D
	if entities_layer:
		entities_layer.hide()
	
	var hud = tree.get_first_node_in_group("hud") as CanvasLayer
	if hud:
		hud.hide()


func resume_everything_else():
	var tree = get_tree()
	
	tree.paused = false
	
	var entities_layer = tree.get_first_node_in_group("entities_layer") as CanvasItem
	if entities_layer:
		entities_layer.show()
	
	var hud = tree.get_first_node_in_group("hud") as CanvasLayer
	if hud:
		hud.show()


func on_timer_timeout():
	resume_everything_else()
	queue_free()
