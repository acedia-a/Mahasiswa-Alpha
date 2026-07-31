extends CharacterBody2D

@export var npc_name := "Mahasiswa"
@export_multiline var dialogue := "Halo!"

func interact():
	print(npc_name + ": " + dialogue)
