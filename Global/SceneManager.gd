extends Node

var current_map: Node2D = null
var player: CharacterBody2D = null

var maps := {
	"Town": "res://Scenes/Maps/Town.tscn",
	"Cafe": "res://Scenes/Maps/Cafe.tscn",
	"Campus": "res://Scenes/Maps/Campus.tscn",
	"Classroom": "res://Scenes/Maps/Classroom.tscn"
}


func register_player(p: CharacterBody2D):
	player = p


func change_map(map_name: String, spawn_name: String):

	if !maps.has(map_name):
		push_error("Map tidak ditemukan: " + map_name)
		return

	var scene := load(maps[map_name]) as PackedScene

	if current_map:
		current_map.queue_free()

	current_map = scene.instantiate()

	var main = get_tree().current_scene

	main.get_node("CurrentMap").add_child(current_map)

	await get_tree().process_frame

	var spawn = current_map.get_node("SpawnPoints/" + spawn_name)

	player.reparent(current_map.get_node("YSort"))

	player.global_position = spawn.global_position
