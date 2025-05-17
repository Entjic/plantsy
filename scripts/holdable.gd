extends Node2D
class_name Holdable

var item_type: String = ""

var carried_layer := 0
var carried_mask := 0
var carried_z_index := 0
var parent_node : Node = null

func _init(_type: String = ""):
	item_type = _type

func pick_up(player: Node):
		# Save original collision settings
	self.carried_layer = self.collision_layer
	self.carried_mask = self.collision_mask
	self.carried_z_index = self.z_index  # Save original z-index

	# Re-parent to player
	parent_node = self.get_parent()
	parent_node.remove_child(self)
	var anchor := player.get_node("HoldableAnchor")
	
	anchor.add_child(self)
	self.position = Vector2.ZERO  # It will inherit anchor's offset
	
	self.z_index = 1
	# Disable collision and physics while carried
	self.set_physics_process(false)
	self.collision_layer = 0
	self.collision_mask = 0

func drop(player: Node, facing_direction: Vector2):
	print("Trying to drop node " + self.name)
	var anchor := player.get_node("HoldableAnchor")
	anchor.remove_child(self)
	parent_node.add_child(self)

	# 🧭 Drop it in the direction you're facing
	var drop_offset := facing_direction.normalized() * 20
	self.global_position = player.global_position + drop_offset
	self.z_index = self.carried_z_index  # Restore previous z

	# Restore original collision and physics
	self.set_physics_process(true)
	self.collision_layer = self.carried_layer
	self.collision_mask = self.carried_mask

func use(_node: Node, facing_direction: Vector2) -> void:
	pass
