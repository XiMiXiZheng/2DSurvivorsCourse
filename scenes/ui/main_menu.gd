extends CanvasLayer

var options_menu_scene = preload("res://scenes/ui/options_menu.tscn")

@onready var play_button: Button = %PlayButton as Button
@onready var options_button: Button = %OptionsButton as Button
@onready var quit_button: Button = %QuitButton as Button
@onready var upgrades_button: Button = %UpgradesButton


func _ready() -> void:
	play_button.pressed.connect(on_play_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	upgrades_button.pressed.connect(on_upgrades_button_pressed)


func on_play_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	

func on_upgrades_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().change_scene_to_file("res://scenes/ui/meta_menu.tscn")
	

func on_options_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_menu_instance = options_menu_scene.instantiate() as OptionsMenu
	add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(on_options_menu_closed.bind(options_menu_instance))
	
	
func on_quit_button_pressed():
	get_tree().quit()


func on_options_menu_closed(options_menu_instance: OptionsMenu):
	options_menu_instance.queue_free()


	
