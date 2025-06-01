extends Node

var hand = preload("res://assets/images/hand.png")
var handClick = preload("res://assets/images/handClick.png")
var hotspot = Vector2(53, 40)

var is_clicking := false  # 狀態標記

func _ready():
	Input.set_custom_mouse_cursor(hand, Input.CURSOR_ARROW, hotspot)

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not is_clicking:
			Input.set_custom_mouse_cursor(handClick, Input.CURSOR_ARROW, hotspot)
			is_clicking = true
			print("🖱️ [點擊] 更換為 `handClick.png`")
	else:
		if is_clicking:
			Input.set_custom_mouse_cursor(hand, Input.CURSOR_ARROW, hotspot)
			is_clicking = false
			print("🖱️ [放開] 更換為 `hand.png`")
