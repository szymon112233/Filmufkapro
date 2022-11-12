extends Node
class_name AudioManager



func _ready():
	$"../AnimationPlayer".play("MainBeat")
	
func PlayBeat(currentSpeedMultiplier: float):
	$AudioStreamPlayer.pitch_scale = currentSpeedMultiplier 
	$AudioStreamPlayer.play()


func _on_QuizManager_NewQuestionShown(currentSpeedMultiplier):
	# PlayBeat(currentSpeedMultiplier)
	$"../AnimationPlayer".playback_speed = currentSpeedMultiplier
	$"../AudioStreamPlayer".pitch_scale = currentSpeedMultiplier
