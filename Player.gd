extends CharacterBody2D

enum PlayerState {
	IDLE,
	RUN,
	JUMP,
	FALL,
	ATTACK,
}

var current_state: PlayerState = PlayerState.IDLE
var direction
# Exported variables
@export var speed: int = 800
@export var jump_force: int = 800
@export var gravity: int = 1600

# Main physics process function
func _physics_process(delta):
	
	direction = Input.get_axis("Left", "Right")
	
	if direction:
		current_state = PlayerState.RUN
	elif !direction && is_on_floor():
		current_state = PlayerState.IDLE
	
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		current_state = PlayerState.JUMP
	
	if !is_on_floor():
		current_state = PlayerState.FALL
		
	match current_state:
		
		PlayerState.IDLE:
			_Idle(delta)
		PlayerState.RUN:
			_Run(delta)
		PlayerState.JUMP:
			_Jump(delta)
		PlayerState.FALL:
			_Fall(delta)
		PlayerState.ATTACK:
			_Attack(delta)
			
	move_and_slide()
	
	if direction > 0:
		$"Kaito-sheet".flip_h = false
	elif direction < 0:
		$"Kaito-sheet".flip_h = true
	


func _Idle(delta):
	$"Kaito-sheet/AnimationPlayer".play("Idle")
	velocity.x = 0
	
func _Run(delta):
	$"Kaito-sheet/AnimationPlayer".play("Run")
	velocity.x = direction * speed

	
func _Jump(delta):
	$"Kaito-sheet/AnimationPlayer".play("Jump")
	velocity.x = direction * speed
	velocity.y -= jump_force

	
func _Fall(delta):
	
	velocity.x = direction * speed
	velocity.y += gravity * delta


	
func _Attack(delta):
	pass
