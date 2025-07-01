extends CharacterBody3D

var speed = 5.5
var start_rotating = false
var rotation_amount = 0.0

var all_points = []
var next_point = 0


@export var player: CharacterBody3D
@export var state_label: Label3D 
@export var hearing_area: Area3D
@export var hearing_label: Label3D
@export var patrol_node: Node3D
@export var hearing_bar_sprite : Sprite3D


@onready var nav_agent = $NavigationAgent3D

func _ready() -> void:	
	for pt in patrol_node.get_children():
		all_points.append(pt.global_position + Vector3(0,1,0))


func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta
	#if start_rotating:
	#	searching(delta)
	#enemy_sight()
	
func _process(delta: float) -> void:
	state_label.look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	state_label.rotate_y(deg_to_rad(180))
	hearing_label.look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	hearing_label.rotate_y(deg_to_rad(180))
	hearing_bar_sprite.look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	hearing_bar_sprite.rotate_y(deg_to_rad(180))
	#state_label.look_at(-player.global_transform.origin)
	#hearing_label.look_at(-player.global_transform.origin)
	#print(player.global_transform.origin)
	#print(-player.global_transform.origin)
#func enemy_sight():
	# if the enemy sees the player
#	if sight_raycast.is_colliding():
#		# gets the collider of the raycast
#		var collider = sight_raycast.get_collider()
#		# if the collider detects the player than it changes into the chase state, if not prints the collider
#		if collider == player:
#			chase()
#			label3d.text = "[chasing]"
		#else:
		#	label3d.text = "[lost player]"
	
#func chase():
	# variables that the enemy needs to interact with the navigtion region
#	var next_location = nav_agent.get_next_path_position()
#	var current_location = global_transform.origin
#	var new_velocity = (next_location - current_location).normalized() * speed
	
	# set the velocity towards the player
#	velocity = velocity.move_toward(new_velocity, 0.25)
	# looks at the player
#	look_at(player.global_transform.origin, Vector3.UP)
	
#	move_and_slide()
	
#func target_position(collider):
	# sets the target for the enemy to be the player(collider)
#	nav_agent.target_position = collider
	
	
#func searching(delta):
	# speed in terms of degrees
#	var rotation_speed = 180
	# counts the amount of rotation for restricting the amount of spins

	# spins enemy twice
#	if rotation_amount < 720:
#		label3d.text = "[searching]"
#		var step = rotation_speed*delta
#		rotate_y(deg_to_rad(step))
#		rotation_amount += step
#		print(rotation_amount)
#	else:
		# resets the both the counter for rotation and the boolean for starting rotations
#		rotation_amount = 0
#		start_rotating = false
	
	
#func start_rotating_func():
#	start_rotating = true
	
# when a player enters the sight area 3d, it will set start rotating to on
#func _on_sight_area_body_entered(body: Node3D) -> void:
#	if body == player:
#		start_rotating_func()
func target_position(target):
	# sets the target for the enemy to be the player(collider)
	nav_agent.target_position = target
