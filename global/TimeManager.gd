extends Node

signal minute_changed(hour, minute)
signal hour_changed(hour)
signal day_changed(day)

@export var real_seconds_per_game_minute := 1.0

var minute := 0
var hour := 6
var day := 1
var week := 1
var semester := 1
var year := 1

var _timer := 0.0


func _process(delta):

	_timer += delta

	if _timer >= real_seconds_per_game_minute:

		_timer = 0

		add_minute()


func add_minute():

	minute += 1

	if minute >= 60:

		minute = 0
		hour += 1

		hour_changed.emit(hour)

	if hour >= 24:

		hour = 0
		day += 1

		day_changed.emit(day)

	minute_changed.emit(hour, minute)


func get_time_string():

	return "%02d:%02d" % [hour, minute]
