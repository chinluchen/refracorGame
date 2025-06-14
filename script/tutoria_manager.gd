extends Node

@onready var label := $TutorialBox/TextLabel
@onready var next_button := $TutorialBox/NextButton
@onready var background := $TutorialBox/Background
@onready var type_timer := $TypeTimer
@onready var tutorial_box := $TutorialBox

var steps = [
	{
		"text": "歡迎來到煞氣誒驗光模擬程式，接下來先快速介紹各個操作元件的功能。"
	},
	{
		"hints": ["PDHint"],
		"text": "這是調整瞳孔距離(PD)的旋鈕，試著點擊看看吧。"
	},
	{
		"hints": ["SphereHintPlusOD", "SphereHintPlusOS"],
		"text": "這是用來控制球面度數的正鏡片。"
	},
	{
		"hints": ["SphereHintMinusOD", "SphereHintMinusOS"],
		"text": "這是用來控制球面度數的負鏡片。"
	},
	{
		"hints": ["OccluderHintOD", "OccluderHintOS"],
		"text": "單眼檢查的時候要記得遮蓋喔～"
	},
	{
		"hints": ["ExamTurnHintOD", "ExamTurnHintOS"],
		"text": "如果需要用到稜鏡，就按這個鈕。"
	},
	{
		"hints": ["ButtonHint"],
		"text": "按下不同的按鈕選擇你要的視標。"
	},
	{
		"hints": ["upArrowHint", "downArrowHint"],
		"text": "上下方向鍵控制E視標的大小。"
	},
	{
		"hints": ["rightArrowHint", "leftArrowHint"],
		"text": "左右鍵能夠隨機出現方向！"
	},
	{
		"text": "恭喜你完成了教學關卡！練習完畢之後就開始幫患者驗光吧！"
	}
]

var current_step := 0
var current_hint: Array = []
var full_text := ""
var typed_text := ""
var char_index := 0

func _ready():
	type_timer.timeout.connect(_on_type_timer_timeout)
	next_button.pressed.connect(_on_next_pressed)
	tutorial_box.visible = false  # 預設隱藏
	next_button.disabled = true

func start_tutorial():
	current_step = 0
	tutorial_box.visible = true
	show_step(current_step)

func show_step(step_index):
	for hint in current_hint:
		hint.visible = false
	current_hint.clear()

	if step_index >= steps.size():
		end_tutorial()
		return

	var step = steps[step_index]
	full_text = step["text"]
	typed_text = ""
	char_index = 0
	label.text = ""
	next_button.disabled = true

	# 顯示提示
	if step.has("hints"):
		for hint_name in step["hints"]:
			var hint_nodes = get_tree().get_root().find_children(hint_name, "", true, false)
			for hint_node in hint_nodes:
				hint_node.visible = true
				current_hint.append(hint_node)

	AudioRoot.play_typing()  # ✅ 開始播放連續打字音效
	type_timer.start()

func _on_type_timer_timeout():
	if char_index < full_text.length():
		typed_text += full_text[char_index]
		label.text = typed_text
		char_index += 1
		type_timer.start()  # 繼續下一個字
	else:
		AudioRoot.stop_play_typing()  # ✅ 開始播放連續打字音效
		next_button.disabled = false

func _on_next_pressed():
	AudioRoot.play_click()  # 🔉 播放音效
	current_step += 1
	show_step(current_step)

func end_tutorial():
	for hint in current_hint:
		hint.visible = false
	current_hint.clear()
	tutorial_box.visible = false
