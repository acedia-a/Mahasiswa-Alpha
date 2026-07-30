extends CanvasLayer

@onready var time_label = $MarginContainer/VBoxContainer/TimeLabel

@onready var prompt_label = $PromptLabel

func show_prompt(text: String):
	prompt_label.text = text
	prompt_label.visible = true

func hide_prompt():
	prompt_label.visible = false
	
func _ready():

	TimeManager.minute_changed.connect(update_time)

	update_time(TimeManager.hour, TimeManager.minute)


func update_time(hour, minute):

	time_label.text = "%02d:%02d" % [hour, minute]
