extends TextureButton

# 目標角度清單：增加一個新角度（例如 90 度）
var target_angles = [121, 357, 240]  # 140、270、90 度
var current_index = 0  # 目前目標角度索引

# 旋轉動畫的 Tween
var tween: Tween = null

func _ready():
	# 連接按鈕按下的信號
	self.connect("pressed", Callable(self, "_on_turning_button_pressed"))

# 當按下 ExamArrayTurningOD 時觸發
func _on_turning_button_pressed():
	# 獲取父節點（ExamArrayOD）
	var parent_array = get_parent()
	
	# 確保 parent_array 存在並且是 TextureButton
	if parent_array is TextureButton:
		# 設定目標角度
		var target_angle = target_angles[current_index]
		
		# 切換到下一個目標角度（來回切換 140、270 和 90）
		current_index = (current_index + 1) % target_angles.size()
		
		# 如果 tween 存在且運作中，先停止它
		if tween != null and tween.is_running():
			tween.kill()
		
		# 創建新的 Tween 並執行旋轉動畫
		tween = create_tween()
		tween.tween_property(parent_array, "rotation_degrees", target_angle, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		
		print("🔄 旋轉 ExamArrayOD 至：", target_angle, "度")
