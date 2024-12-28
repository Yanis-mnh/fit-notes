extends CusttomButton

@onready var v_box_container: VBoxContainer = $"../../../MarginContainer/ScrollContainer/VBoxContainer"


const SERIE = preload("res://scene/serie/serie.tscn")
func _on_pressed() -> void:
	var serie = SERIE.instantiate()
	v_box_container.add_child(serie)
	$"../../../MarginContainer/CenterContainer".visible = false
