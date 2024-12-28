extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $ColorRect/Label
var id
func _ready() -> void:
	animation_player.play("RESET")

func _transition(path:String,name:String = "",id:int=1):
	self.id = id
	label.text = name
	animation_player.play("up")
	await get_tree().create_timer(.2).timeout
	get_tree().change_scene_to_file(path)
	await get_tree().create_timer(.3).timeout
	animation_player.play("up_continue")

func get_id():
	return id
