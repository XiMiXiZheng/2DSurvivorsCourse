extends Node

var SAVE_DATA_PATH = "user://game.save"

var save_data: Dictionary = {
	"mate_upgrade_currency": 0,
	"mate_upgrades" : {}
}	


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
	load_save_file()
	

func load_save_file():
	if !FileAccess.file_exists(SAVE_DATA_PATH):
		return
	var file = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
	save_data = file.get_var() 
	
	
func save():
	var file = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
	file.store_var(save_data)
	

func add_meta_upgrade(upgrade: MetaUpgrade):
	if not save_data["mate_upgrades"].has(upgrade.id):
		save_data["mate_upgrades"][upgrade.id] = {
			"quantity": 0
		}
	save_data["mate_upgrades"][upgrade.id]["quantity"] += 1
	save()


func get_upgrade_count(upgrade_id: String):
	if save_data["mate_upgrades"].has(upgrade_id):
		return save_data["mate_upgrades"][upgrade_id]["quantity"]
	return 0
	

func on_experience_vial_collected(number: float):
	save_data["mate_upgrade_currency"] += number
	
