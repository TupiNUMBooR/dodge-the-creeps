extends RigidBody2D

export var speed_range = Vector2(150, 250)

func _ready():
  var mob_types = $AnimatedSprite.frames.get_animation_names()
  $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
  queue_free()
