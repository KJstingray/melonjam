extends Control

@onready var start_button = $CustomButtonText
@onready var http_client = $HTTPRequest

func _ready():
	http_client.request_completed.connect(self._on_request_completed)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and start_button.mouse_over:
		print('dupa')
		start_button.on_click()
		var test_dict = { 'name':'godot_test', 'score': 99921}
		post_request(test_dict)

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	print(response)
	
func post_request(data: Dictionary):
	var body = JSON.new().stringify(data)
	var error = http_client.request(Globals.URL, [], HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(error)

func get_request():
	var error = http_client.request(Globals.URL)
	if error != OK:
		push_error(error)
