#record.gd
extends Control

@onready var log_box := $LogPanel/ScrollContainer/MarginContainer/LogBox

func _ready():
	clear_log_box()
	display_logs()

func clear_log_box():
	for child in log_box.get_children():
		child.queue_free()

func display_logs():
	for log in ActionLogger.get_all_logs():
		var label = Label.new()
		label.text = "- " + log.name
		log_box.add_child(label)
