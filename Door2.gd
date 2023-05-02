extends Node2D

onready var animatedSprite = $AnimatedSprite
onready var global_script = get_node("/root/GlobalScript")

var entered = false
var openDoorBoolean = false


func _ready():
	entered = false
	animatedSprite.frame = 0

func openDoor():
	animatedSprite.frame = 0
	animatedSprite.play()

func closeDoor():
	animatedSprite.frame = 0
	openDoorBoolean = false
	pass

func _on_AnimatedSprite_animation_finished():
	openDoorBoolean = true
	animatedSprite.stop()
	animatedSprite.frame = 3
	openDoorBoolean = true

func _on_Area2D_body_entered(body: PhysicsBody2D):
	print("ENTERED")
	entered = true
	global_script.showHint = true
	
func _on_Area2D_body_exited(body):
	entered = false
	global_script.showHint = false

func _process(delta):
	if entered == true and openDoorBoolean == false:
		if Input.is_action_just_pressed("e_interact"):
			openDoor()
			yield(get_tree().create_timer(.7), "timeout")
			# set player position upon entering a new room
			#get_node("/root/Player").position = newPlayerSpawnLocation
			
func _physics_process(delta):
	pass
