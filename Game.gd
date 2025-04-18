extends Node

var player: CharacterBody3D = null

var currentScenePath: String = ""
var initialSpawn: bool = true

var hasKeys = false
var hasCoffee = false
var hasBooks = false
var museumVisited = false
var canFinish = false

var isKeyClueVisible: bool = false

func _ready():
	$piano.stream.loop = true
	$piano.play()
	$bass.stream.loop = true
	$bass.play()
	$snare.stream.loop = true
	$snare.play()
	
	var current = get_tree().current_scene
	print("Scene file path:", current.scene_file_path)
	
	if current.scene_file_path == 'res://ApartmentsParty.tscn':
		$bell.stream.loop = true
		$bell.play()
		$ht.stream.loop = true
		$ht.play()
		$tamb.stream.loop = true
		$tamb.play
		$synth.stream.loop = true
		$synth.play()
		$cowbell.stream.loop = true
		$cowbell.play()
	
	
func toggleUi(state: bool) -> void:
	if player:
		player.ui.visible = state
		player.isFrozen = state

func reset():
	player = null
	currentScenePath = ""
