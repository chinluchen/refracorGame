extends Node

# 加載滑鼠指標圖片
var hand = load("res://assets/images/hand.png")
var handClick = load("res://assets/images/handClick.png")
# 設定滑鼠熱點 (假設圖片大小為 32x32，將熱點設為中心)
var hotspot = Vector2(53, 40)

func _ready():
	# 設定初始滑鼠指標
	Input.set_custom_mouse_cursor(hand, Input.CURSOR_ARROW, hotspot)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			print("🖱️ [點擊] 更換為 `handClick.png`")
			Input.set_custom_mouse_cursor(handClick, Input.CURSOR_POINTING_HAND)
		else:
			print("🖱️ [放開] 更換為 `hand.png`")
			Input.set_custom_mouse_cursor(hand, Input.CURSOR_ARROW)
