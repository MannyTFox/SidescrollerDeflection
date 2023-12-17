extends Node
class_name CharacterFollowTarget
@export var character : CharacterBody2D
var target : CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement
@export var minDistance : float = 500

func _physics_process(delta):
	print(character.position.distance_to(target.position))
	
	if character.position.distance_to(target.position) <= minDistance:
		_chase()
		
func _chase():
	var direction
	var dist = character.position.distance_to(target.position)
	if dist > 0:
		direction = 1
	else:
		direction = -1
	characterHorizontalMovement._move(direction)
	
