class_name PlantProperty
extends Node

var min: float = 0.0
var max: float = 100.0
var value: float = 10.0
var optimum: float = 50

func progress(current: float) -> float:
	return current

func tick() -> float:
	value += progress(value)
	value = clamp(value, min, max)
	return value
