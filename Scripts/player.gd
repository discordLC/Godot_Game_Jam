extends CharacterBody2D

signal shoot

const START_SPEED : int = 200
const BOOST_SPEED : int = 400
const NORMAL_SHOT : float = 1
const BOOST_SHOT : float = 0.5
var speed : int
var can_shoot : bool
var screen_size : Vector2


func _ready():
	screen_size = get_viewport_rect().size
	reset()


func reset():
	can_shoot = true
	position = screen_size / 2
	speed = START_SPEED
	$BulletTimer.wait_time = NORMAL_SHOT


func get_input():
	# Keyboard Input
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_dir.normalized() * speed
	
	# Mouse Input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir)
		$AudioStreamPlayer.play()
		can_shoot = false
		$BulletTimer.start()

func _physics_process(_delta):
	# Player Movement
	get_input()
	move_and_slide()
	
	# Limit Movement to window size
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Player Rotation
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	
	$AnimatedSprite2D.animation = "walk" + str(angle)
	
	# Player Animation
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1


func boost():
	$BoostTimer.start()
	speed = BOOST_SPEED


func quick_fire():
	$FastFireTimer.start()
	$BulletTimer.wait_time = BOOST_SHOT


func _on_bullet_timer_timeout():
	can_shoot = true


func _on_boost_timer_timeout():
	speed = START_SPEED


func _on_fast_fire_timer_timeout():
	$BulletTimer.wait_time = NORMAL_SHOT
