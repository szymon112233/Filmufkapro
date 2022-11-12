extends Node
class_name QuizManager

export(Array, Resource) var AllQuestions
export(Array, Resource) var TutorialQuestionsQueue

export(NodePath) var PathToMainUI

signal NewQuestionShown

var CurrentQuestionIndex
var CurrentQuestion: Question
var mainUIManager

func _ready():
	mainUIManager = get_node(PathToMainUI).get_node("MainUIManager") as MainUIManager
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

func MakeChoice(isLeft: bool):
	if isLeft:
		Anwser(CurrentQuestion.Choice1Valid)
	else:
		Anwser(CurrentQuestion.Choice2Valid)
		
		
func Anwser(isCorrect: bool):
	print(isCorrect)
	NextTutorialQuestion()
	
func Finish():
	print("Koniec")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
