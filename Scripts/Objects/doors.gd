extends Interactable

@export var target_map : String
@export var target_spawn : String

func _ready():
	add_to_group("doors")
	
func interact() -> void:
	SceneManager.change_map(target_map, target_spawn)
