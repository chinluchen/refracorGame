# File: audio_root.gd
extends Node

@onready var sfx_typing := $TypingPlayer # 🔉 這是播放 type.ogg 的節點
@onready var sfx_click := $ClickPlayer  # 🔉 這是播放 click.ogg 的節點
@onready var sfx_machine := $MachineSFX

func play_typing():
	if sfx_typing:
		sfx_typing.play()
		
func stop_play_typing():
	if sfx_typing:
		sfx_typing.stop()

func play_click():
	if sfx_click:
		sfx_click.play()

func play_machine():
	if sfx_machine:
		sfx_machine.play()
