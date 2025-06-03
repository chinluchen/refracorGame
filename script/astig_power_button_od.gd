# File: astig_power_button_od.gd
extends Area2D

@onready var hint := $AstigPowerHintOD
@onready var dialog := $AcceptDialog

func _ready():
	hint.visible = false
	var ok_button = $AcceptDialog.get_ok_button()
	ok_button.custom_minimum_size = Vector2(400, 200)  # ✅ 調整為你想要的尺寸

	# 連接滑鼠進入與離開事件
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	# 連接點擊事件
	input_event.connect(_on_input_event)
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		dialog.popup_centered()
		await get_tree().process_frame  # 等待一幀，確保按鈕被建立

		var ok_button = dialog.get_ok_button()
		
		# ✅ 強制修改大小
		ok_button.custom_minimum_size = Vector2(400, 200)

		# ✅ 調整文字大小（可選）
		ok_button.add_theme_font_size_override("font_size", 32)

		# ✅ 移除內部 padding（確保點擊區域佔滿）
		var style = ok_button.get_theme_stylebox("normal")
		if style:
			style.content_margin_left = 50
			style.content_margin_top = 20
			style.content_margin_right = 50
			style.content_margin_bottom = 20

 

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false
