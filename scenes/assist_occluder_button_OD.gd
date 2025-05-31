extends Area2D

@export_node_path("Node") var occluder_od_node  # 拖進 UI/OccluderOD

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_instance_valid(occluder_od_node):
				occluder_od_node.visible = !occluder_od_node.visible
	print("🧪 有收到點擊事件")
