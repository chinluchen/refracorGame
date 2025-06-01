extends Area2D

@onready var occluder_os := get_tree().get_root().find_child("OccluderOS", true, false)
@onready var eye_window_os := get_tree().get_root().find_child("EyeWindowOS", true, false)
@onready var hint := $OccluderHintOS

var offset := Vector2.ZERO  # 相對於 EyeWindowOS 的位移

func _ready():
	# 初始化：記錄目前與 EyeWindowOS 的相對位置
	if eye_window_os:
		offset = global_position - eye_window_os.global_position

	# 初始化：隱藏遮眼器與提示
	if occluder_os:
		occluder_os.visible = false
	else:
		print("⚠️ 找不到 OccluderOS")

	# 預設隱藏 Hover 提示圖
	hint.visible = false

	# 連接互動事件
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta):
	# 每幀更新位置，讓按鈕跟著 EyeWindowOS 移動
	if eye_window_os:
		global_position = eye_window_os.global_position + offset

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if occluder_os:
			occluder_os.visible = !occluder_os.visible

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false
