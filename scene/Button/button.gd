extends TextureButton
class_name CusttomButton

func _ready() -> void:
	pivot_offset = size/2


func _on_button_down() -> void:
	scale = scale * .9


func _on_button_up() -> void:
	scale = Vector2.ONE
