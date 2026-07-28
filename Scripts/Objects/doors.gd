extends Interactable

@export var target_map : String
@export var target_spawn : String

func interact() -> void:
	SceneManager.change_map(target_map, target_spawn)
