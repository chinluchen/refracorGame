extends Area2D

@onready var occluder_od := get_tree().get_root().find_child("OccluderOD", true, false)
@onready var eye_window_od := get_tree().get_root().find_child("EyeWindowOD", true, false)
@onready var hint := $OccluderHintOD

var offset := Vector2.ZERO  # 相對於 EyeWindowOS 的位移

func _ready():
	# 初始化：記錄目前與 EyeWindowOS 的相對位置
	if eye_window_od:
		offset = global_position - eye_window_od.global_position

	# 初始化：隱藏遮眼器與提示
	if occluder_od:
		occluder_od.visible = false
	else:
		print("⚠️ 找不到 OccluderOD")

	# 預設隱藏 Hover 提示圖
	hint.visible = false

	# 連接互動事件
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta):
	# 每幀更新位置，讓按鈕跟著 EyeWindowOS 移動
	if eye_window_od:
		global_position = eye_window_od.global_position + offset

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if occluder_od:
			occluder_od.visible = !occluder_od.visible

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false
