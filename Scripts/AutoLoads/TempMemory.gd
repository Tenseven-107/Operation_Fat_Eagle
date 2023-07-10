extends Node


var risk: int = 0
var highest_risk: int = 0

# Set and reset risk score
func reset():
	risk = 0

func record_risk_record(var risk_level: float):
	risk = risk_level * 100
	if risk > highest_risk:
		highest_risk = risk

func get_risk_levels():
	return [risk, highest_risk]
