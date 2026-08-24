extends CharacterBody2D


@export var SPEED = 80.0
const JUMP_VELOCITY = -100.0

@onready var sprite = $AnimatedSprite2D
var direcao := 'down'    # down, up, horizontal, diagonal-up, diagonal-down
var flip_h := false

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var animacao = "move"  # move, walk, run, interact
	
	
	if Input.is_action_pressed("move-up"):
		velocity.y -= 1
	if Input.is_action_pressed("move-down"):
		velocity.y += 1
	if Input.is_action_pressed("move-right"):
		velocity.x += 1
	if Input.is_action_pressed("move-left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		if Input.is_action_pressed("run"):
			animacao = "run"
			SPEED = 80
		else:
			animacao = "walk"
			SPEED = 60	
		
		if abs(velocity.x) > abs(velocity.y):
			direcao = "horizontal"
		elif abs(velocity.x) == abs(velocity.y) and velocity.x != 0:
			#pass
			direcao = "diagonal-up" if velocity.y < 0 else "diagonal-down"
		else:
			direcao = "up" if velocity.y < 0 else "down"
		
		if velocity.x > 0:
			flip_h = false
		if velocity.x < 0:	
			flip_h = true
			
		velocity = velocity.normalized() * SPEED
		position += velocity * delta
		
	else:
		animacao = "idle"
		
	sprite.play(animacao + "-" + direcao)
	sprite.flip_h = flip_h
	print(velocity.length())
	
