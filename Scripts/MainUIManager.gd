extends Node
class_name MainUIManager

export(NodePath) var PathToQuestionLabel1
export(NodePath) var PathToQuestionLabel2
export(NodePath) var PathToOption1
export(NodePath) var PathToOption2

var currentQuestion

const EndGameString = "%s \n Score: %s"
var originalOptionUIColor
var beatIndex

func _ready():
	originalOptionUIColor = (get_node(PathToOption1).get_node("ColorRect") as ColorRect).color


func SetupNewQuestion(question: Question):
	currentQuestion = question
	
	(get_node(PathToOption1).get_node("ColorRect") as ColorRect).color = originalOptionUIColor
	(get_node(PathToOption2).get_node("ColorRect") as ColorRect).color = originalOptionUIColor
		
	var option1Image = get_node(PathToOption1).get_node("ColorRect/TextureRect") as TextureRect
	var option1Label = get_node(PathToOption1).get_node("ColorRect/Label") as Label
	option1Image.texture = question.Choice1.Icon
	option1Image.self_modulate = question.Choice1.IconColor
	option1Label.text = question.Choice1.Name
	
	var option2Image = get_node(PathToOption2).get_node("ColorRect/TextureRect") as TextureRect
	var option2Label = get_node(PathToOption2).get_node("ColorRect/Label") as Label
	option2Image.texture = question.Choice2.Icon
	option2Image.self_modulate = question.Choice2.IconColor
	option2Label.text = question.Choice2.Name
	
	get_node(PathToQuestionLabel1).hide()
	get_node(PathToQuestionLabel2).hide()
	get_node(PathToOption1).hide()
	get_node(PathToOption2).hide()
	
	beatIndex = 0


func _on_QuizManager_BeatPlayed():
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
	beatIndex += 1


func _on_QuizManager_AnwserPut(isCorrect, isLeft):
	var chosenChoicePath
	var colorToSet
	
	if isLeft:
		chosenChoicePath = PathToOption1
	else:
		chosenChoicePath = PathToOption2
	
	if isCorrect:
		$CorrectAnimPlayer.play("CorrectAnim")
		colorToSet = Color.lawngreen
	else:
		$CorrectAnimPlayer.play("WrongAnim")
		colorToSet = Color.crimson
		
	(get_node(chosenChoicePath).get_node("ColorRect") as ColorRect).color = colorToSet


func _on_QuizManager_HealthChanged(health):
	var healthUi = $"Healthbar UI" as HealthUI
	healthUi.SetHealth(health)
	


func _on_QuizManager_GameEnd(isSuccess, score):
	if isSuccess:
		$EndGamePopup/EndGameLabel.text = EndGameString % ["You win!", score]
	else:
		$EndGamePopup/EndGameLabel.text = EndGameString % ["You loose!", score]
	$EndGamePopup.show()
