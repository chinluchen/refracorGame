extends TextureButton

# 設定範圍
var od_min_x = 425.0  # EyeWindowOD 的最小位置
var od_max_x = 485.0  # EyeWindowOD 的最大位置
var os_max_x = 975.0  # EyeWindowOS 的最大位置
var os_min_x = 915.0  # EyeWindowOS 的最小位置
var step_size = 2.0   # 每次移動的距離

# 設定移動方向
var od_direction = 1  # 1 表示向右（增加），-1 表示向左（減少）
var os_direction = -1  # -1 表示向左（減少），1 表示向右（增加）

# 參考 PDShow Label
var pd_show
var max_pd_value = 80  # 初始 PD 顯示數值為 80
var min_pd_value = 50  # 最小 PD 顯示數值為 50

func _ready():
	# 連接按鈕按下的信號
	self.connect("pressed", Callable(self, "_on_pd_button_pressed"))

	# ✅ 嘗試自動尋找 PDShow，即使它不在同一個層級
	pd_show = get_tree().get_root().find_child("PDShow", true, false)

	# ✅ 確認是否找到 PDShow
	if pd_show == null:
		print("⚠️ 找不到 PDShow，請檢查名稱或節點層級！")
	else:
		print("✅ PDShow 已找到！")

	# ✅ 初始化 PDShow Label
	_update_pd_show(80)  # 起始數值設為 80

# 當按下 PD 按鈕時觸發
func _on_pd_button_pressed():
	# 獲取 EyeWindowOD 和 EyeWindowOS
	var parent_array = get_parent()
	var eye_od = parent_array.get_node("EyeWindowOD")
	var eye_os = parent_array.get_node("EyeWindowOS")

	# 確保兩個節點都存在
	if eye_od != null and eye_os != null:
		# ✅ 計算 EyeWindowOD 和 EyeWindowOS 的新位置
		var new_od_x = eye_od.position.x + (step_size * od_direction)
		var new_os_x = eye_os.position.x + (step_size * os_direction)

		# ✅ 檢查邊界並切換方向
		if new_od_x >= od_max_x or new_od_x <= od_min_x:
			od_direction *= -1  # 切換 EyeWindowOD 的方向
			print("🔁 EyeWindowOD 方向改變，現在方向：", od_direction)

		if new_os_x <= os_min_x or new_os_x >= os_max_x:
			os_direction *= -1  # 切換 EyeWindowOS 的方向
			print("🔁 EyeWindowOS 方向改變，現在方向：", os_direction)

		# ✅ 限制位置在範圍內
		new_od_x = clamp(new_od_x, od_min_x, od_max_x)
		new_os_x = clamp(new_os_x, os_min_x, os_max_x)

		# ✅ 立即更新位置，無動畫
		eye_od.position.x = new_od_x
		eye_os.position.x = new_os_x

		# ✅ 計算並更新 PDShow 數值
		_update_pd_show(_calculate_pd_value(new_od_x, new_os_x))

# ✅ 計算 PDShow 數值
func _calculate_pd_value(od_x, os_x):
	# 計算 OD 和 OS 之間的變化量（2px 對應 1 減少）
	var od_offset = (od_x - od_min_x) / step_size  # 計算 OD 的偏移量
	var pd_value = max_pd_value - int(od_offset)

	# ✅ 確保 PDShow 數值在範圍內
	pd_value = clamp(pd_value, min_pd_value, max_pd_value)

	return pd_value

# ✅ 更新 PDShow Label 的數值
func _update_pd_show(pd_value):
	if pd_show != null:
		# ✅ 顯示純數字（無小數點）
		pd_show.text = "%d" % pd_value
