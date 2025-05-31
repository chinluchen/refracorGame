extends Node

# RefractorState.gd
var sphere_od: float = 0.00
var sphere_os: float = 0.00
# 你可以擴充更多欄位，例如 cylinder, axis, PD ...

# 清空資料
func reset():
	sphere_od = 0.00
	sphere_os = 0.00

# scripts/states/RefractorState.gd
var pd_mm := 80
var pd_min := 50
var pd_max := 80

# 取得 PD 的對應左右眼位置（你原本用的是像素）
func get_eye_positions():
	var offset_px := (pd_max - pd_mm) * 2  # 2 px per 1 mm

	var od_x = 425.0 + offset_px
	var os_x = 975.0 - offset_px

	return Vector2(od_x, os_x)
