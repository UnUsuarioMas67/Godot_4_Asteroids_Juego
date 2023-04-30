extends Node
class_name EffectLoop

@export var target: Node2D

var tween: Tween


func _ready():
	if target:
		create()


func create():
	pass


func start():
	tween.play()


func stop():
	tween.stop()
