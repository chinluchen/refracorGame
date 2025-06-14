extends Area2D

@onready var axis_ui := $AstigAxisUIOD
@onready var axis_hint := $AstigAxisHintOD

var rotating := false
var center := Vector2.ZERO
var initial_mouse_angle := 0.0
var initial_angle := 0.0
var max_rotation_speed := 0.3  # 度/幀

func _ready():
	axis_hint.visible = false
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

func _on_mouse_entered():
	axis_hint.visible = true

func _on_mouse_exited():
	axis_hint.visible = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not rotating:
			# 開啟旋轉
			rotating = true
			center = axis_ui.global_position
			initial_angle = axis_ui.rotation
			initial_mouse_angle = (get_global_mouse_position() - center).angle()
			print("🌀 開始旋轉")
		else:
			# 關閉旋轉（僅限在碰撞區內）
			rotating = false
			print("🛑 停止旋轉")

func _process(_delta):
	if rotating:
		var mouse_angle = (get_global_mouse_position() - center).angle()
		var angle_delta = mouse_angle - initial_mouse_angle
		var target_rotation = initial_angle + angle_delta

		# 限制轉動速度
		var angle_diff = wrapf(target_rotation - axis_ui.rotation, -PI, PI)
		var limited_diff = clamp(angle_diff, -deg_to_rad(max_rotation_speed), deg_to_rad(max_rotation_speed))
		axis_ui.rotation += limited_diff
		axis_hint.rotation = axis_ui.rotation
