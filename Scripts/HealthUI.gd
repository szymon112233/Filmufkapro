extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MaxHealth = 3;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetHealth(health):
	if health >= MaxHealth || health <= 0:
		return
	if health == 1:
		$HPImage1.visible = true
		$HPImage2.visible = false
		$HPImage3.visible = false
	elif health == 2:
		$HPImage1.visible = true
		$HPImage2.visible = true
		$HPImage3.visible = false
	elif health == 2:
		$HPImage1.visible = true
		$HPImage2.visible = true
		$HPImage3.visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
