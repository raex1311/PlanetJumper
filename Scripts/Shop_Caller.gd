extends Node
signal CloseShop
signal buyshield
signal buypoints
signal buybooster

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func closeShopButton():
	print("Closing the shop button.")
	emit_signal("CloseShop")

func Hello():
	print("This is coming from the Shop.gd!!!")

func buy_shield():
	print("Bought Shield")
	emit_signal("buyshield")
	
func buy_points():
	print("Bought Points!!")
	emit_signal("buypoints")
	
func buy_booster():
	print("Bought Booster!!")
	emit_signal("buybooster")
