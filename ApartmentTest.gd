extends Node3D

@onready var bedCam: Camera3D = $Camera6
@onready var livCam: Camera3D = $Camera7

@onready var bedFloor: MeshInstance3D = $Bedroom/MeshInstance3D
@onready var livFloor: MeshInstance3D = $LivingRoom/MeshInstance3D2

func _ready():
	bedFloor.visible = true
	livFloor.visible = false

func _process(_delta):	
	var curCam = get_viewport().get_camera_3d()
	
	if curCam == bedCam:
		bedFloor.visible = true
		livFloor.visible = false
	elif curCam == livCam:
		bedFloor.visible = false
		livFloor.visible = true
		
		
