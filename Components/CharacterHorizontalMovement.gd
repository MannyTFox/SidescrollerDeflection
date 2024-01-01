extends Node
class_name CharacterHorizontalMovement
@export var speed : float = 800
@export var character : CharacterBody2D
@export var frozen = false




func _move(direction):
	if !frozen:
		character.velocity.x = direction * speed
	else:
		character.velocity.x = 0

func _bump(direction, bumpSpeed):
	character.velocity.x += direction * bumpSpeed

func _toggle():
	frozen = !frozen


