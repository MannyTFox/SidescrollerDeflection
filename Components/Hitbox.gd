class_name Hitbox
extends Area2D

@export var damage : float = 10

func _on_area_entered(hurtbox):
	var my_parent = self.get_owner()
	var hurtbox_parent = hurtbox.get_owner()
	
	print(my_parent)
	print(hurtbox_parent)
	
	if my_parent == hurtbox_parent:
		pass
	else:
		
		if hurtbox_parent.has_node("Posture"):
			var posture_node = hurtbox_parent.get_node("Posture")
			if posture_node.has_method("_take_damage"):
				if posture_node.currentPosture < posture_node.maxPosture:
					posture_node._take_damage(damage)
				else: #posture broken
					if hurtbox_parent.has_node("Health"):
						var health_node = hurtbox_parent.get_node("Health")
						if health_node.has_method("_take_damage"):
								health_node._take_damage(damage)
								posture_node.currentPosture = posture_node.initialPosture
			else:
				print("no take damage method found")
		else:
			print("no health component found")
			
