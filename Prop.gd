class_name Prop extends Interactable

@export var charId: String = ""
@export_enum("first", "second") var lineKey: String = "first"

@onready var modelScene: Node3D = $ModelScene

@export var isDoor: bool
@export var hasText: bool
@export var finishDay: bool
@export var exitZone: Area3D
@export var isCake: bool

@export var keysDoor: bool
@export var keys: bool

@export var finishDoor: bool
@export var finishKeys: bool

@export var coffeeDoor: bool
@export var coffee: bool

@export var bookDoor: bool
@export var books: bool

@export var museumDoor: bool
@export var museumVisited: bool

@export var nextScenePath: String
@export var nextSceneName: String
@export var nextSceneTime: String
@export var nextSceneMessage: String

@export var initialSpawn: bool

func showKeyClue(message: String) -> void:
	Game.player.label.text = message
	Game.player.labelName.text = ""
	Game.isKeyClueVisible = true
	Game.player.dialogBox.visible = true
	Game.player.ui.visible = true
	Game.player.isFrozen = true
	Game.player.pressCue.visible = false

func _ready():
	var modelSceneChild = modelScene.get_child(0)
	if modelSceneChild:
		var animPlayer = modelSceneChild.get_node("AnimationPlayer")
		if animPlayer:
			animPlayer.play("IDLE")

func interact(currentInteractable):
	if !Game.player:
		return
	
	if isDoor and nextScenePath:
		if keysDoor and !Game.hasKeys:
			var message = 'Надо захватить ключи перед тем поеду в центр. Кажется они в кармане плаща. Он должен висить на стенке в коридоре справа.'
			showKeyClue(message)
			return
		if coffeeDoor and !Game.hasCoffee:
			var message = 'Как-то тупо зайти в кофейню и не купить кофе. Надо спросить у баристы.'
			await showKeyClue(message)
			return
		if bookDoor and !Game.hasBooks:
			var message = 'Надо забрать свой заказ. Я думаю он уже лежит собранный на кассе.'
			await showKeyClue(message)
			return
		if museumDoor and !Game.museumVisited:
			var message = 'Время еще есть. Можно сходить в музей и скоротать время.'
			await showKeyClue(message)
			return
		if finishDoor and !Game.canFinish:
			var message = 'Я только вышла. Надо сделать все дела и потом уже сидеть дома.'
			await showKeyClue(message)
			return
	
	if hasText:
		Game.player.dialogBox.visible = true
		Game.player.ui.visible = !Game.player.ui.visible
		
		if charId != "":
			var line = Dialogs.getLine(charId, lineKey)
			Game.player.label.text = line
			Game.player.labelName.text = charId
		else:
			Game.player.label.text = currentInteractable.message
		
		Game.player.isFrozen = Game.player.ui.visible
		Game.player.pressCue.visible = false
		
		if keys:
			Game.hasKeys = true
			var message = 'Вот и ключи. Можно выходить.'
			showKeyClue(message)
			return
		if coffee:
			Game.hasCoffee = true
			var message = 'Dobar dan, može jedno pakovanje Rwande Ghetsi za mene, hvala. Vidimo se, ćao.'
			await showKeyClue(message)
			return
		if books:
			Game.hasBooks = true
			var message = 'Здраствуйте, я за своим заказом. Номер 0451. Ага, спасибо.'
			await showKeyClue(message)
			return
		if museumVisited:
			Game.museumVisited = true
			var message = 'Это было занятно. Кажется я утомилась, пора двигать домой.'
			await showKeyClue(message)
			return
		if finishKeys:
			Game.museumVisited = true
			var message = 'Кажется, я сделала все что хотела, пора ехать домой.'
			await showKeyClue(message)
			return
			
	if isDoor:
		Game.initialSpawn  = initialSpawn
		Game.player.dialogBox.visible = false
		Transition.changeScene(nextScenePath, nextSceneName, nextSceneTime, nextSceneMessage)
		
	if finishDay:
			pass
