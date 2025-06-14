extends Node2D

@onready var all_array = $allArray

# 所有方向的 pressed 圖片
@onready var arrow_pressed := {
	"up": $upArrowPressed,
	"down": $downArrowPressed,
	"left": $leftArrowPressed,
	"right": $rightArrowPressed
}

# 所有方向的 hint 圖片
@onready var arrow_hint := {
	"up": $upArrowArea/upArrowHint,
	"down": $downArrowArea/downArrowHint,
	"left": $leftArrowArea/leftArrowHint,
	"right": $rightArrowArea/rightArrowHint
}

# 所有方向的 Area2D 節點（用來連接事件）
@onready var arrow_area := {
	"up": $upArrowArea,
	"down": $downArrowArea,
	"left": $leftArrowArea,
	"right": $rightArrowArea
}


func _ready():
	_reset_state()

	for dir in arrow_area:
		arrow_area[dir].connect("mouse_entered", Callable(self, "_on_hover_enter").bind(dir))
		arrow_area[dir].connect("mouse_exited", Callable(self, "_on_hover_exit").bind(dir))
		arrow_area[dir].connect("input_event", Callable(self, "_on_pressed").bind(dir))


func _on_hover_enter(dir: String):
	arrow_hint[dir].visible = true

func _on_hover_exit(dir: String):
	arrow_hint[dir].visible = false

func _on_pressed(viewport, event, shape_idx, dir: String):
	if event is InputEventMouseButton and event.pressed:
		AudioRoot.play_click()  # 🔉 播放音效
		show_only_pressed(dir)
		await get_tree().create_timer(0.5).timeout
		_reset_state()


func show_only_pressed(dir: String):
	all_array.visible = false
	for d in arrow_pressed:
		arrow_pressed[d].visible = (d == dir)
		arrow_hint[d].visible = false


func _reset_state():
	all_array.visible = true
	for d in arrow_pressed:
		arrow_pressed[d].visible = false
		arrow_hint[d].visible = false
