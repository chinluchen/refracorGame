extends Node

var logs: Array = []

@onready var log_container: VBoxContainer = null
@onready var log_font: Font = preload("res://fonts/cubic_11.woff2")  # 確保這個檔案已經存在

func _ready():
	log_container = get_tree().get_root().find_child("LogBox", true, false)

func log_action(name: String, category: String = "", extra := {}):
	logs.append({
		"name": name,
		"category": category,
		"extra": extra
	})

	if log_container:
		var label = Label.new()
		label.add_theme_font_override("font", log_font)
		label.add_theme_color_override("font_color", Color.WHITE)
		label.text = "- " + name
		log_container.add_child(label)

func get_all_logs() -> Array:
	return logs

func clear_logs():
	logs.clear()
	if log_container:
		for child in log_container.get_children():
			child.queue_free()
