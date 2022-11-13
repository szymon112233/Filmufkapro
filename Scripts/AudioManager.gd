extends Node
class_name AudioManager



func _ready():
	$"../AnimationPlayer".play("MainBeat")

func _on_QuizManager_NewQuestionShown(currentSpeedMultiplier):
	$"../AnimationPlayer".playback_speed = currentSpeedMultiplier
	$"../AudioStreamPlayer".pitch_scale = currentSpeedMultiplier
