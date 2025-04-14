@tool

extends Node3D

@export var cameras: Array[CameraTrigger]
@export var index: int

@export_tool_button("setCameraBg", "Callable") var setCameraBgBtn = setCameraBg

func setCameraBg():
	cameras[index].setBg()
