extends Control

const REP = preload("res://scene/serie/rep.tscn")

@onready var name_serie: LineEdit = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/name
@onready var nbr_serie: LineEdit = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/nbrSerie
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var v_box_container: VBoxContainer = $MarginContainer/CenterContainer/VBoxContainer
@onready var rep_container: VBoxContainer = $MarginContainer/CenterContainer/VBoxContainer/rep_container

var time = 0
var is_mouse_in:bool = false

func _ready() -> void:
	custom_minimum_size = v_box_container.size

func _process(delta: float) -> void:
	if time > 1.5:
		_delet_self()
	if Input.is_action_pressed("touch") and is_mouse_in:
		
		time += delta
		if time > .5:
			texture_progress_bar.visible = true
			texture_progress_bar.value = (time-.5) * 100
			print(time)
	else :
		time = 0
		texture_progress_bar.visible = false
		texture_progress_bar.value = 0



func get_info() -> Dictionary:
	var dic = {
		"seriesName": "",
		"repetitions": [],
		"poids":[]
		}
	dic.seriesName = name_serie.text
	for HBox in rep_container.get_children():
		dic.repetitions.append(HBox.get_node("rep").text)
		dic.poids.append(HBox.get_node("poids").text)
	return dic

func _delet_self():
	get_tree().queue_delete(self)

func set_name_nbrSerie(text_name:String,text_nbrS:String):
	name_serie.text = text_name
	if text_nbrS == "0":
		nbr_serie.text = ""
	else:
		nbr_serie.text = text_nbrS

func _on_nbr_serie_text_changed(new_text: String) -> void:
	if  !new_text.is_valid_int():
		nbr_serie.text = ""
	elif !new_text.is_empty():
		var nbr_ser = int(new_text)
		if nbr_ser > 0 and nbr_ser <= 10:
			for child in rep_container.get_children():
				rep_container.remove_child(child)
			for i in range(nbr_ser):
				var rep = REP.instantiate()
				rep.get_node("rep").placeholder_text = "rep "+ str(i+1)
				rep_container.add_child(rep)
		else :
			nbr_serie.text = "10"


func _add_rep(nbr_rep:int,reps:Array,poids:Array):
	for child in rep_container.get_children():
		rep_container.remove_child(child)
	for i in range(nbr_rep):
		var HBox = REP.instantiate()
		HBox.get_node("rep").text = reps[i]
		HBox.get_node("poids").text = poids[i]
		rep_container.add_child(HBox)

func _on_v_box_container_resized() -> void:
	if v_box_container != null:
		custom_minimum_size = v_box_container.size



func _on_mouse_entered() -> void:
	is_mouse_in = true


func _on_mouse_exited() -> void:
	is_mouse_in = false
