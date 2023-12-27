class_name Health
extends Node

@export var initialHealth : float = 100
@export var maxHealth : float = 100
var currentHealth

func _ready():
	currentHealth = initialHealth

func _take_damage(damage):
	currentHealth = currentHealth - damage

func _physics_process(delta):
	$"../HPLabel".text = str(currentHealth)
