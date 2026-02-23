extends CanvasLayer

signal change_scene

func transition() -> void:
	%AnimationPlayer.play("fade")
	get_viewport().gui_disable_input = true
	await %AnimationPlayer.animation_finished
	emit_signal("change_scene")
	%AnimationPlayer.play_backwards("fade")
	get_viewport().gui_disable_input = false
