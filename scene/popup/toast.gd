extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func toast(text:String):
	$Label.text = text
	animation_player.play("show")
	await get_tree().create_timer(1).timeout
	animation_player.play("fade_out")
	await get_tree().create_timer(.4).timeout
	get_tree().queue_delete(self)
