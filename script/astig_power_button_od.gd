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

func _on_mouse_entered():
	hint.visible = true

func _on_mouse_exited():
	hint.visible = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		dialog.popup_centered()
		get_viewport().set_input_as_handled()  # ✅ 阻止事件繼續傳遞到下層
