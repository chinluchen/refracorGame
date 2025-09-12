extends Area2D

@export var is_plus: bool = true  # true 為加，false 為減
@export var delta: float = 0.25   # 每次調整的度數
@export var hint_path: NodePath   # 提示圖片的路徑，由編輯器指定

@onready var hint: Sprite2D = get_node(hint_path)

func _ready():
	if hint:
		hint.visible = false
		hint.z_index = 10
		hint.z_as_relative = false

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

func _on_mouse_entered():
	if hint:
		hint.visible = true

func _on_mouse_exited():
	if hint:
		hint.visible = false

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var change = delta if is_plus else -delta
		RefractorState.sphere_od += change

		var value = RefractorState.sphere_od
		var abs_value = abs(value)

		var ui = get_tree().get_root().find_child("UI", true, false)
		if ui:
			var label = ui.find_child("SpherePowerOD", true, false)
			if label:
				label.text = "%.2f D" % abs_value
				label.modulate = (
					Color.BLUE if value == 0.0 else
					Color.BLACK if value > 0.0 else
					Color.RED
				)
