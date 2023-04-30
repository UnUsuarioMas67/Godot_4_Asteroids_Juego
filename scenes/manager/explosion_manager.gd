extends Node2D

@export var explosion_effect_scene: PackedScene

## You can pass an collision_component and this node will create an explosion when an impact signal is emmited
@export var collision_component: CollisionComponent
@export_range(0.0, 2.0) var explosion_scale = 1.0


func _ready():
	if collision_component:
		collision_component.impact.connect(on_impact)


func create_explosion():
	var effects_layer = get_tree().get_first_node_in_group("effects_layer")
	
	if !effects_layer:
		return
	
	var explosion_effect_instance = explosion_effect_scene.instantiate() as Node2D
	effects_layer.add_child(explosion_effect_instance)
	explosion_effect_instance.global_position = global_position
	explosion_effect_instance.scale *= explosion_scale


func on_impact():
	create_explosion()
