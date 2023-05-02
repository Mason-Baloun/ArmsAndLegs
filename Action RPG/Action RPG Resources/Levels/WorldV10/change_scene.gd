extends Node

var next_world
onready var current_world = $world1
onready var anim = $AnimationPlayer
func _ready() -> void:
	current_world.connect("world_changed", self, "handle_world_change")
	
func handle_world_changed(current_world_name: String):
	var next_world_name: String
	
	match current_world_name:
		"world1"
		next_world_name = "world2"
		
