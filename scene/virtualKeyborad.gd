extends ScrollContainer

var old_size
const TOAST = preload("res://scene/popup/toast.tscn")
@onready var workout_day: Control = $".."

func _ready() -> void:
	old_size = workout_day.size

func _process(_delta: float) -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
		var keyboard_height = DisplayServer.virtual_keyboard_get_height()
		if keyboard_height > 0 and workout_day.size.y == (old_size.y - keyboard_height):
			var toast = TOAST.instantiate()
			add_child(toast)
			toast.toast(keyboard_height)
			workout_day.size.y = old_size.y - keyboard_height
			
		elif old_size != size :
			workout_day.size.y = old_size
	if Input.is_action_just_pressed("enter"):
		workout_day.size.y = old_size.y - 300
