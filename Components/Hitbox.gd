class_name Hitbox
extends Area2D

@export var damage : float = 10

func _on_area_entered(hurtbox):
	var my_parent = self.get_owner()
	var hurtbox_parent = hurtbox.get_owner()
	
	print("Hitbox from parent named " + my_parent.name + " has detected hurtbox from parent named " + hurtbox_parent.name)
	
	if my_parent == hurtbox_parent:
		pass 
	else:
		
		if hurtbox_parent.has_node("Health"):
			var health_node = hurtbox_parent.get_node("Health")
			if health_node.has_method("_take_damage"):
				health_node._take_damage(damage)
			else:
				print("no take damage method found")
		else:
			print("no health component found")
			
