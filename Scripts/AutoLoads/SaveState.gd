extends Node


var save_path: String = "user://OFEgame.save"
var options_save_path: String = "user://OFEoptions.save"



# Save the game
func save_game(game_save: bool):
	var save_file: File = File.new()
	var path: String
	var save_nodes

	if game_save == true: 
		path = save_path
		save_nodes = get_tree().get_nodes_in_group("Saved")
	else: 
		path = options_save_path
		save_nodes = get_tree().get_nodes_in_group("SavedOptions")

	save_file.open(path, File.WRITE)

	for node in save_nodes:
		var node_details = node.get_save_stats()
		save_file.store_line(to_json(node_details))

	save_file.close()



# Load the savefile
func load_game(game_save: bool):
	var save_file = File.new()
	var path: String
	var saved_nodes 

	if game_save == true: 
		path = save_path
		saved_nodes = get_tree().get_nodes_in_group("Saved")
	else: 

		path = options_save_path
		saved_nodes = get_tree().get_nodes_in_group("SavedOptions")

	if not save_file.file_exists(path):
		return

	save_file.open(path, File.READ)
	for node in saved_nodes:
		var node_data = parse_json(save_file.get_line())
		if node.has_method("load_save_stats"):
			node.load_save_stats(node_data)




