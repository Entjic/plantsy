extends Node2D
class_name Holdable

var item_type: String = ""

var carried_layer := 0
var carried_mask := 0
var carried_z_index := 0

func _init(_type: String = ""):
	item_type = _type
