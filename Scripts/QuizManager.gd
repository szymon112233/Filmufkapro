extends Node
class_name QuizManager

export(Array, Resource) var AllQuestions
export(Array, Resource) var TutorialQuestionsQueue
export(float) var SpeedMultiplier
export(NodePath) var PathToMainUI


signal NewQuestionShown(currentSpeedMultiplier)
signal BeatPlayed()
signal AnwserPut(isCorrect, isLeft, currentSpeedMultiplier)
signal HealthChanged(health)
signal GameEnd(isSuccess, score)

const LastBeatIndex = 12 #Last beat is "Game over" ping
var currentSpeedMultiplier


var CurrentQuestionIndex
var CurrentQuestion: Question
var mainUIManager
var healthCounter
var score
var isDone
var BeatActionQueue: Array

var isDuringWrongOrCorrectAnim = false

func _ready():
	mainUIManager = get_node(PathToMainUI) as MainUIManager
	CurrentQuestionIndex = -1
	healthCounter = 3
	score = 0
	NextTutorialQuestion()

func _input(event):	
	if event.is_action_released("ui_cancel") && isDone:
		get_tree().reload_current_scene()
		return
		
	if isDone || isDuringWrongOrCorrectAnim:
		return
	
	if event.is_action_released("left_option"):
		MakeChoice(true)
	elif event.is_action_released("right_option"):
		MakeChoice(false)
		
func NextTutorialQuestion():
	if CurrentQuestionIndex >= TutorialQuestionsQueue.size() -1 :
		Finish()
		return
	CurrentQuestionIndex += 1
	CurrentQuestion = (TutorialQuestionsQueue[CurrentQuestionIndex] as Question)
	mainUIManager.SetupNewQuestion(CurrentQuestion)
	
	currentSpeedMultiplier = 1 + SpeedMultiplier * CurrentQuestionIndex
	emit_signal("NewQuestionShown", currentSpeedMultiplier)


func MakeChoice(isLeft: bool):
	if isLeft:
		Anwser(CurrentQuestion.Choice1Valid, isLeft)
	else:
		Anwser(CurrentQuestion.Choice2Valid, isLeft)
		
		
func Anwser(isCorrect: bool, isLeft: bool):
	print(isCorrect)
	emit_signal("AnwserPut", isCorrect, isLeft, currentSpeedMultiplier)
	if isCorrect:
		score += 1
	else:
		healthCounter -= 1
		emit_signal("HealthChanged", healthCounter)
		if healthCounter <= 0:
			Die()
			return
		
	
	isDuringWrongOrCorrectAnim = true
	# Hardcoded!
	yield(get_tree().create_timer(2.0 / currentSpeedMultiplier), "timeout")
	isDuringWrongOrCorrectAnim = false
	
	NextTutorialQuestion()
	
func Finish():
	isDone = true
	emit_signal("GameEnd", true, score)
	
func Die():
	isDone = true
	emit_signal("GameEnd", false, score)
	

func Beat():
	print("Beat")
	emit_signal("BeatPlayed")
