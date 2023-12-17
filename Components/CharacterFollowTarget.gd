extends Node
class_name CharacterFollowTarget
@export var character : CharacterBody2D
var target : CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement
@export var minDistance : float = 500

func _physics_process(delta):
	
	if character.position.distance_to(target.position) <= minDistance:
		_chase()
		
func _chase():
	var direction = (target.position - character.position).normalized()
	
	characterHorizontalMovement._move(direction.x)
	
