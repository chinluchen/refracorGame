extends Control  # 確保 intro 是 Control

@onready var start_button = $start
@onready var introduction_button = $introduction

func _ready():
	print("Intro scene loaded!")  # 測試腳本是否有執行
	if start_button:
		start_button.pressed.connect(_on_start_pressed)
	if introduction_button:
		introduction_button.pressed.connect(_on_introduction_pressed)

func _on_start_pressed():
	print("Start button pressed, changing scene...")
	var err = get_tree().change_scene_to_file("res://level_select.tscn")
	if err != OK:
		print("Error changing scene:", err)

func _on_introduction_pressed():
	print("Introduction button pressed")
