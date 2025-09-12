extends Node2D

signal chart_button_clicked(chart_name: String)

@onready var buttons := [
	$rgButtonArea,
	$eChartButtonArea,
	$hiveButtonArea,
]

func _ready():
	for btn in buttons:
		btn.connect("button_clicked", _on_button_clicked)

func _on_button_clicked(clicked_name: String):
	for btn in buttons:
		btn.set_selected(btn.name == clicked_name)
	AudioRoot.play_click()

	var chart_key = ""
	match clicked_name:
		"rgButtonArea": chart_key = "紅綠視標。"
		"eChartButtonArea": chart_key = "E視標。"
		"hiveButtonArea": chart_key = "蜂窩狀視標。"

	print("DEBUG: Chart switched to", chart_key)
	ActionLogger.log_action("切換成：" + chart_key, "chart" + "視標。")
	emit_signal("chart_button_clicked", chart_key)
