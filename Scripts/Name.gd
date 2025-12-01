extends Control
@export var nametext : TextEdit

var save_path := "user://save//player_name.save"

func _ready() -> void:
	if FileAccess.file_exists(save_path):
		close_namepanel()
		var name = load_name()
		print("The NAAAAAMEEEEEE IS::::",name)


func save_name(player_name: String) -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_line(player_name)
		file.close()

func load_name() -> String:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			var name = file.get_line()
			file.close()
			return name
	return ""  # Default if file doesn't exist
	
func Submit_Name():
	close_namepanel()
	save_name(nametext.text)
	
func close_namepanel():
	self.visible = false
	
