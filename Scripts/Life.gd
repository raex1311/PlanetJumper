extends HFlowContainer

@export var Heart1 : TextureRect
@export var Heart2 : TextureRect
@export var Heart3 : TextureRect
@export var GameManager : Node2D
var stack = []

func _ready() -> void:
	GameManager.connect("DeductLife",DeductTheLife)
	stack.append(Heart1)
	stack.append(Heart2)
	stack.append(Heart3)
	pass

func DeductTheLife():
	print("Deducting Life!!")
	var top = stack[-1]
	print("Name of top: ", top)
	top.visible = false
	stack.pop_back()
	pass
	
