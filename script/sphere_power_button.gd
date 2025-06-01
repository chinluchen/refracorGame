extends Area2D

@export var delta: float = 0.25  # 增減值
@export var hint_node_path: NodePath
@onready var hint_sprite: Sprite2D = get_node(hint_node_path)

func _ready():
	hint_sprite.visible = false
	hint_sprite.z_index = 0  # 預設較低
	hint_sprite.z_as_relative = false

	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if is_right_eye:
			RefractorState.sphere_od = clamp(RefractorState.sphere_od + delta, -20.0, 20.0)
			_update_label("SpherePowerOD", RefractorState.sphere_od)
			print("✅ Sphere OD 更新為 ", RefractorState.sphere_od)
		else:
			RefractorState.sphere_os = clamp(RefractorState.sphere_os + delta, -20.0, 20.0)
			_update_label("SpherePowerOS", RefractorState.sphere_os)
			print("✅ Sphere OS 更新為 ", RefractorState.sphere_os)

func _update_label(label_name: String, value: float):
	var label = get_tree().get_root().find_child(label_name, true, false)
	if label:
		label.text = "%.2f D" % abs(value)
		if value == 0.0:
			label.modulate = Color.BLUE
		elif value > 0.0:
			label.modulate = Color.BLACK
		else:
			label.modulate = Color.RED

func _on_mouse_entered():
	hint_sprite.visible = true
	hint_sprite.z_index = 500
	print("🟦 Hover In")

func _on_mouse_exited():
	hint_sprite.visible = false
	hint_sprite.z_index = 0
	print("⬜ Hover Out")

func _process(_delta):
	var eye_window_name = "EyeWindowOD" if is_right_eye else "EyeWindowOS"
	var eye_window = get_tree().get_root().find_child(eye_window_name, true, false)
	if eye_window:
		global_position.x = eye_window.global_position.x
