extends Node2D

@onready var rg_chart = $chartBackground/rgChart
@onready var e_chart = $chartBackground/eChart
@onready var hive_chart = $chartBackground/hiveChart

func _ready():
	# 可選：預設顯示其中一張（或都關閉）
	show_chart("e")

func show_chart(name: String):
	rg_chart.visible = (name == "rg")
	e_chart.visible  = (name == "e")
	hive_chart.visible = (name == "hive")
