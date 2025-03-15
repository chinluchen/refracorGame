extends Node2D

# 定義兩個游標圖片的資源變數
@export var cursor_default: Texture
@export var cursor_click: Texture

# 定義信號，用於通知點擊事件
signal mouse_clicked(click_position)

# 設定滑鼠游標為自訂圖片
func _ready():
	if cursor_default:
		Input.set_custom_mouse_cursor(cursor_default)

# 監聽滑鼠事件，實現游標切換和發送信號
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			# 點擊時切換到點擊游標
			if cursor_click:
				Input.set_custom_mouse_cursor(cursor_click)

			# 發送信號，通知其他邏輯
			emit_signal("mouse_clicked", event.position)

		else:
			# 釋放時恢復到默認游標
			if cursor_default:
				Input.set_custom_mouse_cursor(cursor_default)








## 設定移動距離和速度
#@export var move_distance = 100
#@export var move_duration = 0.5  # 設定移動的時間
#
## 取得按鈕、圖片和 Tween 的參考
#@onready var adjust_part_button = $AdjustPart
#@onready var image_to_move = $TextureRect
#@onready var tween = $Tween
#
## 記錄圖片的初始位置
#var original_position
	#
#func _pupilDistanceMove():
	## 紀錄圖片的初始位置
	#original_position = image_to_move.position
		## 連接按鈕的按下信號，使用 Callable
	#adjust_part_button.connect("pressed", Callable(self, "_on_adjust_part_button_pressed"))
#
#func _on_adjust_part_button_pressed():
	## 計算目標位置
	#var target_position_left = original_position + Vector2(-move_distance, 0)
	#var target_position_right = original_position + Vector2(move_distance, 0)
#
	## 使用 Tween 動畫來平滑移動圖片
	#tween.tween_property(image_to_move, "position", target_position_left, move_duration)
	#await tween.finished  # 等待 Tween 完成
	#
	#tween.tween_property(image_to_move, "position", target_position_right, move_duration)
	#await tween.finished  # 等待 Tween 完成
	#
	## 最後移動回原始位置
	#tween.tween_property(image_to_move, "position", original_position, move_duration)
	#await tween.finished  # 等待 Tween 完成
