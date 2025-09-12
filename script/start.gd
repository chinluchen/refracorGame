extends Node2D

@onready var video_player = $VideoStreamPlayer  # 取得影片播放器

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)  # 隱藏滑鼠
	video_player.play()  # 播放影片
	video_player.finished.connect(_on_video_finished)  # 影片結束時觸發事件

func _on_video_finished():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)  # 顯示滑鼠
	get_tree().change_scene_to_file("res://scenes/intro.tscn")  # 跳轉到 `intro.tscn`
