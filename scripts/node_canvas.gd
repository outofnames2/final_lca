extends Control

@onready var G : GraphEdit = $GraphEdit



func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	G.connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	G.disconnect_node(from_node, from_port, to_node, to_port)
	
func _unhandled_input(event):
	var connections = G.get_connection_list()

	if Input.is_action_just_pressed("ui_accept"):
		for i in range(connections.size()):
			var input = G.get_node(NodePath(connections[0].from_node)).slot_data_output
			G.get_node(NodePath(connections[0].to_node)).slot_data_process(input)
