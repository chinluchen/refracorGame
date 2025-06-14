extends Area2D

@export var delta_mm := 1
var direction := -1  # 初始為縮小方向

@onready var hint = $PDHint  # 指向 Sprite2D 的 hover 圖示

func _ready():
	# 初始化提示圖片狀態
	hint.visible = false

	# 連接滑鼠事件
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var new_pd = RefractorState.pd_mm + direction * delta_mm

		# 邊界檢查並自動切換方向
		if new_pd <= RefractorState.pd_min or new_pd >= RefractorState.pd_max:
			direction *= -1
			new_pd = clamp(new_pd, RefractorState.pd_min, RefractorState.pd_max)

		# 更新狀態
		RefractorState.pd_mm = new_pd
		_update_eye_positions()

func _update_eye_positions():
	var parent_ui = get_tree().get_root().find_child("UI", true, false)
	if parent_ui:
		var eye_od = parent_ui.find_child("EyeWindowOD", true, false)
		var eye_os = parent_ui.find_child("EyeWindowOS", true, false)

		if eye_od and eye_os:
			var positions = RefractorState.get_eye_positions()
			eye_od.position.x = positions.x
			eye_os.position.x = positions.y

func _on_mouse_entered():
	hint.z_index = 500
	hint.z_as_relative = false
	hint.visible = true
	print("🟦 滑鼠進入")

func _on_mouse_exited():
	hint.visible = false
	hint.z_index = 0  # 或還原為預設值
	print("⬜ 滑鼠離開")
