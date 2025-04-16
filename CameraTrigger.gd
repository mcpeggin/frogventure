@tool

extends Area3D

@export var bgNode: TextureRect
@export var bgImage: Texture
@export var cam: Camera3D

var isTrigger = false

func setBg() -> void:
	bgNode.texture = bgImage
	cam.current = true

func enterTrigger(body):
	if body.is_in_group('player'):
		print('enter')
		if bgImage and bgNode:
			bgNode.texture = bgImage
		isTrigger = true

func exitTrigger(body):
	if body.is_in_group('player'):
		print('exit')
		if bgImage and bgNode:
			bgNode.texture = bgImage
		isTrigger = false

func _process(_delta: float) -> void:
	if isTrigger && get_parent().current != true:
		get_parent().current = true
		cam.current = true
