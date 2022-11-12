extends Node
class_name MainUIManager

export(NodePath) var PathToQuestionLabel
export(NodePath) var PathToOption1
export(NodePath) var PathToOption2

func SetupNewQuestion(question: Question):
	var questionLabel = get_node(PathToQuestionLabel) as Label
	questionLabel.text = question.QuestionContent
	
	var option1Image = get_node(PathToOption1).get_node("ColorRect/TextureRect") as TextureRect
	var option1Label = get_node(PathToOption1).get_node("ColorRect/Label") as Label
	option1Image.texture = question.Choice1.Icon
	option1Label.text = question.Choice1.Name
	
	var option2Image = get_node(PathToOption2).get_node("ColorRect/TextureRect") as TextureRect
	var option2Label = get_node(PathToOption2).get_node("ColorRect/Label") as Label
	option2Image.texture = question.Choice2.Icon
	option2Label.text = question.Choice2.Name
	
	get_node(PathToQuestionLabel).hide()
	get_node(PathToOption1).hide()
	get_node(PathToOption2).hide()


func _on_QuizManager_BeatPlayed(beatIndex):
	print(beatIndex)
	
	match beatIndex:
		0:
			get_node(PathToQuestionLabel).show()
		4:
			get_node(PathToOption1).show()
		5:
			get_node(PathToOption2).show()
