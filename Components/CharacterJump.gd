extends Node
class_name CharacterJump
@export var characterGravity : CharacterGravity
@export var character : CharacterBody2D
@export var jumpForce : float = 800

func _jump():
	character.velocity.y -= jumpForce
