extends State
class_name PlayerRun
@export var runSpeed: int = 400
@export var gravity: int = 1900
@export var player: CharacterBody2D
@export var sprite: Sprite2D
@export var animationPlayer: AnimationPlayer

var direction

func PhysicsUpdate(delta: float):
	
	#get direction
	direction = Input.get_axis("Left","Right")
	#if still, transition to idle
	if is_zero_approx(direction):
			Transitioned.emit(self,"Idle")
	
	#play animation and flip sprite if needed
	animationPlayer.play("Run")
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true
		
	#apply movment
	player.velocity.x = direction * runSpeed
	player.velocity.y += gravity * delta
	player.move_and_slide()
	
