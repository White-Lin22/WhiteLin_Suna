extends state

class_name idle

var player : CharacterBody3D


@export var search_state : state
@export var state_label : Label3D
var player_got = false
var hearing_status = 0

func on_enter()-> void:
	print("entered idle")
	player = get_tree().get_first_node_in_group("Player")
	state_label.text ="[idle]"
	#print("entered idle state")

func _physics_process(delta: float) -> void:
	while player_got == false:
		player = get_tree().get_first_node_in_group("Player")
		player_got = true
		print("player got: ", player_got)

func physics_update(delta):
	if hearing_status > 3:
		go_to_search_state()

func handle_input(_input: InputEvent)-> void:
	pass 
	
func go_to_search_state():
	next_state = search_state

func _on_sight_area_body_entered(body: Node3D) -> void:
	print(player)
	if body == player:
		print("player entered")
		go_to_search_state()
		
func _on_hearing_area_entered(area: Area3D) -> void:
	hearing_status += 1
	print(hearing_status)
	print(area)
