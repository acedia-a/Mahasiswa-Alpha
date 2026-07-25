extends Node2D

func _ready():

	SceneManager.register_player($player)
	SceneManager.change_map("Town", "TownEntrance")
