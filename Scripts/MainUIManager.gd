extends Node
class_name MainUIManager

export(NodePath) var PathToQuestionLabel
export(NodePath) var PathToOption1
export(NodePath) var PathToOption2

func SetupNewQuestion(question: Question):
	var questionLabel = get_node(PathToQuestionLabel) as Label
	questionLabel.text = question.QuestionContent
	
	var option1Image = get_node(PathToOption1).get_node("ColorRect/TextureRect") as TextureRect
	option1Image.texture = question.Choice1.Icon
	
	var option2Image = get_node(PathToOption2).get_node("ColorRect/TextureRect") as TextureRect
	option2Image.texture = question.Choice2.Icon
