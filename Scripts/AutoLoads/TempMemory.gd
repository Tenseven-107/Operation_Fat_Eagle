extends Node


var risk: int = 0
var highest_risk: int = 0

# Set up
func _ready():
	add_to_group("Saved")
	SaveState.load_game(true)


# Set and reset risk score
func reset():
	risk = 0

func record_risk_record(var risk_level: float):
	risk = risk_level * 100
	if risk > highest_risk:
		highest_risk = risk
		SaveState.save_game(true)

func get_risk_levels():
	return [risk, highest_risk]



# Saving stats
func get_save_stats():
	return {
		"stats" : {
			"highscore" : highest_risk
		}
	}

func load_save_stats(stats):
	highest_risk = stats.stats.highscore
