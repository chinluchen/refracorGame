extends Area2D

signal button_clicked(button_name)

@onready var normal_sprite := $ButtonArea/Button
@onready var pressed_sprite := $ButtonArea/ButtonPressed
@onready var hint_sprite := $ButtonArea/ButtonHint

var is_selected := false

func _ready():
	normal_sprite.visible = true
	pressed_sprite.visible = false
	hint_sprite.visible = false
	connect("input_event", _on_input_event)
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("DEBUG: Button pressed:", name)
		ActionLogger.log_action("按下 " + name, "button")
		emit_signal("button_clicked", name)

func _on_mouse_entered():
	if not is_selected:
		hint_sprite.visible = true

func _on_mouse_exited():
	hint_sprite.visible = false

func set_selected(selected: bool):
	is_selected = selected
	pressed_sprite.visible = selected
	normal_sprite.visible = not selected
	hint_sprite.visible = false
