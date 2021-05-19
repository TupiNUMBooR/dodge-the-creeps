extends Area2D

signal hit
export var speed = 400
var screen_size
var anim

func _ready():
  screen_size = get_viewport_rect().size
  anim = $AnimatedSprite
  hide()

func _process(delta):
  var velocity = Vector2()
  if Input.is_action_pressed("ui_right"):
    velocity.x += 1
  if Input.is_action_pressed("ui_left"):
    velocity.x -= 1
  if Input.is_action_pressed("ui_down"):
    velocity.y += 1
  if Input.is_action_pressed("ui_up"):
    velocity.y -= 1

  if velocity.length_squared() > 0:
    position += velocity.normalized() * speed * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)
    anim.play()
  else:
    anim.stop()

  if velocity.x != 0:
    anim.animation = "walk"
    anim.flip_v = false
    anim.flip_h = velocity.x < 0
  elif velocity.y != 0:
    anim.animation = "up"
    anim.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
  hide()
  emit_signal("hit")
  $CollisionShape2D.set_deferred("disabled", true)

func start(pos):
  position = pos
  show()
  $CollisionShape2D.disabled = false
