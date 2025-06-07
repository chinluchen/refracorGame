extends Node2D

@onready var all_array := $allArray

var pressed_map := {}
var hint_map := {}

func _ready():
	# 初始化地圖
	pressed_map = {
		"up": $upArrowPressed,
		"down": $downArrowPressed,
		"left": $leftArrowPressed,
		"right": $rightArrowPressed
	}
	hint_map = {
		"up": $upArrowHint,
		"down": $downArrowHint,
		"left": $leftArrowHint,
		"right": $rightArrowHint
	}

	# ✅ 初始化狀態
	for dir in pressed_map.keys():
		if pressed_map[dir]:
			pressed_map[dir].visible = false

		if hint_map[dir]:
			# 滑鼠移入：顯示 hint
			hint_map[dir].mouse_entered.connect(func(): _on_hint_mouse_entered(dir))
			# 滑鼠移出：隱藏 hint
			hint_map[dir].mouse_exited.connect(func(): _on_hint_mouse_exited(dir))
			# 點擊按鈕：顯示 pressed
			hint_map[dir].pressed.connect(func(): _on_arrow_pressed(dir))

func _on_arrow_pressed(dir: String):
	# 隱藏 AllArray
	all_array.visible = false

	# 顯示 pressed 圖片
	for d in pressed_map.keys():
		pressed_map[d].visible = (d == dir)

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false
