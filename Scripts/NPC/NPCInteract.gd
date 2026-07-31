extends Interactable

@export var npc: CharacterBody2D

func interact():
	if npc:
		npc.interact()
