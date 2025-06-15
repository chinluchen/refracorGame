extends Node

var logs: Array = []

@onready var log_container: VBoxContainer = null
@onready var log_font: Font = preload("res://fonts/cubic_11.woff2")  # 確保這個檔案已存在

func get_actions() -> Array:
	return logs

func _ready():
	log_container = get_tree().get_root().find_child("LogBox", true, false)

func log_action(name: String, category: String = "", extra := {}):
	logs.append({
		"action": name,
		"category": category,
	})

	if log_container:
		var label = Label.new()
		label.add_theme_font_override("font", log_font)
		label.add_theme_color_override("font_color", Color.WHITE)
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		label.text = "- " + name
		log_container.add_child(label)

func clear_logs():
	logs.clear()
	if log_container:
		for child in log_container.get_children():
			child.queue_free()

# ✅ 新增：logs → JSON 字串
func export_logs_to_string() -> String:
	return JSON.stringify(logs)

# ✅ 新增：JSON 字串 → logs
func import_logs_from_string(data: String):
	var result = JSON.parse_string(data)
	if typeof(result) == TYPE_ARRAY:
		logs = result
