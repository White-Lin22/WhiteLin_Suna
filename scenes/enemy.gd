extends CharacterBody3D

var speed = 4

@export var player: CharacterBody3D

@onready var sight_raycast: RayCast3D = $Node3D/RayCast3D
@onready var nav_agent = $NavigationAgent3D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	enemy_sight()
	
func enemy_sight():
	if sight_raycast.is_colliding():
		var collider = sight_raycast.get_collider()
		if collider == player:
			chase()
		else:
			print("npc detected")
			print(collider)
	
func chase():
	var next_location = nav_agent.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	look_at(player.global_transform.origin, Vector3.UP)
	
	move_and_slide()
	
func target_position(collider):
	nav_agent.target_position = collider
	
	
