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

	var main = get_tree().current_scene

	# Selamatkan player sebelum map lama dihapus
	if player.get_parent():
		player.reparent(main)

	# Hapus map lama
	if current_map:
		current_map.queue_free()
		await get_tree().process_frame

	# Load map baru
	var scene: PackedScene = load(maps[map_name])
	current_map = scene.instantiate()

	main.get_node("CurrentMap").add_child(current_map)

	await get_tree().process_frame

	# Cari spawn
	var spawn = current_map.get_node("YSort/SpawnPoints/" + spawn_name)

	# Masukkan player ke map baru
	player.reparent(current_map.get_node("YSort"))

	player.global_position = spawn.global_position
