extends Area2D
class_name Interactable

@export var prompt := "Tekan [E] untuk berinteraksi"

func interact():
	if get_parent().has_method("interact"):
		get_parent().interact()
