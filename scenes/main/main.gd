extends Node

@onready var player: Player = %Player as Player

@export var end_screen_scene: PackedScene

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")


func _ready() -> void:
	player.health_component.died.connect(on_player_died)
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu_instance = pause_menu_scene.instantiate() as PauseMenu
		add_child(pause_menu_instance)
		get_tree().root.set_input_as_handled()
		
	
func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save()
