extends Node

const TOAST = preload("res://scene/popup/toast.tscn")
const PATH = "user://data.json"
var json = JSON.new()

func _save(data) -> void:
	var file = FileAccess.open(PATH, FileAccess.WRITE_READ)
	file.store_string(json.stringify(data))
	file.close()
	file = null


func _load(id=null,path:String= PATH) ->Dictionary:
	var file = FileAccess.open(path,FileAccess.READ)
	if file != null:
		var data = json.parse_string(file.get_as_text())
		file.close()
		if id == null:
			return data
		return data["workoutPlan"][str(id)]
	file.close()
	return {}

func new_save():
	var data = {
		 "workoutPlan": {
		"1": {
		  "workouts": []
		},
		"2": {
		  "workouts": []
		},
		"3": {
		  "workouts": []
		},
		"4": {
		  "workouts": []
		},
		"5": {
		  "workouts": []
		},
		"6": {
		  "workouts": []
		},
		"7": {
		  "workouts": []
		}
	  }
	}

	_save(data)

func _update(id:int,new_workout:Array):
	var data = _load()
	var id_str = str(id)
	var toast = TOAST.instantiate()
	if id_str in data['workoutPlan']:
		data["workoutPlan"][id_str]["workouts"] = new_workout
		_save(data)
		
		add_child(toast)
		toast.toast("SAVED SUCCESSFULLY")
		
	else :
		add_child(toast)
		toast.toast("SAVE FAILED")
	toast = null

func _ready() -> void:
	if ! FileAccess.file_exists(PATH):
		new_save()
