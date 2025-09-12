# File: level_select.gd
extends Node2D  # 或 Control，依你的場景根節點決定

func _ready():
	AudioRoot.play_bgm_for_scene("intro")

# 還原 logs
	ActionLogger.import_logs_from_string(SceneManager.temp_log_string)
