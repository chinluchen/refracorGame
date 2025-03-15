extends Node2D  # ExamArray 的腳本

@onready var sprite = $Sprite  # 子節點 Sprite 的參考

func _ready():
	# 確保正確引用子節點
	if not sprite:
		print("子節點 Sprite 沒有正確引用！")
	else:
		print("子節點 Sprite 已成功引用！")
		# 初始化 Sprite 紋理和位置
		#sprite.texture = preload("res://your_image.png")
		sprite.position = Vector2(0, sprite.texture.get_height() / 2)
