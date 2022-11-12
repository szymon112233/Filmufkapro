extends Node
class_name QuizManager

export(Array, Resource) var Questions

export(NodePath) var PathToMainUI

func _ready():
	var mainUIManager = get_node(PathToMainUI).get_node("MainUIManager") as MainUIManager
	mainUIManager.SetupNewQuestion(Questions[0] as Question)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
