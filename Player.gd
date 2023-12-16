extends CharacterBody2D

enum PlayerState { IDLE, RUN, JUMP, FALL, ATTACK, GUARD }
var state: PlayerState = PlayerState.IDLE
var direction
var speed: int = 800
var jump_force: int = 800
var gravity: int = 1900
var functionLabel

var combo_timer: float = 0.0
var combo_sequence: int = 0

func _ready():
	functionLabel = $FunctionLabel

func _physics_process(delta):
	_handle_input(delta)

	if is_on_floor():
		match state:
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
	else:
		_Fall(delta)

	move_and_slide()

	if direction > 0:
		$Sprite.flip_h = false
	elif direction < 0:
		$Sprite.flip_h = true

func _handle_input(delta):
	direction = Input.get_axis("Left", "Right")

	if is_on_floor():
		if direction:
			state = PlayerState.RUN
		else:
			state = PlayerState.IDLE

		if Input.is_action_just_pressed("Jump"):
			state = PlayerState.JUMP

		if Input.is_action_just_pressed("Attack"):
			state = PlayerState.ATTACK

		if Input.is_action_pressed("Guard"):
			state = PlayerState.GUARD
	else:
		state = PlayerState.FALL


func _Idle(delta):
	_handle_animations("Idle")
	velocity.x = 0

func _Run(delta):
	_handle_animations("Run")
	velocity.x = direction * speed

func _Jump(delta):
	_handle_animations("Jump")
	velocity.x = direction * speed
	velocity.y -= jump_force

func _Fall(delta):
	_handle_animations("Fall")
	velocity.x = direction * speed
	velocity.y += gravity * delta

	if velocity.y >= 0:
		_handle_animations("Fall")

func _Attack(delta):
	_handle_animations("Attack")
	velocity.x = 0

func _Guard(delta):
	_handle_animations("Guard")
	velocity.x = 0

func _handle_animations(state: String):
	functionLabel.text = state
	$Sprite/AnimationTree.get("parameters/playback").travel(state)
