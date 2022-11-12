extends Node
class_name AudioManager

func PlayBeat(currentSpeedMultiplier: float):
	$AudioStreamPlayer.pitch_scale = currentSpeedMultiplier 
	$AudioStreamPlayer.play()


func _on_QuizManager_NewQuestionShown(currentSpeedMultiplier):
	PlayBeat(currentSpeedMultiplier)
