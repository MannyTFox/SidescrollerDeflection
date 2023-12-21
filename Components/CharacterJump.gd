extends Node
class_name CharacterJump
@export var characterGravity : CharacterGravity
@export var character : CharacterBody2D
@export var jumpForce : float = 800

func _jump():
	character.velocity.y -= jumpForce
	
func _stopJump():
	if character.velocity.y < 0:
		character.velocity.y += jumpForce/2
