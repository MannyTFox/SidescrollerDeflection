extends CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement 
@export var characterGravity : CharacterGravity
@export var characterJump : CharacterJump
@export var characterFollowTarget : CharacterFollowTarget
var comboCounter = 0

func _ready():
	characterFollowTarget.target = get_parent().get_node("Player")

func _physics_process(delta):
	print(velocity.x)
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true
	
	characterGravity._apply_gravity(delta)
	if !is_zero_approx(velocity.x):
		$AnimationTree.get("parameters/playback").travel("Run")
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
	move_and_slide()
