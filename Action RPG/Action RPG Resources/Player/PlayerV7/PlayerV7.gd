extends KinematicBody2D

const MAX_SPEED = 30
const RUN_SPEED = 1.75
var velocity = Vector2.ZERO
var speedModifier
var horizontalTilt = 0 # skews player movement horizonally
var verticalTilt = 0 # skews player movement vertically


# MOVE STATE
var state = MOVE

enum{
	MOVE,
	ROLL,
	ATTACK
}

# Get a reference to the GlobalScript singleton
onready var global_script = get_node("/root/GlobalScript")


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var caneHitbox = $JointV2/Forearm/Cane

func _ready():
	
	if global_script.validateNewSpawn == true:
		playerSpawn()

	#SWORD HITBOX SCRIPT FOR BAT ENEMIES
	var knockback_vector = Vector2.ZERO	
	
		# Get a reference to the AnimationPlayer node
	var animation_player = get_node("AnimationPlayer")
	
	# Connect the on_animation_finished signal to the _on_animation_finished function
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	
	# Start playing the "Rolldown" animation
	#animation_player.play("Rolldown")
	
	# Set hint to invisible
	$KeyPrompt.visible = false

func playerSpawn():
	# SET PLAYER TO DOOR SPAWN WHEN LOADED.
	print(position)
	position = global_script.newPlayerLocation
	global_script.validateNewSpawn = false
	print(position)

func _physics_process(delta):
	match state:
		MOVE:
			move_state()
		ROLL:
			pass
		ATTACK:
			attack_state()
	hintStatusChange()

func hintStatusChange():
	if global_script.showHint == true:
		$KeyPrompt.visible = true
	if global_script.showHint == false:
		$KeyPrompt.visible = false
		

func move_state():
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("d_right") - Input.get_action_strength("a_left") + horizontalTilt
	input_vector.y = Input.get_action_strength("s_down") - Input.get_action_strength("w_up") + verticalTilt
	input_vector = input_vector.normalized()
	
	if Input.get_action_strength("emphasize") != 0:
		speedModifier = RUN_SPEED
	else:
		speedModifier = 1
		
		
	# VELOCITY
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = input_vector * MAX_SPEED * speedModifier
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("space"):
		state = ATTACK

func attack_state():
	animationPlayer.play("RollDown")


