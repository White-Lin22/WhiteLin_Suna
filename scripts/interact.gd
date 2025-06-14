extends RayCast3D

#const Balloon = preload("res://dialogue/balloon.tscn")

#@export var dialogue_resource: DialogueResource
#@export var dialogue_start: String = "start"
@export var player = CharacterBody3D
@export var interact_label : Label

var interacting = false
var interact_visible = true

#func _ready() -> void:
#	DialogueManager.connect("dialogue_ended", Callable(self, "connected_signal"))

func _process(delta: float) -> void:
	# if the player is looking at something interactable and is in range
	if is_colliding() and interacting == false:
		if interact_visible:
			interact_label.visible = true
		else:
			interact_label.visible = false
		if Input.is_action_just_pressed("interact") and interacting == false:
			player.in_conversation_rn()
			interact_visible = false
			var actionables = self.get_collider()
			actionables.action()
			interacting = true
			interact_label.visible = false
			print('drtgh')
			print(interacting)
		else: 
			pass
	else:
		interact_label.visible = false
		
#func connected_signal(dialogue):
#	interact_visible = true
#	print(dialogue)
#	print("it worked")
#	player.not_in_conversation_rn()
#	interacting = false
