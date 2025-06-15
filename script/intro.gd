extends Control  # 確保 intro 是 Control

@onready var start_button = $start
@onready var introduction_button = $introduction

func _ready():
	print("Intro scene loaded!")  # 測試腳本是否有執行
	if start_button:
		start_button.pressed.connect(_on_start_pressed)
	if introduction_button:
		introduction_button.pressed.connect(_on_introduction_pressed)
	AudioRoot.play_bgm_for_scene("intro")

func _on_start_pressed():
	SceneManager.temp_log_string = ActionLogger.export_logs_to_string()
	print("Start button pressed, changing scene...")
	AudioRoot.play_click()  # 🔉 播放音效
	var packed = load("res://scenes/level_select.tscn")
	var err = get_tree().change_scene_to_packed(packed)
	if err != OK:
		print("Error changing scene:", err)

func _on_introduction_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	print("Introduction button pressed")
