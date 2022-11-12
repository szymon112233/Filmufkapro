extends Node
class_name AudioManager

func PlayBeat():
	$AudioStreamPlayer.play()


func _on_QuizManager_NewQuestionShown():
	PlayBeat()
