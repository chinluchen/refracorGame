# targetChart.gd
extends Node2D

signal chart_button_clicked(chart_name: String)  # ✅ 新增訊號

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

	# ✅ 加上這行，通知其他節點哪個圖表要顯示
	match clicked_name:
		"rgButtonArea":
			emit_signal("chart_button_clicked", "rg")
		"eChartButtonArea":
			emit_signal("chart_button_clicked", "e")
		"hiveButtonArea":
			emit_signal("chart_button_clicked", "hive")
