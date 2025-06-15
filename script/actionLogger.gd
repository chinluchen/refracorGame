#actionLogger.gd
extends Node

var logs: Array = []

func get_actions() -> Array:
	return logs

func log_action(name: String, category: String = "", extra := {}):
	var entry = {
		"action": name,
		"category": category,
	}
	logs.append(entry)
	print("📝 新 log：", name, "目前 logs 數量：", logs.size())

func clear_logs():
	logs.clear()

func export_logs_to_string() -> String:
	return JSON.stringify(logs)

func import_logs_from_string(data: String):
	var result = JSON.parse_string(data)
	if typeof(result) == TYPE_ARRAY:
		logs = result
