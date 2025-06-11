extends CanvasLayer

@onready var cursor = Sprite2D.new()

var hand = preload("res://assets/images/hand.png")
var hand_click = preload("res://assets/images/handClick.png")
var hotspot = Vector2(-25, -25)  # ✅ 確保啟用

func _ready():
	add_child(cursor)
	cursor.texture = hand
	cursor.z_index = 1000  # 確保最上層
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN  # 隱藏系統游標

func _process(_delta):
	var mouse_pos = get_viewport().get_mouse_position()
	cursor.global_position = mouse_pos - hotspot * cursor.scale

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cursor.texture = hand_click
	else:
		cursor.texture = hand

	# 除錯用印出
	# print("滑鼠位置：", mouse_pos, " ➤ 游標位置：", cursor.global_position)
