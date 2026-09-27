extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY_MULTIPLIER = 1.0
const COYOTE_TIME: float = 0.1
const JUMP_BUFFER: float = 0.1

const WALL_SLIDE_SPEED: float = 60.0
const WALL_JUMP_VELOCITY: Vector2 = Vector2(300, -400)
const WALL_COYOTE_TIME: float = 0.1
const WALL_JUMP_LOCK: float = 0.15 # steering lock after wall jump

const IDLE_TIME: float = 30.0

var coyote_timer: float = 0.0
var buffer_timer: float = 0.0

var wall_coyote_timer: float = 0.0
var wall_normal: Vector2 = Vector2.ZERO
var control_lock: float = 0.0
var last_wall_jump_normal: Vector2 = Vector2.ZERO

var dead: bool = false
var spawn_pos: Vector2 = Vector2.ZERO

var idle_timer: float = 0.0

enum states {
	IDLE,
	WALK,
	JUMP,
	FALL,
	DEAD,
	SLEEP
}

var str_states: Array[String] = ["IDLE","WALK","JUMP","FALL","DEAD","SLEEP"]

var current_state = states.IDLE
var last_state = states.IDLE

func _ready() -> void:
	spawn_pos = global_position

func _physics_process(delta: float) -> void:
	if current_state != states.DEAD:
		var direction := Input.get_axis("left", "right")
		var on_wall := is_on_wall_only() and direction != 0.0

		# gravity
		if not is_on_floor():
			velocity += get_gravity() * delta * GRAVITY_MULTIPLIER
			if on_wall and velocity.y > WALL_SLIDE_SPEED:
				velocity.y = WALL_SLIDE_SPEED
		
		# Coyote: refill while grounded, count down in the air
		if is_on_floor():
			coyote_timer = COYOTE_TIME
			last_wall_jump_normal = Vector2.ZERO
		else:
			coyote_timer -= delta
		
		# Wall coyote
		if on_wall:
			wall_coyote_timer = WALL_COYOTE_TIME
			wall_normal = get_wall_normal()
		else:
			wall_coyote_timer -= delta
		
		# Buffer: remember the jump press briefly
		if Input.is_action_just_pressed("jump"):
			buffer_timer = JUMP_BUFFER
		else:
			buffer_timer -= delta
		
		# Jumps: floor takes priority, then wall
		if buffer_timer > 0.0:
			if coyote_timer > 0.0:
				velocity.y = JUMP_VELOCITY
				buffer_timer = 0.0
				coyote_timer = 0.0
			elif wall_coyote_timer > 0.0 and wall_normal != last_wall_jump_normal:
				velocity.x = wall_normal.x * WALL_JUMP_VELOCITY.x
				velocity.y = WALL_JUMP_VELOCITY.y
				buffer_timer = 0.0
				wall_coyote_timer = 0.0
				control_lock = WALL_JUMP_LOCK
				last_wall_jump_normal = wall_normal
		
		# Short hop when jump is released early
		if Input.is_action_just_released("jump") and velocity.y < 0.0:
			velocity.y *= 0.5
		
		# Horizontal movement (skipped briefly after a wall jump)
		if control_lock > 0.0:
			control_lock -= delta
		else:
			velocity.x = direction * SPEED if direction else move_toward(velocity.x, 0, SPEED)
		
		# State detection
		if is_on_floor() and velocity == Vector2.ZERO:
			# Long idle checker
			idle_timer += delta
			if idle_timer >= IDLE_TIME:
				last_state = current_state
				current_state = states.SLEEP
			else:
				last_state = current_state
				current_state = states.IDLE
		else:
			idle_timer = 0
		if is_on_floor() and velocity.x != 0 and current_state != states.JUMP:
			last_state = current_state
			current_state = states.WALK
		if velocity.y > 0:
			last_state = current_state
			current_state = states.FALL
		
		# Animation selector
		if current_state == states.IDLE:
			$AnimatedSprite2D.play("default")
		if current_state == states.WALK:
			$AnimatedSprite2D.play("walk")
		if current_state == states.SLEEP:
			$AnimatedSprite2D.play("sleep")
		if current_state == states.FALL:
			$AnimatedSprite2D.play("fall")
		
		# On jump play start of jump frames
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			last_state = current_state
			current_state = states.JUMP
			$AnimatedSprite2D.play("jump_start")
			await $AnimatedSprite2D.animation_finished
			$AnimatedSprite2D.play("jump")
		
		# On land after fall play end_jump
		if is_on_floor() and last_state == states.FALL:
			$AnimatedSprite2D.play("jump_end")
			await $AnimatedSprite2D.animation_finished
		
		# Flip animated sprite on -X
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		
		$Label.text = str_states[current_state] + $AnimatedSprite2D.animation + str(velocity)
		
		move_and_slide()

func die():
	current_state = states.DEAD
	$AnimatedSprite2D.play("die")
	await $AnimatedSprite2D.animation_finished
	velocity = Vector2.ZERO
	set_global_position(spawn_pos)
	$AnimatedSprite2D.play("default")
	current_state = states.IDLE
