extends Node

var http_client: HTTPRequest = HTTPRequest.new()
var URL: String = ''

func _ready():
	http_client.request_completed.connect(self._on_request_completed)

func post(data):
	var body = JSON.new().stringify(data)
	var error = http_client.request(URL, [], HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(error)
	
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	print(response)
