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


func _physics_process(_delta):

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
