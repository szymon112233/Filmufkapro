extends Node
class_name AudioManager



#func _ready():
#	$"../AnimationPlayer".play("MainBeat")

func _on_QuizManager_NewQuestionShown(currentSpeedMultiplier):
	$"../AnimationPlayer".playback_speed = currentSpeedMultiplier
	$"../AudioStreamPlayer".pitch_scale = currentSpeedMultiplier


func _on_QuizManager_AnwserPut(isCorrect, isLeft, currentSpeedMultiplier):
	if isCorrect:
		$CorrectSound.play()
	else:
		$WrongSound.play()
		
func _on_QuizManager_GameStarted():
	$"../AnimationPlayer".play("MainBeat")
