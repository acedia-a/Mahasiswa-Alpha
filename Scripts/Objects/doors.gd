extends Area2D

@export var target_map : String
@export var target_spawn : String
@export var prompt := "Tekan E"

var player_inside = false

func _ready():
	body_entered.connect(_entered)
	body_exited.connect(_exited)

func _entered(body):
	if body.is_in_group("player"):
		player_inside = true
		body.current_door = self
		get_tree().call_group("hud", "show_prompt", prompt)

func _exited(body):
	if body.is_in_group("player"):
		player_inside = false
		body.current_door = null
		get_tree().call_group("hud", "hide_prompt")
