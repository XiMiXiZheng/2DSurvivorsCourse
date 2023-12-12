extends PanelContainer
class_name MetaUpgradeCard 

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel
@onready var count_label: Label = %CountLabel

var upgrade: MetaUpgrade

func _ready() -> void:
	purchase_button.pressed.connect(on_purchase_button_pressed)
	gui_input.connect(on_gui_input)


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()
	

func update_progress():
	var current_quantity: int = 0
	if  MetaProgression.save_data["mate_upgrades"].has(upgrade.id):
		current_quantity = MetaProgression.save_data["mate_upgrades"][upgrade.id]["quantity"]
	var is_maxed: bool = current_quantity == upgrade.max_quantity
	var currency = MetaProgression.save_data["mate_upgrade_currency"]
	var percent = min(currency / upgrade.experience_cost, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1 || is_maxed
	if is_maxed:
		purchase_button.text = "Max"
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)
	#print(MetaProgression.save_data["mate_upgrades"][upgrade.id]["quantity"])
	count_label.text = "x%d" % current_quantity
	
	
func select_card():
	animation_player.play("selected")


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		select_card()
		

func on_purchase_button_pressed():
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["mate_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	select_card()
