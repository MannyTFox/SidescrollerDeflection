extends CharacterBody2D

enum PlayerState {
	IDLE,
	RUN,
	JUMP,
	FALL,
	ATTACK,
	GUARD,
}

var current_state: PlayerState = PlayerState.IDLE
var direction
# Exported variables
@export var speed: int = 400
@export var jump_force: int = 400
@export var gravity: int = 900
@export var lock_player: bool = false


# Main physics process function
func _physics_process(delta):
	
	if !lock_player:
		direction = Input.get_axis("Left", "Right")
	else:
		direction = 0
		velocity.x = 0
		
	if is_on_floor():
		if direction:
			current_state = PlayerState.RUN
		else:
			current_state = PlayerState.IDLE
	else:
		current_state = PlayerState.FALL
			
			
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		current_state = PlayerState.JUMP
		
	if Input.is_action_just_pressed("Attack") && is_on_floor():
		current_state = PlayerState.ATTACK
		
	if Input.is_action_pressed("Guard") && is_on_floor():
		current_state = PlayerState.GUARD
		lock_player = true
	if Input.is_action_just_released("Guard"):
		lock_player = false
		
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
		PlayerState.GUARD:
			_Guard(delta)
			
	move_and_slide()
	
	if direction > 0:
		$"Kaito-sheet".flip_h = false
	elif direction < 0:
		$"Kaito-sheet".flip_h = true
	


func _Idle(delta):
	
	$"Kaito-sheet/AnimationTree".get("parameters/playback").travel("Idle")
	velocity.x = 0
	
func _Run(delta):
	
	$"Kaito-sheet/AnimationTree".get("parameters/playback").travel("Run")
	velocity.x = direction * speed
	

	
func _Jump(delta):
	velocity.x = direction * speed
	velocity.y -= jump_force
	$"Kaito-sheet/AnimationTree".get("parameters/playback").travel("Jump")
	
func _Fall(delta):

	velocity.x = direction * speed
	velocity.y += gravity * delta
	
	if velocity.y >= 0:
		$"Kaito-sheet/AnimationTree".get("parameters/playback").travel("Fall")
	

func _Attack(delta):
	$"Kaito-sheet/AnimationTree".get("parameters/playback").travel("Attack")
	

func _Guard(delta):
	$"Kaito-sheet/AnimationTree".get("parameters/playback").travel("Guard")
