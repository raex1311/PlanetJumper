extends Node2D
var Shield_Price : int = 100

func Buy_Shield():
	if(GlobalVariables.globalpoints < Shield_Price):
		print("Not enough points to buy!!")
		return
	GlobalVariables.deduct_point(100)
	GlobalVariables.add_ShieldTime()
	SaveAndLoad.Save_PlayerData(SaveType.Points)
