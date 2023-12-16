extends CharacterBody2D

var speed = 80
var jump_impulse = 360
var gravity = 1200
var acceleration = 60
var friction = 20
var air_friction = 10

var _velocity : = Vector2.ZERO

func get_input_direction () -> float:
	var direction = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	
	if direction < 0:
		$"Sprite".flip_h = true
	if direction > 0:
		$"Sprite".flip_h = false
	
	return direction
