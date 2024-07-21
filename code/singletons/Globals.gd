extends Node

var URL: String = 'https://somnys.pythonanywhere.com/api/scores'
var PLAYER_NAME = ''
var SCORE = 0

func post_request(data: Dictionary, http_client: HTTPRequest):
	var body = JSON.new().stringify(data)
	var error = http_client.request(Globals.URL, [], HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(error)
		
func get_request(http_client: HTTPRequest):
	var error = http_client.request(Globals.URL)
	if error != OK:
		push_error(error)
		
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	#debug
	print(response)
