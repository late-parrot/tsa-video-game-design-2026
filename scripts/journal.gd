extends MarginContainer

func _on_snake_entry_focus_entered() -> void:
	%SnakeDescription.show()
	%BugDescription.hide()

func _on_bug_entry_focus_entered() -> void:
	%SnakeDescription.hide()
	%BugDescription.show()
