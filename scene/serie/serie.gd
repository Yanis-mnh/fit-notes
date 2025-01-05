extends Control

const REP = preload("res://scene/serie/rep.tscn")

@onready var name_serie: LineEdit = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/name
@onready var nbr_serie: LineEdit = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/nbrSerie
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var v_box_container: VBoxContainer = $MarginContainer/CenterContainer/VBoxContainer
@onready var rep_container: VBoxContainer = $MarginContainer/CenterContainer/VBoxContainer/rep_container
@onready var h_box_container: HBoxContainer = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer

var time = 0
var is_mouse_in:bool = false

func _ready() -> void:
	custom_minimum_size = v_box_container.size
	for i in  h_box_container.get_children():
		if i is LineEdit:
			i.connect("focus_entered", _on_lineedit_focus_entered)
			i.connect("focus_exited",_on_lineedit_focus_exited)

func _process(delta: float) -> void:
	if time > texture_progress_bar.max_value + .9:
		_delet_self()
	if Input.is_action_pressed("touch") and is_mouse_in:
		
		time += delta
		if time > 1:
			texture_progress_bar.visible = true
			texture_progress_bar.value = (time-.5) 
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
			var nbr_child = rep_container.get_child_count()
			### ADD MORE REPS WITHOUT REMOVING EXISTING CHILD
			if nbr_ser > rep_container.get_child_count():
				var child_interval = nbr_ser - rep_container.get_child_count()
				for i in range(child_interval):
					var rep = REP.instantiate()
					rep.get_node("rep").placeholder_text = "rep "+ str(i+1)
					rep_container.add_child(rep)
				child_interval = null
			#### REMOVE EXISTING REPS BUT ONLY THE ONE THAT ARE NOT IN THE RANGE
			elif nbr_ser < nbr_child:
				var i = 0
				for child in rep_container.get_children():
					if i < nbr_ser:
						i+=1
						continue
					else :
						rep_container.remove_child(child)
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


func _on_lineedit_focus_entered() :
	pass
	#get_parent().get_parent()._up_container()
	#self.grab_focus()
	#KeyboardManager._show_keyboard()

func _on_lineedit_focus_exited():
	pass
	#get_parent().get_parent()._down_container()
	#KeyboardManager._hide_keyboard()
