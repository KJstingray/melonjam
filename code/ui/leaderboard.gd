extends Control

@onready var http_client = $HTTPRequest
@onready var v_box_container = $Panel/ScrollContainer/VBoxContainer
@onready var loading = $Panel/Loading

var template_panel = preload("res://scenes/ui/leaderboard_panel.tscn")

func _ready():
	http_client.request_completed.connect(self._on_request_completed)
	Globals.get_request(http_client)


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	loading.visible = false

	for i in range(len(response)):
		var new_panel = template_panel.instantiate()
		new_panel.get_node('Panel/HBoxContainer/Place').text = str(i + 1) + '.'
		new_panel.get_node('Panel/HBoxContainer/Name').text = str(response[i]['name'])
		new_panel.get_node('Panel/HBoxContainer/Score').text = str(response[i]['score'])
		v_box_container.add_child(new_panel, true)
