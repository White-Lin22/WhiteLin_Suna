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
@export var footsteps_audio : AudioStreamPlayer3D


@onready var nav_agent = $NavigationAgent3D
	
# adds all the points that a patrol will go to into a list for iterating later
func _ready() -> void:	
	for pt in patrol_node.get_children():
		all_points.append(pt.global_position + Vector3(0,1,0))


func _physics_process(delta: float) -> void:	
	# apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta


# sets the various UI to look at the player with the first 2 being debug
func _process(delta: float) -> void:
	state_label.look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	state_label.rotate_y(deg_to_rad(180))
	hearing_label.look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	hearing_label.rotate_y(deg_to_rad(180))
	hearing_bar_sprite.look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y ,player.global_transform.origin.z),Vector3(0,1,0))
	hearing_bar_sprite.rotate_y(deg_to_rad(180))

func target_position(target):
	# sets the target for the enemy to be the player(collider)
	nav_agent.target_position = target
