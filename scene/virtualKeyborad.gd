extends ScrollContainer

var old_size
const TOAST = preload("res://scene/popup/toast.tscn")
@onready var workout_day: Control = $".."

func _ready() -> void:
	old_size = workout_day.size

####TODO: do a scroll out so we can make the screen big again

func _up_container():
	#get_parent().size.y = old_size.y - 500
	pass
func _down_container():
	get_parent().size.y = old_size.y

func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("enter"):
		#workout_day.size.y = old_size.y - 300
