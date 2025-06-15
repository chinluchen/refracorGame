extends Button

func _ready():
	# 自動連接 Replay 按鈕的 pressed() 信號
	self.connect("pressed", Callable(self, "_on_replay_pressed"))

# 重新加載 gameCore 場景
func _on_replay_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	print("🎮 Replay 按鈕已按下！")

	# ✅ 清除 Log（這段若不希望重置記憶可註解）
	ActionLogger.clear_logs()

	# ✅ 使用 PackedScene 切換場景，避免 HTML5 清空 AutoLoad
	var packed = load("res://scenes/gameCore.tscn")
	var error_code = get_tree().change_scene_to_packed(packed)

	if error_code != OK:
		print("❌ 切換失敗，請檢查場景路徑或錯誤代碼！")
