extends Control




func _on_samdi_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","SAMDI",1)


func _on_dimanche_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","DIMANCHE",2)


func _on_lundi_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","LUNDI",3)


func _on_mardi_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","MARDI",4)


func _on_mercredi_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","MERCREDI",5)


func _on_jeudi_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","JEUDI",6)


func _on_vendredi_pressed() -> void:
	SceanTransi._transition("res://scene/workout_day.tscn","VENDREDI",7)



func day_pressed() -> void:
	pass
