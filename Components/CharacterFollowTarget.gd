extends Node
class_name CharacterFollowTarget
@export var character : CharacterBody2D
var target : CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement
@export var minDistance : float = 400
@export var stoppingDistance : float = 90
@export var distance : float = 0

func _physics_process(_delta):
	
	distance = character.position.distance_to(target.position)
	
	if target:
		if distance <= stoppingDistance:
			_stop()
		elif distance <= minDistance:
			_chase()
		elif distance > minDistance:
			_stop()
		
			
func _chase():
	var direction = (target.position - character.position).normalized()
	
	characterHorizontalMovement._move(direction.x)
	
func _stop():
	characterHorizontalMovement._move(0)
