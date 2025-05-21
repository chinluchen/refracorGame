extends Button

func _ready():
	# 自動連接 BackToMenu 按鈕的 pressed() 信號
	self.connect("pressed", Callable(self, "_on_back_to_menu_pressed"))

# 切換到 intro.tscn
func _on_back_to_menu_pressed():
	print("🎉 BackToMenu 按鈕已按下！")
	
	# ✅ 切換到 intro 場景
	var error_code = get_tree().change_scene_to_file("res://scenes/intro.tscn")

	# ✅ 檢查是否有錯誤
	if error_code != OK:
		print("❌ 切換失敗，請檢查場景路徑或錯誤代碼！")
