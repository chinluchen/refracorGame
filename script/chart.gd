extends Node2D

@onready var rg_chart = $chartBackground/rgChart
@onready var e_chart = $chartBackground/eChart
@onready var hive_chart = $chartBackground/hiveChart
@onready var snellen_label = $chartBackground/snellen

var levels := [
	"20/400", "20/200", "20/160", "20/125", "20/100",
	"20/80", "20/60", "20/50", "20/40", "20/30",
	"20/25", "20/20", "20/12.5", "20/10",
]

var direction_list := ["right", "left", "up", "down"]

var image_pool := {}
var current_level_index := 0  # ✅ 初始為 20/400（最大）
var current_image_index := 0
var current_direction := "right"

func _ready():
	load_all_images()
	randomize()
	reset_images()

	# ✅ 只在最開始強制顯示「朝右」的圖
	var level = levels[current_level_index]
	for i in image_pool[level].size():
		if image_pool[level][i].direction == "right":
			current_image_index = i
			break

	update_chart(false)  # ⛔ 初始不記錄 Log
	show_chart("E視標。")

func show_chart(name: String):
	rg_chart.visible = (name == "紅綠視標。")
	e_chart.visible  = (name == "E視標。")
	hive_chart.visible = (name == "蜂窩狀視標。")

	snellen_label.visible = (name == "E視標。")

# === 載入所有圖像 ===
func load_all_images():
	for level in levels:
		var images: Array = []
		var folder = level.replace("/", "_").replace(".", "_")
		for dir in direction_list:
			var path = "res://assets/images/e_chart_folder/%s/E_%s.png" % [folder, dir]
			if ResourceLoader.exists(path):
				images.append({
					"texture": load(path),
					"direction": dir
				})
			else:
				print("❌ 找不到圖片：", path)
		image_pool[level] = images
	print("✅ 圖片載入完成，共有等級：", image_pool.keys())

func reset_images():
	var level = levels[current_level_index]
	if image_pool.has(level):
		image_pool[level] = image_pool[level].duplicate()
		image_pool[level].shuffle()
		current_image_index = 0

func update_chart(log := true):
	if not e_chart or not e_chart.visible:
		return

	current_level_index = clamp(current_level_index, 0, levels.size() - 1)
	var level = levels[current_level_index]

	if not image_pool.has(level) or image_pool[level].is_empty():
		print("⚠️ 無圖可顯示：", level)
		return

	if current_image_index >= image_pool[level].size():
		current_image_index = 0

	var data = image_pool[level][current_image_index]
	e_chart.texture = data.texture
	current_direction = data.direction

	var level_scale_ratio = get_scale_ratio_by_level(level)

	var base_scale := Vector2(4.206, 4.325)
	match current_direction:
		"left", "right":
			base_scale = Vector2(4.206, 4.325)
		"up", "down":
			base_scale = Vector2(3.339, 4.306)

	e_chart.scale = base_scale * level_scale_ratio
	snellen_label.text = level

	if log:
		var info = get_current_info()
		var msg = "切換E視標，大小%s，%s。" % [info.level, direction_to_chinese(info.direction)]
		ActionLogger.log_action(msg, "E視標")

func get_scale_ratio_by_level(level: String) -> float:
	var parts = level.split("/")
	if parts.size() != 2:
		return 1.0
	var denominator = float(parts[1])
	return denominator / 400.0

func next_image():
	if not e_chart.visible:
		return

	var level = levels[current_level_index]
	var pool = image_pool[level]
	if pool.size() == 0:
		return

	var new_index := current_image_index
	var max_attempts := 10
	var attempt := 0
	while attempt < max_attempts:
		var candidate = randi() % pool.size()
		if pool[candidate].direction != current_direction:
			new_index = candidate
			break
		attempt += 1

	current_image_index = new_index
	update_chart()

func previous_image():
	if not e_chart.visible:
		return

	var level = levels[current_level_index]
	var pool = image_pool[level]
	if pool.size() == 0:
		return

	var new_index := current_image_index
	var max_attempts := 10
	var attempt := 0
	while attempt < max_attempts:
		var candidate = randi() % pool.size()
		if pool[candidate].direction != current_direction:
			new_index = candidate
			break
		attempt += 1

	current_image_index = new_index
	update_chart()

func increase_level():
	if not e_chart or not e_chart.visible:
		return
	if current_level_index > 0:
		current_level_index -= 1
		reset_images()
		update_chart()
	else:
		print("🔺 已是最大視標")

func decrease_level():
	if not e_chart or not e_chart.visible:
		return
	if current_level_index < levels.size() - 1:
		current_level_index += 1
		reset_images()
		update_chart()
	else:
		print("🔻 已是最小視標")

func get_current_info() -> Dictionary:
	return {
		"level": levels[current_level_index],
		"direction": current_direction,
		"image_index": current_image_index + 1
	}

func direction_to_chinese(dir: String) -> String:
	match dir:
		"up": return "上"
		"down": return "下"
		"left": return "左"
		"right": return "右"
		_: return dir
