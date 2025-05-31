extends Node

# 球面度數（右眼、左眼）
var sphere_od: float = 0.00
var sphere_os: float = 0.00

# PD（瞳距）
var pd_mm := 80
var pd_min := 50
var pd_max := 80

# 清空所有資料
func reset():
	sphere_od = 0.00
	sphere_os = 0.00
	pd_mm = pd_max
	_update_sphere_label("SpherePowerOD", sphere_od)
	_update_sphere_label("SpherePowerOS", sphere_os)

# 初始化（場景一開始載入時顯示度數與顏色）
func initialize():
	_update_sphere_label("SpherePowerOD", sphere_od)
	_update_sphere_label("SpherePowerOS", sphere_os)

# 取得 OD / OS 的位置（基於 PD）
func get_eye_positions():
	var offset_px := (pd_max - pd_mm) * 2  # 2 px 對應 1 mm
	var od_x = 425.0 + offset_px
	var os_x = 975.0 - offset_px
	return Vector2(od_x, os_x)

# 加減右眼度數
func add_sphere_od(delta: float):
	sphere_od = clamp(sphere_od + delta, -20.0, 20.0)
	_update_sphere_label("SpherePowerOD", sphere_od)

# 加減左眼度數
func add_sphere_os(delta: float):
	sphere_os = clamp(sphere_os + delta, -20.0, 20.0)
	_update_sphere_label("SpherePowerOS", sphere_os)

# 更新 UI 上的 Label 顯示與顏色
func _update_sphere_label(label_name: String, value: float):
	var label = get_tree().get_root().find_child(label_name, true, false)
	if label:
		label.text = "%.2f" % abs(value)
		if value == 0.0:
			label.modulate = Color.BLUE
		elif value > 0.0:
			label.modulate = Color.BLACK
		else:
			label.modulate = Color.RED
