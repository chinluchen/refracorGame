extends Node

var hand = load("res://assets/images/hand.png")
var handClick = load("res://assets/images/handClick.png")
var hotspot = Vector2(53, 40)

func _ready():
	Input.set_custom_mouse_cursor(hand, Input.CURSOR_ARROW, hotspot)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			print("🖱️ [點擊] 更換為 `handClick.png`")
			Input.set_custom_mouse_cursor(handClick, Input.CURSOR_ARROW, hotspot)
		else:
			print("🖱️ [放開] 更換為 `hand.png`")
			Input.set_custom_mouse_cursor(hand, Input.CURSOR_ARROW, hotspot)
