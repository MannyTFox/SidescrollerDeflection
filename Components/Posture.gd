class_name Posture
extends Node

@export var initialPosture : float = 0
@export var maxPosture : float = 100
@export var recoverySpeed : float = 10
@export var postureTimer : Timer
var currentPosture

func _ready():
	currentPosture = initialPosture

func _take_damage(damage):
	currentPosture = currentPosture + damage
	postureTimer.start()

func _physics_process(delta):
	$"../PostureLabel".text = str(currentPosture)

	
func _recover_posture():
	currentPosture = initialPosture
	

func _on_posture_timer_timeout():
	_recover_posture()
