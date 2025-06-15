extends TextureButton

var default_scale = Vector2(1, 1)
var hover_scale = Vector2(1.1, 1.1)

func _ready():
	pivot_offset = size / 2  # 讓按鈕的縮放以中心為基準
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", hover_scale, 0.1)

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", default_scale, 0.1)

func _on_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	var packed = load("res://scenes/gameCore.tscn")
	get_tree().change_scene_to_packed(packed)
