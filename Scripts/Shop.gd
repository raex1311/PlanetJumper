extends Node2D
var Shield_Price : int = 10

func Buy_Shield():
	if(GlobalVariables.globalpoints < Shield_Price):
		print("Not enough points to buy!!")
		return
	print("Bought Points!!")
	GlobalVariables.deduct_point(10)
	GlobalVariables.add_ShieldTime()
	var type = SavingTypeList.new()
	type.type_list["Points"] = true
	type.type_list["ShieldTime"] = true
	SaveAndLoad.Save_PlayerData(type)
	
func Buy_Points():
	GlobalVariables.add_custom_points(100)
	var type = SavingTypeList.new()
	type.type_list["Points"] = true
	SaveAndLoad.Save_PlayerData(type)
