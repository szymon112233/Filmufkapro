extends Node
class_name MainUIManager

export(NodePath) var PathToQuestionLabel1
export(NodePath) var PathToQuestionLabel2
export(NodePath) var PathToOption1
export(NodePath) var PathToOption2

var currentQuestion

func SetupNewQuestion(question: Question):
	currentQuestion = question
		
	var option1Image = get_node(PathToOption1).get_node("ColorRect/TextureRect") as TextureRect
	var option1Label = get_node(PathToOption1).get_node("ColorRect/Label") as Label
	option1Image.texture = question.Choice1.Icon
	option1Label.text = question.Choice1.Name
	
	var option2Image = get_node(PathToOption2).get_node("ColorRect/TextureRect") as TextureRect
	var option2Label = get_node(PathToOption2).get_node("ColorRect/Label") as Label
	option2Image.texture = question.Choice2.Icon
	option2Label.text = question.Choice2.Name
	
	get_node(PathToQuestionLabel1).hide()
	get_node(PathToQuestionLabel2).hide()
	get_node(PathToOption1).hide()
	get_node(PathToOption2).hide()


func _on_QuizManager_BeatPlayed(beatIndex):
	print(beatIndex)
	
	match beatIndex:
		0:
			var words = currentQuestion.QuestionContent.split(" ")
			var questionLabel1 = get_node(PathToQuestionLabel1) as Label
			questionLabel1.text = words[0]
			get_node(PathToQuestionLabel1).show()
		1:
			var words = currentQuestion.QuestionContent.split(" ")
			var questionLabel1 = get_node(PathToQuestionLabel1) as Label
			questionLabel1.text = words[0] + " " + words[1]
		2:
			var words = currentQuestion.QuestionContent.split(" ")
			var questionLabel2 = get_node(PathToQuestionLabel2) as Label
			questionLabel2.text = words[2].substr(0, words[2].length() - 1)
			get_node(PathToQuestionLabel2).show()
		3:
			var words = currentQuestion.QuestionContent.split(" ")
			var questionLabel2 = get_node(PathToQuestionLabel2) as Label
			questionLabel2.text = words[2]
		4:
			get_node(PathToOption1).show()
		5:
			get_node(PathToOption2).show()


func _on_QuizManager_AnwserPut(isCorrect):
	if isCorrect:
		$CorrectAnimPlayer.play("CorrectAnim")
	else:
		$CorrectAnimPlayer.play("WrongAnim")
