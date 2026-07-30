extends CanvasLayer

@onready var time_label = $MarginContainer/VBoxContainer/TimeLabel

@onready var prompt = $PromptLabel

func show_prompt(text := "Tekan E"):
	prompt.text = text
	prompt.visible = true

func hide_prompt():
	prompt.visible = false
	
func _ready():

	TimeManager.minute_changed.connect(update_time)

	update_time(TimeManager.hour, TimeManager.minute)


func update_time(hour, minute):

	time_label.text = "%02d:%02d" % [hour, minute]
