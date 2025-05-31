extends Node2D

# OD（右眼）
@onready var eye_window_od = $UI/EyeWindowOD
@onready var occluder_od = $UI/EyeWindowOD/OccluderOD
@onready var button_od = $UI/EyeWindowOD/ButtonAssistArrayR

# OS（左眼）
@onready var eye_window_os = $UI/EyeWindowOS
@onready var occluder_os = $UI/EyeWindowOS/OccluderOS
@onready var button_os = $UI/EyeWindowOS/ButtonAssistArrayL

func _ready():
	# 圖層深度設定
	eye_window_od.z_index = 2
	occluder_od.z_index = 1
	occluder_od.z_as_relative = false

	eye_window_os.z_index = 2
	occluder_os.z_index = 1
	occluder_os.z_as_relative = false

	# 初始遮眼狀態
	occluder_od.visible = false
	occluder_os.visible = false

	# 連接按鈕按下事件
	button_od.pressed.connect(toggle_occlude_od)
	button_os.pressed.connect(toggle_occlude_os)

func toggle_occlude_od():
	occluder_od.visible = !occluder_od.visible

func toggle_occlude_os():
	occluder_os.visible = !occluder_os.visible
