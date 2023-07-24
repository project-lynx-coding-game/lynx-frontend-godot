extends 'res://addons/gut/test.gd'


func test_serialize_valid_agent_properly_serializes():
	var Agent = preload("res://entity/object/agent.tscn")
	var expected_serialized_agent = {
		"type": "Object",
		"attributes": {
			"id": 123,
			"name": "Agent",
			"position": {
				"x": 1,
				"y": 2
			},
			"owner": "dummy-owner",
			"tick": "dummy-code"
		}
	}
	var agent = Agent.instantiate()
	agent.init(Vector2(1, 2), 123, "dummy-owner", "dummy-code")
	var serialized_agent = agent.serialize()
	assert_eq(serialized_agent, expected_serialized_agent)
