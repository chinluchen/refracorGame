extends Node

# ✅ BGM 音樂播放器
@onready var bgm_player := $BGMPlayer

# ✅ 點擊與打字音效播放器
@onready var sfx_click := $ClickPlayer
@onready var sfx_typing := $TypingPlayer

# ✅ 場景名稱對應 BGM 路徑
const BGM_MAP := {
	"intro": "res://assets/sounds/intro.ogg",
	"levelSelect": "res://assets/sounds/intro.ogg",
	"gamecore": "res://assets/sounds/play.ogg",
	"record": "res://assets/sounds/record.ogg"
}

# 🔁 狀態控制用變數
var current_bgm_path := ""
var is_changing_bgm := false
var fade_time := 1.0  # 音樂淡入淡出時間（秒）

func _ready():
	# ✅ 使用 load() 強制載入音效，避免 stream 是 null
	if sfx_click and sfx_click.stream == null:
		sfx_click.stream = load("res://assets/sounds/click.ogg")
	if sfx_typing and sfx_typing.stream == null:
		sfx_typing.stream = load("res://assets/sounds/type.ogg")


# 🎧 播放對應場景的 BGM（含淡入淡出）
func play_bgm_for_scene(scene_name: String):
	if not BGM_MAP.has(scene_name):
		print("⚠️ 無 BGM 設定的場景：", scene_name)
		stop_bgm()
		current_bgm_path = ""
		return

	var new_bgm_path = BGM_MAP[scene_name]

	if current_bgm_path == new_bgm_path and bgm_player.playing:
		return  # 🎯 若音樂相同且正在播放，不做任何事

	if is_changing_bgm:
		return  # 防止同時進行多次切換

	is_changing_bgm = true
	await _fade_out_bgm()

	var stream: AudioStream = load(new_bgm_path)
	if stream:
		stream.loop = true  # ✅ 設定音檔循環播放（Godot 4.x 的正確方式）
		bgm_player.stream = stream
		bgm_player.volume_db = -40  # 從靜音開始淡入
		bgm_player.play()
		current_bgm_path = new_bgm_path
		await _fade_in_bgm()
	else:
		push_error("❌ 找不到音樂檔：" + new_bgm_path)

	is_changing_bgm = false

# 🛑 停止 BGM
func stop_bgm():
	if bgm_player:
		bgm_player.stop()
	current_bgm_path = ""

# 🔈 音樂淡出（從 0 到 -40 dB）
func _fade_out_bgm():
	var duration := fade_time
	var t := 0.0
	while t < duration:
		var ratio = 1.0 - t / duration
		bgm_player.volume_db = lerp(-40, 0, ratio)
		await get_tree().create_timer(0.05).timeout
		t += 0.05
	bgm_player.stop()

# 🔊 音樂淡入（從 -40 dB 到 0）
func _fade_in_bgm():
	var duration := fade_time
	var t := 0.0
	while t < duration:
		var ratio = t / duration
		bgm_player.volume_db = lerp(-40, 0, ratio)
		await get_tree().create_timer(0.05).timeout
		t += 0.05
	bgm_player.volume_db = 0  # 確保最後回到正常音量

# ✅ 點擊音效
func play_click():
	print("🔊 播放 Click")
	if sfx_click:
		sfx_click.stop()
		sfx_click.play()
	else:
		print("❌ sfx_click is null")

# ✅ 打字音效
func play_typing():
	print("🔊 播放 Typing")
	if sfx_typing:
		sfx_typing.play()
	else:
		print("❌ sfx_typing is null")


func stop_typing():
	if sfx_typing:
		sfx_typing.stop()
