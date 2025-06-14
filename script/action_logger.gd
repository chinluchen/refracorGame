extends Node

var logs: Array = []

@onready var log_container: VBoxContainer = null
@onready var log_font: Font = preload("res://fonts/cubic_11.woff2")  # 確保這個檔案已存在

# 💡 為了相容 record.gd，也提供 actions 別名（不然會報錯）
func get_actions() -> Array:
	return logs

func _ready():
	log_container = get_tree().get_root().find_child("LogBox", true, false)

func log_action(name: String, category: String = "", extra := {}):
	logs.append({
		#"time": Time.get_ticks_msec(),
		"action": name,
		"category": category,
		#"data": extra
	})

	# 若目前場景中有 LogBox 就即時新增
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
