extends Area2D

@export var is_right_eye: bool = true	
@export var delta: float = -0.25
@onready var hint := $SphereHintMinusOD
@onready var eye_window_od := get_tree().get_root().find_child("EyeWindowOD", true, false)

var offset := Vector2.ZERO

func _ready():
	# 自動取得偏移
	if eye_window_od:
		offset = global_position - eye_window_od.global_position
	else:
		print("⚠️ 找不到 EyeWindowOD")

	# 預設隱藏 Hover 提示圖
	hint.visible = false

	# 事件連接
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta):
	if eye_window_od:
		global_position = eye_window_od.global_position + offset


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if is_right_eye:
			RefractorState.add_sphere_od(delta)
		else:
			RefractorState.add_sphere_os(delta)

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false
