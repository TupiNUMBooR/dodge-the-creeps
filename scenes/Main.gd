extends Node

export (PackedScene) var Mob
var score

func _ready():
  randomize()


func _on_Player_hit():
  $ScoreTimer.stop()
  $MobTimer.stop()
  $Hud.show_game_over()
  $Music.stop()
  $DeathSound.play()

  
func new_game():
  get_tree().call_group("mobs", "queue_free")
  score = 0
  $Player.start($StartPosition.position)
  $StartTimer.start()
  $Hud.update_score(score)
  $Hud.show_message("Get Ready")
  $Music.play()


func _on_StartTimer_timeout():
  $MobTimer.start()
  $ScoreTimer.start()


func _on_ScoreTimer_timeout():
  score += 1
  $Hud.update_score(score)


func _on_MobTimer_timeout():
  $MobPath/MobSpawnLocation.offset = randi()
  var mob = Mob.instance()
  add_child(mob)
  var direction = $MobPath/MobSpawnLocation.rotation + PI/2
  mob.position = $MobPath/MobSpawnLocation.position
  direction += rand_range(-PI/4, PI/4)
  mob.rotation = direction
  mob.linear_velocity = Vector2(rand_range(mob.speed_range.x, mob.speed_range.y), 0)
  mob.linear_velocity = mob.linear_velocity.rotated(direction)
