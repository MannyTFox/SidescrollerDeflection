extends Node
class_name CharacterFollowTarget
@export var character : CharacterBody2D
var target : CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement
@export var minDistance : float = 400
@export var stoppingDistance : float = 90
func _physics_process(delta):
	
	if target:
		if character.position.distance_to(target.position) <= stoppingDistance:
			_stop()
		elif character.position.distance_to(target.position) <= minDistance:
			_chase()
		elif character.position.distance_to(target.position) > minDistance:
			_stop()
		
			
func _chase():
	var direction = (target.position - character.position).normalized()
	
	characterHorizontalMovement._move(direction.x)
	
func _stop():
	characterHorizontalMovement._move(0)
