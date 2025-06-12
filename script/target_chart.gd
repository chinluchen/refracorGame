# targetChart.gd
extends Node2D

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
	AudioRoot.play_click()  # 🔉 播放音效
