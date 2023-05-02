extends Node2D

signal world_change(world_name)
var entered = false

export(String) var world_name = 'world'

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("e_interact"):
			emit_signal("world_changed", world_name)
			print("entered")


func _on_Area2D_body_entered(body: PhysicsBody2D):
	entered = true
	print("IN")
func _on_Area2D_body_exited(body):
	entered = false
