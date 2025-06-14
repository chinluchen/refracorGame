extends Node2D

func _ready():
	print_tree_recursive(get_tree().current_scene, 0)

func print_tree_recursive(node: Node, indent: int):
	var prefix = " " + "│  ".repeat(indent) + "├─ "
	print(prefix + node.name + " (" + node.get_class() + ")")
	for child in node.get_children():
		print_tree_recursive(child, indent + 1)
