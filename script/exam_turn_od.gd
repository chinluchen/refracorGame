# File: exam_turn_od.gd
extends Area2D

@onready var exam_array_ui_od = get_tree().get_root().find_child("ExamArrayUIOD", true, false)  # ExamArrayUIOD
@onready var eye_window_od := get_tree().get_root().find_child("EyeWindowOD", true, false)
@onready var hint = get_tree().get_root().find_child("ExamTurnHintOD", true, false)

var offset := Vector2.ZERO  # 相對於 EyeWindowOD 的位移
var target_angles = [-240, -5, -108]
var current_index = 0

func _ready():
	# 自動取得偏移
	if eye_window_od:
		offset = global_position - eye_window_od.global_position
	else:
		print("⚠️ 找不到 EyeWindowOD")
	
	hint.visible = false
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta):
	# 每幀更新位置，讓按鈕跟著 EyeWindowOD 移動
	if eye_window_od:
		global_position = eye_window_od.global_position + offset


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var next_angle = target_angles[current_index]
		current_index = (current_index + 1) % target_angles.size()
		var tween = create_tween()

		# 旋轉 UI 圖片（ExamTurnHintOD）
		tween.tween_property(exam_array_ui_od, "rotation_degrees", next_angle, 0.3)\
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false
