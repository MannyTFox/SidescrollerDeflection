extends CharacterBody2D
@export var characterHorizontalMovement : CharacterHorizontalMovement 
@export var characterGravity : CharacterGravity
@export var characterFollowTarget : CharacterFollowTarget
@export var health : Health
var canAttack = true
var alive = true
@export var staggered = false


func _start_attack_cooldown():
	canAttack = false
	$AttackCooldown.start

	
func _on_attack_cooldown_timeout():
	canAttack = true
	

func _ready():
	var player = get_node("../Player")
	characterFollowTarget.target = player
	


func _physics_process(delta):
	
	characterGravity._apply_gravity(delta)
	if health.currentHealth > 0:
		alive = true
	else:
		alive = false
	
	if velocity.x > 0 && !characterHorizontalMovement.frozen:
		$Sprite.scale.x = -1
	
	elif velocity.x < 0 && !characterHorizontalMovement.frozen:
		$Sprite.scale.x = 1
		
	if characterFollowTarget.distance <= characterFollowTarget.stoppingDistance && canAttack == true && !staggered && alive:
		$Sprite/AnimationTree.get("parameters/playback").travel("Attack")	
	elif characterFollowTarget.distance <= characterFollowTarget.stoppingDistance && canAttack == false && !staggered && alive:
		$Sprite/AnimationTree.get("parameters/playback").travel("Idle")	
	elif staggered && alive:
		$Sprite/AnimationTree.get("parameters/playback").travel("Hurt")	
	elif !alive:
		$Sprite/AnimationTree.get("parameters/playback").travel("Die")	
	move_and_slide()



func _stagger():
	#$Sprite/AnimationTree.get("parameters/playback").travel("Hurt")	
	staggered = true
	
func _die():
	queue_free()
