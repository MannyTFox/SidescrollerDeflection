extends CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement 
@export var characterGravity : CharacterGravity
@export var characterJump : CharacterJump
@export var characterFollowTarget : CharacterFollowTarget
var comboCounter = 0

func _ready():
	characterFollowTarget.target = get_parent().get_node("Player")

func _physics_process(delta):
	characterGravity._apply_gravity(delta)
	
	move_and_slide()
