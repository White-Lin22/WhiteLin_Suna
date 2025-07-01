extends CharacterBody3D

var speed = 5
var default_speed = 3
var crouch_move_speed = 2
var run_speed = 5
var crouch_speed = 20
var climb_speed = 2.0
var vault_velocity = 5.0

var default_height = 2
var crouch_height = 1.5

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FOV = 75.0
const FOV_CHANGE = 1.5 

var gravity_on = true
var climbing = false
var in_conversation = false
var win_con = false

@export var interact_label: Label
@export var walkingstate: CollisionShape3D
@export var camera : Camera3D
@export var char_col_shape : CollisionShape3D

@onready var wallcheck = $WallCheckRays/wallcheck
@onready var stillonwall = $WallCheckRays/StillOnWall
@onready var loudstate = $Area3D/loudState
@onready var quietstate = $Area3D/quietState


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * -0.04))
		
	if event.is_action_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("testing_button"):
		in_conversation_rn()
	
	if event.is_action_pressed("testing_button2"):
		not_in_conversation_rn()
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and gravity_on:
		velocity += get_gravity() * delta

	# Handle jump.
	#if in_conversation == false:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = run_speed
		loudstate.disabled = false
		quietstate.disabled = true
		walkingstate.disabled = true
		
	elif Input.is_action_pressed("sneak"):
		char_col_shape.shape.height -= crouch_speed * delta
		speed = crouch_move_speed
		loudstate.disabled = true
		quietstate.disabled = false
		walkingstate.disabled = true
		
	else:
		char_col_shape.shape.height += crouch_height * delta
		speed = default_speed
		loudstate.disabled = true
		quietstate.disabled = true
		walkingstate.disabled = false
		
	char_col_shape.shape.height = clamp(char_col_shape.shape.height, crouch_height, default_height)	
	
	if wallcheck.is_colliding():
		if stillonwall.is_colliding():
			if Input.is_action_pressed("climb"):
				velocity.y = JUMP_VELOCITY
				climbing = true
				print("climbing state")
			else:
				climbing = false
		else:
			velocity.y = JUMP_VELOCITY
			print("top of wall")
			climbing = true
	else:
		climbing = false
				
				
	if climbing:
		gravity_on = false
	else: 
		gravity_on = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#if in_conversation == false:
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7)	
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 1.5)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 1.5)	
	#else:
	#	velocity.x = 0
	#	velocity.z = 0
	var velocity_clamped = clamp(velocity.length(), 0.5, 10)
	var target_fov = FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 16.0)
	
	
	
	move_and_slide()

func climbing_wall():
	climbing = true
	
func in_conversation_rn():
	in_conversation = true
	
func not_in_conversation_rn():
	in_conversation = false
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	pass
