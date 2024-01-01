extends CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement 
@export var characterGravity : CharacterGravity
@export var characterJump : CharacterJump
@export var health : Health
@export var staggered = false
var canAttack = true
var comboCounter = 0

 #this method has to be here since animation events only work when calling something on a parent, it simply does not call for brothers or cousins in the hierarchy

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


	if health.currentHealth <= 0 || Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if is_on_floor() && !staggered:
		
		if Input.is_action_pressed("Guard"):
			characterHorizontalMovement._move(0)
			$AnimationTree.get("parameters/playback").travel("Guard")
		elif Input.is_action_just_released("Guard"):
			$AnimationTree.get("parameters/playback").travel("Idle")
		elif Input.is_action_just_pressed("Attack") && canAttack && !characterHorizontalMovement.frozen:
			if comboCounter <= 0:
				$AnimationTree.get("parameters/playback").travel("Attack1")
			elif comboCounter == 1:				
				$AnimationTree.get("parameters/playback").travel("Attack2")		
			elif comboCounter == 2:
				$AnimationTree.get("parameters/playback").travel("Attack3")		
		elif Input.is_action_just_pressed("Jump"):
			characterJump._jump()
			$AnimationTree.get("parameters/playback").travel("Jump")
		elif (Input.get_axis("Left", "Right")):
			characterHorizontalMovement._move(Input.get_axis("Left", "Right"))
			$AnimationTree.get("parameters/playback").travel("Run")
		else:
			characterHorizontalMovement._move(0)
			$AnimationTree.get("parameters/playback").travel("Idle")
	elif !staggered:		
		characterGravity._apply_gravity(delta)
		characterHorizontalMovement._move(Input.get_axis("Left", "Right"))
		if Input.is_action_just_pressed("Attack") && canAttack:
			
				if Input.is_action_pressed("Down"):
					$AnimationTree.get("parameters/playback").travel("DownAirAttack")
				else:
					$AnimationTree.get("parameters/playback").travel("AirAttack")
		elif Input.is_action_just_released("Jump"):
				characterJump._stopJump()
		else:
			$AnimationTree.get("parameters/playback").travel("Fall")
	else:
		$AnimationTree.get("parameters/playback").travel("Stagger")	

	if Input.get_axis("Left", "Right") > 0 && !characterHorizontalMovement.frozen:
		$Sprite.scale.x = .5
	
	elif Input.get_axis("Left", "Right") < 0 && !characterHorizontalMovement.frozen:
		$Sprite.scale.x = -.5
		
	move_and_slide()

func _stagger():
	staggered = true
	if $Sprite.scale.x == .5:
		characterHorizontalMovement._bump(-1, 100)
	elif $Sprite.scale.x == -.5:
		characterHorizontalMovement._bump(1, 100)	

	$StaggerRecover.start()

func _on_stagger_recover_timeout():
	staggered = false
	characterHorizontalMovement._move(0)
	$AnimationTree.get("parameters/playback").travel("Idle")
