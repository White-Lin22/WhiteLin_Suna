extends CharacterBody3D

var speed = 5.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var in_conversation = false
@export var interact_label: Label


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
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if in_conversation == false:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			print("dsfg")
			velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = 7
	else:
		speed = 5
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if in_conversation == false:
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
	else:
		velocity.x = 0
		velocity.z = 0
	move_and_slide()
	
	
func in_conversation_rn():
	in_conversation = true
	
func not_in_conversation_rn():
	in_conversation = false
	
