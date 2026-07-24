extends Node2D

func _ready():

	SceneManager.register_player($Player)

	SceneManager.change_map("Town", "TownEntrance")
