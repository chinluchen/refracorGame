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
		"rgButtonArea": chart_key = "rg"
		"eChartButtonArea": chart_key = "e"
		"hiveButtonArea": chart_key = "hive"

	print("DEBUG: Chart switched to", chart_key)
	ActionLogger.log_action("切換 chart：" + chart_key, "chart")
	emit_signal("chart_button_clicked", chart_key)
