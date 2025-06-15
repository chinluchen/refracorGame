extends Button

func _ready():
	# 自動連接 BackToMenu 按鈕的 pressed() 信號
	self.connect("pressed", Callable(self, "_on_back_to_menu_pressed"))

func _on_back_to_menu_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	print("🎉 BackToMenu 按鈕已按下！")
	
	ActionLogger.clear_logs()  # ✅ 清除 log
	
	var packed = load("res://scenes/intro.tscn")
	var error_code = get_tree().change_scene_to_packed(packed)

	if error_code != OK:
		print("❌ 切換失敗，請檢查場景路徑或錯誤代碼！")
