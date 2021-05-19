extends CanvasLayer

signal start_game

func show_message(text):
  $Message.text = text
  $Message.show()
  $MessageTimer.start()


func show_game_over():
  show_message("Game Over")
  yield($MessageTimer, "timeout")
  $Message.text = "Dodge the Creeps!"
  $Message.show();
  yield(get_tree().create_timer(1), "timeout")
  $RestartButton.show()


func update_score(score):
  $Score.text = str(score)


func _on_MessageTimer_timeout():
  $Message.hide()


func _on_RestartButton_pressed():
  $RestartButton.hide()
  emit_signal("start_game")
