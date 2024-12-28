extends Control

const SERIE = preload("res://scene/serie/serie.tscn")

@onready var v_box_container: VBoxContainer = $MarginContainer/ScrollContainer/VBoxContainer

var id

var workouts = {
	  "workouts": [
		{
		"seriesName": "",
		"repetitions": [],
		"poids":[]
		}
	  ]
	}

func _ready() -> void:
	print(OS.get_data_dir())
	id = SceanTransi.get_id()
	var workout = SaveManager._load(id).workouts
	print(workout)
	if workout.is_empty():
		$MarginContainer/CenterContainer.visible = true
	for i in workout:
		var serie = SERIE.instantiate()
		var name_serie = str(i.seriesName)
		var nbrS = str(len(i.repetitions))
		v_box_container.add_child(serie)
		serie.set_name_nbrSerie(name_serie,nbrS) 
		serie._add_rep(int(nbrS),i.repetitions,i.poids)
		serie =null
		nbrS = null
		name_serie = null


func _on_save_pressed() -> void:
	var new_workout = []
	for child in v_box_container.get_children():
		new_workout.append(child.get_info())
	SaveManager._update(id,new_workout)


func _on_delet_all_pressed() -> void:
	for child in v_box_container.get_children():
		v_box_container.remove_child(child)
		await get_tree().create_timer(.01).timeout
	$MarginContainer/CenterContainer.visible = true
