extends Node
class_name QuizManager

export(Array, Resource) var AllQuestions
export(Array, Resource) var TutorialQuestionsQueue

export(NodePath) var PathToMainUI

signal NewQuestionShown
signal BeatPlayed(beatIndex)
signal AnwserPut(isCorrect)

const DefaultBPM = 90.0
const LastBeatIndex = 12 #Last beat is "Game over" ping
var targetInterval = 60.0 / DefaultBPM
var timeCounter = targetInterval
var beatCounter = 0

var CurrentQuestionIndex
var CurrentQuestion: Question
var mainUIManager

func _ready():
	mainUIManager = get_node(PathToMainUI) as MainUIManager
	CurrentQuestionIndex = -1;
	NextTutorialQuestion()

func _input(event):
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
	emit_signal("NewQuestionShown")
	beatCounter = 0
	timeCounter = targetInterval

func MakeChoice(isLeft: bool):
	if isLeft:
		Anwser(CurrentQuestion.Choice1Valid)
	else:
		Anwser(CurrentQuestion.Choice2Valid)
		
		
func Anwser(isCorrect: bool):
	print(isCorrect)
	emit_signal("AnwserPut", isCorrect)
	NextTutorialQuestion()
	
func Finish():
	print("Koniec")

func _process(delta):
	if (beatCounter > LastBeatIndex):
		return
	
	timeCounter += delta
	if timeCounter >= targetInterval:
		emit_signal("BeatPlayed", beatCounter)
		beatCounter += 1
		timeCounter -= targetInterval
