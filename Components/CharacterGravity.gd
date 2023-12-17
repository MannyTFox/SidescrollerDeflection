extends Node
class_name CharacterGravity
@export var character : CharacterBody2D
@export var gravity : float = 1900

# Called when the node enters the scene tree for the first time.
func _apply_gravity(delta):
	character.velocity.y += gravity * delta
