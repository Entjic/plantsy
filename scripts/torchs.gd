extends Node2D

func _ready() -> void:
	for torch: PointLight2D in get_children():
		start_flicker(torch)

func start_flicker(torch: PointLight2D) -> void:
	var delay = randf_range(0.0, 0.5)
	await get_tree().create_timer(delay).timeout
	flicker(torch)

func flicker(torch: PointLight2D) -> void:
	var energy_min = 1.0
	var energy_max = 1.7
	
	var target_energy = randf_range(energy_min, energy_max)
	var duration = randf_range(0.05, 0.25)
	var tween = create_tween()
	tween.tween_property(torch, "energy", target_energy, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(Callable(func(): flicker(torch)))
