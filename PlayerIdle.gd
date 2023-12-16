extends State
class_name PlayerIdle

@export var gravity: int = 1900
@export var player: CharacterBody2D
@export var sprite: Sprite2D
@export var animationPlayer: AnimationPlayer
var direction

func PhysicsUpdate(delta: float):
	#get direction
	direction = Input.get_axis("Left","Right")
	
	#make sure player stops and apply gravity
	player.velocity.x = 0
	player.velocity.y += gravity * delta
	
	#play animation
	animationPlayer.play("Idle")
	
	#if moving transition to run
	if !is_zero_approx(direction):
			Transitioned.emit(self,"Run")
			
	
	
	player.move_and_slide()
	
