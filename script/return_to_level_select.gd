extends Button

func _ready():
	# 自動連接 ReturnToLevelSelect 按鈕的 pressed() 信號
	self.connect("pressed", Callable(self, "_on_return_to_level_select_pressed"))

# 切換到 level_select 場景
func _on_return_to_level_select_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	print("📚 ReturnToLevelSelect 按鈕已按下！")



	# ✅ 切換到 level_select 場景
	var error_code = get_tree().change_scene_to_file("res://scenes/level_select.tscn")

	# ✅ 檢查是否有錯誤
	if error_code != OK:
		print("❌ 切換失敗，請檢查場景路徑或錯誤代碼！")
