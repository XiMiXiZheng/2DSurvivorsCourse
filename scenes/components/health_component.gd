extends Node
class_name HealthComponent

signal died
signal health_changed
signal health_decrease

@export var max_health: float = 10
var curremt_health: float


func _ready() -> void:
	curremt_health = max_health


func damage(damage_amount: float):
	curremt_health = clamp(curremt_health - damage_amount, 0 , max_health)
	health_changed.emit()
	if damage_amount > 0:
		health_decrease.emit()
	Callable(check_death).call_deferred()


func heal(heal_amount: float):
	damage(-heal_amount)


func get_health_percent():
	if max_health <= 0:
		return 0
	
	return min(curremt_health / max_health, 1)


func check_death():
	if curremt_health == 0:
		died.emit()
		owner.queue_free()
