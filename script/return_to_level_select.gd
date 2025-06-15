extends Button

func _ready():
	self.connect("pressed", Callable(self, "_on_return_to_level_select_pressed"))

func _on_return_to_level_select_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	print("📚 ReturnToLevelSelect 按鈕已按下！")

	var packed = load("res://scenes/level_select.tscn")
	var error_code = get_tree().change_scene_to_packed(packed)

	if error_code != OK:
		print("❌ 切換失敗，請檢查場景路徑或錯誤代碼！")
