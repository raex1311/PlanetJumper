extends Node2D
var json = JSON.new()

var firebase_url = "https://planetjumper-8af2b-default-rtdb.firebaseio.com/highscores.json"
var firebase_url2 = "https://planetjumper-8af2b-default-rtdb.firebaseio.com/highscores/<uniqueID>.json"
var uniqueID

func _ready() -> void:
	uniqueID = OS.get_unique_id()
	get_highest_score()
# Function to get the highest score
func get_highest_score():
	var url = firebase_url + "?orderBy=\"score\"&print=pretty"  # Fetch the top score
	var http_request = HTTPRequest.new()
	add_child(http_request)
	print("URL: ", url)
	# Start the request
	http_request.request(url)
	
	# Connect the signal using the new syntax
	http_request.request_completed.connect(_on_high_score_fetched)

# Function to handle the completion of the request
func _on_high_score_fetched(result: int, response_code: int, headers: Array, body: PackedByteArray):
	if response_code == 200:
		var body_string = body.get_string_from_utf8()  # Convert body to string
		
		var json = JSON.new()  # Create an instance of the JSON class
		var parse_result = json.parse_string(body_string)# Parse JSON response
		
		if(parse_result is Dictionary):
			print("Top Player: ", " Score: ",parse_result.values())
			var score = parse_result.values()
			var scoreString = score[0]
			var name = scoreString["name"]
			var actualScore = scoreString["score"]
			print("Name: ",name," Score: ",actualScore)
		else:
			print("Error parsing JSON: ", parse_result)
	else:
		print("Error fetching high score: ", response_code)

#================================================================================================
# Function to write player score to Firebase
func write_high_score(player_name: String, score: int):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var json_data = {
		"name" : player_name,
		"score" : score
	}
	var headers = ["Content-Type: application/json"]
	
	#Send HTTP POST request to Firebase
	var player_url = firebase_url2.replace("<uniqueID>",uniqueID)
	http_request.request(player_url,headers,HTTPClient.METHOD_PUT,JSON.stringify(json_data))
	
	#Connect the signal for handling the response
	http_request.request_completed.connect(_on_high_score_written)
	
#Callback for handling the response after writing the data
func _on_high_score_written(result:int, response_code:int, headers: Array,body: PackedByteArray):
	if response_code == 200:
		print("High score written successfully!")
	else:
		print("Error writing high score: ", response_code)

#================================================================================================
#Function to updatge the player's score in Firebase
func update_high_score(new_score: int):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var json_data = {
		"score": new_score
	}
	var headers = ["Content-Type: application/json"]
	var player_url = firebase_url2.replace("<uniqueID>",uniqueID)
	http_request.request(player_url,headers,HTTPClient.METHOD_PATCH,JSON.stringify(json_data))
	
	http_request.request_completed.connect(_on_score_updated)

func _on_score_updated(result: int, response_code: int, headers: Array, body: PackedByteArray):
	if(response_code==200):
		print("Player Score Updated!!")
	else:
		print("Error updating player's score: " , response_code)
#=================================================================================================

#Function to fetch the player's score from Firebase
func fetch_my_score():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	#Construct the URL for the specified player
	var player_url = firebase_url2.replace("<uniqueID>",uniqueID)
	
	#Send HTTP GET request to firebase to fetch the player's score
	http_request.request(player_url)
	
	#Connect the signal for handling the response
	http_request.request_completed.connect(_on_my_score_fetched)
	
#Callback for handling the response after fetching the score
func _on_my_score_fetched(result:int, response_code:int, headers: Array, body: PackedByteArray):
	if(response_code==200):
		var body_string = body.get_string_from_utf8() #Conver body to string
		var json = JSON.new()
		print("Json Raw: ", body_string)
		var parse_result = json.parse_string(body_string)
		
		if parse_result is Dictionary:
			print("Parse Result is Dictionary. Score: " , parse_result["score"])
			update_high_score(GlobalVariables.HighScore)
			
		else:
			print("Parse Result is not a Dict")
			write_high_score("RaeX",GlobalVariables.HighScore)
			
			#var player_data = json.data
			#var score = player_data.get("score",null)
			#if(score!=null):
			#	print("Your Score: ", score)
			#else:
			#	print("Score not found for the player")
	else:
		print("Error fetching your score so Writing: ", response_code)
