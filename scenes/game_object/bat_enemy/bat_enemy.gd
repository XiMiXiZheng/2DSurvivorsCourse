extends CharacterBody2D
class_name BatEnemy

@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent
@onready var visuals: Node2D = $Visuals
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent as HurtBoxComponent
@onready var hit_random_audio_player_component: RandomAudioStreamPlayer2DComponent = %HitRandomAudioPlayerComponent as RandomAudioStreamPlayer2DComponent


func _ready() -> void:
	hurt_box_component.hit.connect(on_hit)


func _process(delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign !=0:
		visuals.scale = Vector2(move_sign, 1)


func on_hit():
	hit_random_audio_player_component.play_random()
