extends Area2D

@onready var white_ui := get_tree().get_root().find_child("JccWhiteUIOD", true, false)
@onready var red_ui := get_tree().get_root().find_child("JccRedUIOD", true, false)
@onready var white_hint := get_tree().get_root().find_child("JccWhiteHintOD", true, false)
@onready var red_hint := get_tree().get_root().find_child("JccRedHintOD", true, false)

var is_red := true  # 真正的狀態旗標
var is_hovered := false  # 滑鼠是否停留

func _ready():
	# 初始只顯示白色
	white_ui.visible = true
	red_ui.visible = false
	white_hint.visible = false
	red_hint.visible = false

	is_red = red_ui.visible  # 用實際畫面同步狀態

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

func _on_mouse_entered():
	is_hovered = true
	_show_current_hint()

func _on_mouse_exited():
	is_hovered = false
	white_hint.visible = false
	red_hint.visible = false

func _on_input_event(_viewport, event, _shape_idx):
	if is_hovered and event is InputEventMouseButton and event.pressed:
		# 每次點擊根據當前實際 UI 進行反轉
		is_red = red_ui.visible  # 讀取目前畫面
		is_red = !is_red         # 切換狀態

		# 切換 UI 顯示
		white_ui.visible = !is_red
		red_ui.visible = is_red

		# 更新 hint 顯示
		_show_current_hint()

func _show_current_hint():
	white_hint.visible = not is_red and is_hovered
	red_hint.visible = is_red and is_hovered
