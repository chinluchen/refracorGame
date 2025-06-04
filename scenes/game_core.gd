extends Node

@onready var fade_animation := $CanvasLayer/FadeAnimation
@onready var tutorial_manager := $TutoriaManager

func _ready():
	# 播放淡入動畫
	fade_animation.play("fade_in")

	# 動畫完成後執行教學開始
	fade_animation.animation_finished.connect(_on_fade_animation_finished)

func _on_fade_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		tutorial_manager.start_tutorial()
