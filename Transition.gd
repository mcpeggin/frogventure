extends Node

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@onready var nameLabel: Label = $UI/ColorRect/Info/Name
@onready var timeLabel: Label = $UI/ColorRect/Info/Time
@onready var messageLabel: Label = $UI/ColorRect/Info/Message

var isActive: bool = false

#func _ready():
	#print('the end')
	#var currentScene = get_tree().current_scene
	#if currentScene.scene_file_path == "res://Apartments.tscn" and Game.player.name == "Player2":
		#_the_end_sequence()
#
#func _the_end_sequence():
	#nameLabel.text = "THE END"
	#messageLabel.text = "-party is under construction-"
	#animPlayer.play("fadeIn")
	#await animPlayer.animation_finished
	#await get_tree().create_timer(3.0).timeout
	#get_tree().quit()

func changeScene(
		scenePath: String, 
		sceneName: String, 
		sceneTime: String, 
		sceneMessage: String
	) -> void:
		
	if isActive:
		return
	isActive = true
	
	nameLabel.text = sceneName
	timeLabel.text = sceneTime
	messageLabel.text = sceneMessage
	
	animPlayer.play("fadeIn")
	await animPlayer.animation_finished
	
	var nextScene = load(scenePath)
	if nextScene and nextScene is PackedScene:
		get_tree().change_scene_to_packed(nextScene)
		await get_tree().process_frame
	
	animPlayer.play("fadeOut")
	await animPlayer.animation_finished
	isActive = false
