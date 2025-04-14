extends Node3D

class_name Interactable

@export var player: CharacterBody3D
@export var isCharacter: bool
@export var isVisibleForPlayer2: bool
@export var message: String

func _ready():
	pass

func _process(delta):
	if Game.player:
		if Game.player.name == 'Player' and isVisibleForPlayer2:
			self.queue_free()
