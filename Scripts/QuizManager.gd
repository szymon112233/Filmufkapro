extends Node
class_name QuizManager

export(Array, Resource) var AllQuestions
export(Array, Resource) var TutorialQuestionsQueue
export(float) var SpeedMultiplier
export(NodePath) var PathToMainUI

signal NewQuestionShown(questionIndex)
signal BeatPlayed(beatIndex)
signal AnwserPut(isCorrect, isLeft)
signal HealthChanged(health)
signal GameEnd(isSuccess, score)

const DefaultBPM = 90.0
const LastBeatIndex = 12 #Last beat is "Game over" ping
var targetInterval
var timeCounter
var beatCounter = 0
var currentSpeedMultiplier

var CurrentQuestionIndex
var CurrentQuestion: Question
var mainUIManager
var healthCounter
var score

var isDuringWrongOrCorrectAnim = false

func _ready():
	mainUIManager = get_node(PathToMainUI) as MainUIManager
	CurrentQuestionIndex = -1
	healthCounter = 3
	score = 0
	NextTutorialQuestion()

func _input(event):
	if isDuringWrongOrCorrectAnim:
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
	beatCounter = 0
	targetInterval = 60.0 / (DefaultBPM * currentSpeedMultiplier) 
	timeCounter = targetInterval

func MakeChoice(isLeft: bool):
	if isLeft:
		Anwser(CurrentQuestion.Choice1Valid, isLeft)
	else:
		Anwser(CurrentQuestion.Choice2Valid, isLeft)
		
		
func Anwser(isCorrect: bool, isLeft: bool):
	print(isCorrect)
	emit_signal("AnwserPut", isCorrect, isLeft)
	if isCorrect:
		score += 1
	else:
		healthCounter -= 1
		emit_signal("HealthChanged", healthCounter)
		
	
	isDuringWrongOrCorrectAnim = true
	# Hardcoded!
	yield(get_tree().create_timer(2.0), "timeout")
	isDuringWrongOrCorrectAnim = false
	
	NextTutorialQuestion()
	
func Finish():
	emit_signal("GameEnd", true, score)
	
func Die():
	emit_signal("GameEnd", false, score)

func _process(delta):
	if (beatCounter > LastBeatIndex):
		return
	
	timeCounter += delta
	if timeCounter >= targetInterval:
		emit_signal("BeatPlayed", beatCounter)
		beatCounter += 1
		timeCounter -= targetInterval
