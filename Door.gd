extends Node2D

onready var animatedSprite = $AnimatedSprite

var entered = false

# Get a reference to the GlobalScript singleton

onready var global_script = get_node("/root/GlobalScript")

onready var openDoorBoolean = false

export var newRoomDirectory = ""

export var newPlayerSpawnLocation = Vector2.ZERO


func _ready():
	
	animatedSprite.frame = 0
	


func checkIfDoorValid():
	if newPlayerSpawnLocation != Vector2.ZERO:
		global_script.newPlayerLocation = newPlayerSpawnLocation
		global_script.validateNewSpawn = true

func openDoor():
	animatedSprite.frame = 0
	animatedSprite.play()

func closeDoor():
	animatedSprite.frame = 0
	openDoorBoolean = false
	pass

func _on_AnimatedSprite_animation_finished():
	animatedSprite.stop()
	animatedSprite.frame = 3
	openDoorBoolean = true

func _on_Area2D_body_entered(body: PhysicsBody2D):
	entered = true
	# Show hint
	global_script.showHint = true
	print("BODY IS ENTERED, SETTING LOCAL NEW SPAWN LOCATION AS GLOBAL")
	


func _on_Area2D_body_exited(body):
	entered = false
	# Hide Hint
	global_script.showHint = false


func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("e_interact"):
			openDoor()
			
			checkIfDoorValid()
			
			yield(get_tree().create_timer(.7), "timeout")
			get_tree().change_scene(newRoomDirectory)

# maybe to counteract the akward movement after the door opening, have a seperate collision area for unlocking
# the door and one for going to the next scene.

#ALSO, I need to set the player position upon entering a new room.

# CREATE ANOTHER EXPORT VAR FOR POSITION OF PLAYER IN NEXT ROOM.







#INSTEAD OF ALL THIS GOOFY NONSENSE, 
# USE A REAL ANIMATION PLAYER
# IF ON FRAME 3, PRODUCE A TELEPORTER
# IF ON 0-2 DO REMOVE TELEPORTER
# THE PLAYER WILL BE ABLE TO OPEN AND CLOSE THE DOOR
# EVERY TIME THE PLAYER HITS E IN THE RADIUS
# IT PLAYS AND REVERSES THE ANIMATION.
# THE DOOR CAN ONLY STOP ON FRAMES 0, or 3.

