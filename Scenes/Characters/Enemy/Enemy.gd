extends CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement 
@export var characterGravity : CharacterGravity
@export var characterJump : CharacterJump
@export var characterFollowTarget : CharacterFollowTarget
@export var health : Health

var canAttack = true
var comboCounter = 0


func _ready():
	var player = get_node("../Player")
	characterFollowTarget.target = player
	print(player)

func _freeze():
	characterHorizontalMovement.frozen = true
func _unfreeze():
	characterHorizontalMovement.frozen = false
	
func _reset_combo_counter():
	comboCounter = 0
func _increase_combo_counter():
	comboCounter += 1
	$ComboTimeLimit.start()
func _start_combo_cooldown():
	canAttack = false
	$ComboCooldown.start()
func _on_combo_cooldown_timeout():
	canAttack = true

func _on_combo_time_limit_timeout():
	if comboCounter != 0:
		comboCounter = 0
		

func _physics_process(delta):

	if health.currentHealth <= 0:
		queue_free()

	if !is_on_floor():
		characterGravity._apply_gravity(delta)
		$AnimationTree.get("parameters/playback").travel("Fall")	
	else:
		if !is_zero_approx(velocity.x):
			$AnimationTree.get("parameters/playback").travel("Run")	
		else:
			$AnimationTree.get("parameters/playback").travel("Idle")	
		
		
	if characterFollowTarget.character.position.distance_to(characterFollowTarget.target.position) <= characterFollowTarget.stoppingDistance && canAttack:
		$AnimationTree.get("parameters/playback").travel("Attack1")
		characterHorizontalMovement._move(0)
	
	if velocity.x > 0 && !characterHorizontalMovement.frozen:
		$Sprite.scale.x = .5
	
	elif velocity.x < 0 && !characterHorizontalMovement.frozen:
		$Sprite.scale.x = -.5
	
	
	
	move_and_slide()






