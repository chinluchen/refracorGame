extends CanvasLayer

@onready var cursor := Sprite2D.new()

var hand := preload("res://assets/images/hand.png")
var hand_click := preload("res://assets/images/handClick.png")
var hotspot := Vector2(-25, -25)  # 可調整為 Vector2(-25, -25) 以對準圖片熱點

var cursor_ready := false  # 防止未初始化就進入 _process

func _ready():
	# 檢查貼圖是否成功載入
	if hand == null or hand_click == null:
		push_error("❌ 游標圖片載入失敗，請檢查路徑")
		return

	cursor.texture = hand
	cursor.z_index = 1999
	add_child(cursor)

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	cursor_ready = true  # 啟用更新

func _process(_delta):
	if not cursor_ready:
		return  # 防止尚未初始化就進入處理

	# 每幀強制隱藏系統游標
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	# 更新自定義游標位置
	cursor.global_position = get_viewport().get_mouse_position() - hotspot

	# 根據滑鼠按下狀態切換圖示
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cursor.texture = hand_click
	else:
		cursor.texture = hand
