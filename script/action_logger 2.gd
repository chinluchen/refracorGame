# action_logger.gd
extends Node

var logs: Array = []

func log_action(name: String, category: String = "", extra := {}):
	logs.append({
		"name": name,
		"category": category,
		"extra": extra
	})

func get_all_logs() -> Array:
	return logs

func clear_logs():
	logs.clear()
