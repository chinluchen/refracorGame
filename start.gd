extends Node2D

@onready var video_player = $VideoStreamPlayer

func _ready():
	video_player.play()  # 自動播放影片
	video_player.finished.connect(_on_video_finished)  # 影片結束後切換場景

func _on_video_finished():
	get_tree().change_scene_to_file("res://intro.tscn")  # 影片結束後進入 `intro`
