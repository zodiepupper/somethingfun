extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("resolution", get_window().size)

func _ready() -> void:
	animation_player.speed_scale = .1
	animation_player.play("new_animation")
