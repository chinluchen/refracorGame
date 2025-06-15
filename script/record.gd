#record.gd
extends Control

@onready var log_box := $LogPanel/ScrollContainer/MarginContainer/LogBox  # VBoxContainer

func _ready():
	var actions = ActionLogger.get_actions()
	print("📥 進入 record 場景，log 數量：", actions.size())
	update_display(actions)
	AudioRoot.play_bgm_for_scene("record")

func update_display(actions):
	_clear_log_box()

	for entry in actions:
		var log_label = Label.new()
		log_label.text = entry["action"]  # ✅ 僅顯示內容文字

		log_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		log_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		log_label.custom_minimum_size = Vector2(600, 0)
		log_label.add_theme_constant_override("line_spacing", 4)
		# 如有字體資源，這行可以打開
		# log_label.add_theme_font_override("font", preload("res://fonts/cubic_11.tres"))
		log_label.add_theme_font_size_override("font_size", 16)

		log_box.add_child(log_label)

func _clear_log_box():
	for child in log_box.get_children():
		child.queue_free()
