extends CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement 
@export var characterGravity : CharacterGravity
@export var characterJump : CharacterJump
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
	
func _on_combo_time_limit_timeout():
	if comboCounter != 0:
		comboCounter = 0
		

func _physics_process(delta):
	
	$FunctionLabel.text = str(comboCounter)
	
	if is_on_floor():
		
		if Input.is_action_pressed("Guard"):
			characterHorizontalMovement._move(0)
			$AnimationTree.get("parameters/playback").travel("Guard")
			print("guard")
		
		elif Input.is_action_just_pressed("Attack"):
			if comboCounter <= 0:
				$AnimationTree.get("parameters/playback").travel("Attack1")
			else:				
				$AnimationTree.get("parameters/playback").travel("Attack2")
				
			
		elif Input.is_action_just_pressed("Jump"):
			characterJump._jump()
			$AnimationTree.get("parameters/playback").travel("Jump")
			
		elif !is_zero_approx(Input.get_axis("Left", "Right")):
			characterHorizontalMovement._move(Input.get_axis("Left", "Right"))
			$AnimationTree.get("parameters/playback").travel("Run")
			
		elif is_zero_approx(Input.get_axis("Left", "Right")):
			characterHorizontalMovement._move(0)
			$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		characterGravity._apply_gravity(delta)
		characterHorizontalMovement._move(Input.get_axis("Left", "Right"))
		$AnimationTree.get("parameters/playback").travel("Fall")
		

	if Input.get_axis("Left", "Right") > 0 && !characterHorizontalMovement.frozen:
		$Sprite.flip_h = false
	elif Input.get_axis("Left", "Right") < 0 && !characterHorizontalMovement.frozen:
		$Sprite.flip_h = true
		
	move_and_slide()




