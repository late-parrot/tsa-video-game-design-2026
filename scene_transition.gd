extends CanvasLayer

signal change_scene

func transition() -> void:
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	emit_signal("change_scene")
	%AnimationPlayer.play_backwards("fade")
