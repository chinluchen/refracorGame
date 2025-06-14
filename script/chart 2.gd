extends Node2D

@onready var rg_chart = $chartBackground/rgChart
@onready var e_chart = $chartBackground/eChart
@onready var hive_chart = $chartBackground/hiveChart

func _ready():
	# 可選：預設顯示其中一張（或都關閉）
	show_chart("E視標。")

func show_chart(name: String):
	rg_chart.visible = (name == "紅綠視標。")
	e_chart.visible  = (name == "E視標。")
	hive_chart.visible = (name == "蜂窩狀視標。")
