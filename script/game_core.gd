extends Node

@onready var fade_animation := $CanvasLayer/FadeAnimation
@onready var tutorial_manager := $TutoriaManager

func _ready():
	# 播放淡入動畫
	fade_animation.play("fade_in")
	AudioRoot.play_bgm_for_scene("gamecore")

# 還原 logs
	ActionLogger.import_logs_from_string(SceneManager.temp_log_string)

	# 動畫完成後執行教學開始
	fade_animation.animation_finished.connect(_on_fade_animation_finished)

	# 連接 chart 切換
	$controlPanel/targetChartButton.connect(
	"chart_button_clicked",
	Callable($controlPanel/chart, "show_chart")
)

func _on_fade_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		tutorial_manager.start_tutorial()
