extends CharacterBody3D

@export var speed: float = 2.5
@export var rotation_speed: float = 3.0

@onready var questionIcon: Sprite3D = $QuestionIcon
@onready var exclamationIcon: Sprite3D = $ExclamationIcon

@onready var warningArea: Area3D = $WarningArea
@onready var interactionZone: Area3D = $InteractionZone

@onready var ui: CanvasLayer = $UI
@onready var colorRect: ColorRect = $UI/ColorRect
@onready var dialogBox: PanelContainer = $UI/DialogBox
@onready var label: Label = $UI/DialogBox/Label
@onready var labelName: Label = $UI/DialogBox/LabelName

@onready var pressCue: Label = $Clue/PressCue

@onready var info: Control = $UI/ColorRect/Info
@onready var sceneName: Label = $UI/ColorRect/Info/SceneName
@onready var sceneTime: Label = $UI/ColorRect/Info/Time
@onready var task: Label = $UI/ColorRect/Info/Task

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@onready var modelAnim: AnimationPlayer = $model/irene_new_anim/AnimationPlayer

var isInWarningArea: bool = false
var isInInteractionZone: bool = false

var currentInteractable: Node = null

var isFrozen: bool = false

var isDancing: bool = false

func _ready():
	Game.player = self
	ui.visible = false

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("endSession"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("dance"):
		if not isDancing:
			isDancing = true
			modelAnim.play("DANCE")
	
	if Game.isKeyClueVisible and Input.is_action_just_pressed("interact"):
			Game.player.dialogBox.visible = false
			Game.player.ui.visible = false
			Game.player.isFrozen = false
			Game.isKeyClueVisible = false
			return
	
	if !isFrozen:
		var move_input = Input.get_action_strength("back") - Input.get_action_strength("forward")
		var turn_input = Input.get_action_strength("left") - Input.get_action_strength("right")
		
		var isMoving = move_input != 0 or turn_input != 0
		
		if isDancing and isMoving:
			isDancing = false
			modelAnim.stop()
			modelAnim.play("WALK")

		if not isDancing:
			if isMoving:
				modelAnim.play("WALK")
			else:
				modelAnim.play("IDLE")
		
		if turn_input != 0:
			rotation.y += turn_input * rotation_speed * delta
		
		var dir = -transform.basis.z * move_input * speed
		dir.y = 0
		
		velocity = dir
		move_and_slide()
	
	if Input.is_action_just_pressed('interact') and currentInteractable:
			if currentInteractable.has_method('interact'):
				currentInteractable.interact(currentInteractable)

func _updateIcons():
	if isInInteractionZone:
		exclamationIcon.visible = true
		questionIcon.visible = false
		pressCue.visible = true
	elif isInWarningArea:
		questionIcon.visible = true
		exclamationIcon.visible = false
		pressCue.visible = false
	else:
		questionIcon.visible = false
		exclamationIcon.visible = false
		pressCue.visible = false

func _on_warning_interaction_area_area_entered(area):
	if area.is_in_group("interactables"):
		isInWarningArea = true
		_updateIcons()

func _on_warning_interaction_area_area_exited(area):
	if area.is_in_group("interactables"):
		isInWarningArea = false
		_updateIcons()

func _on_interaction_zone_area_entered(area):
	if area.is_in_group("interactables"):
		isInInteractionZone = true
		currentInteractable = area.get_owner()
		_updateIcons()

func _on_interaction_zone_area_exited(area):
	if area.is_in_group("interactables"):
		isInInteractionZone = false
		if currentInteractable == area.get_owner():
			currentInteractable = null
		_updateIcons()

func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "DANCE":
		isDancing = false
