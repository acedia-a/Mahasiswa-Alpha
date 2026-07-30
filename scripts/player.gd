extends CharacterBody2D

enum State {
	IDLE,
	WALK,
	RUN,
	INTERACT,
	CUTSCENE
}

@export var walk_speed: float = 100.0
@export var run_speed: float = 180.0

var state: State = State.IDLE
var facing_direction: Vector2 = Vector2.DOWN
var move_direction: Vector2 = Vector2.ZERO

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interact_area: Area2D = $Area2D

var nearby_interactables: Array[Area2D] = []


func _ready() -> void:
	interact_area.area_entered.connect(_on_interact_area_entered)
	interact_area.area_exited.connect(_on_interact_area_exited)


func _on_interact_area_entered(area: Area2D) -> void:
	if area is Interactable:
		nearby_interactables.append(area)
		get_tree().current_scene.get_node("CanvasLayer").show_prompt(area.prompt)


func _on_interact_area_exited(area: Area2D) -> void:
	if area is Interactable:
		nearby_interactables.erase(area)

	if nearby_interactables.is_empty():
		get_tree().current_scene.get_node("CanvasLayer").hide_prompt()
	else:
		var target = get_closest_interactable()
		get_tree().current_scene.get_node("CanvasLayer").show_prompt(target.prompt)


func get_closest_interactable() -> Area2D:
	var closest: Area2D = null
	var min_dist: float = INF
	for area: Area2D in nearby_interactables:
		var dist: float = global_position.distance_squared_to(area.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = area
	return closest


func interact() -> void:
	if state == State.CUTSCENE:
		return

	var target: Area2D = get_closest_interactable()
	if target:
		target.interact()


func _physics_process(_delta):
	if Input.is_action_just_pressed("interact"):
		interact()

	if state == State.CUTSCENE:
		return

	get_input()
	move_player()
	update_animation()


func get_input():

	move_direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	if move_direction != Vector2.ZERO:
		facing_direction = move_direction.normalized()

	if move_direction == Vector2.ZERO:
		state = State.IDLE
	else:
		if Input.is_action_pressed("run"):
			state = State.RUN
		else:
			state = State.WALK


func move_player():

	match state:

		State.RUN:
			velocity = move_direction * run_speed

		State.WALK:
			velocity = move_direction * walk_speed

		_:
			velocity = Vector2.ZERO

	move_and_slide()


func update_animation():

	var dir := facing_direction

	if abs(dir.x) > abs(dir.y):

		if dir.x > 0:

			if state == State.IDLE:
				sprite.play("right_idle")
			else:
				sprite.play("right_walk")

		else:

			if state == State.IDLE:
				sprite.play("left_idle")
			else:
				sprite.play("left_walk")

	else:

		if dir.y > 0:

			if state == State.IDLE:
				sprite.play("front_idle")
			else:
				sprite.play("front_walk")

		else:

			if state == State.IDLE:
				sprite.play("back_idle")
			else:
				sprite.play("back_walk")
