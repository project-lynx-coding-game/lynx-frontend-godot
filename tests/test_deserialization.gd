extends 'res://addons/gut/test.gd'

class TestEntityDeserialization:
	extends GutTest
	
	var entity_deserializer

	func before_all():
		var EntityDeserializer = preload("res://scene/world_updater/entity_deserializer.tscn")
		entity_deserializer = EntityDeserializer.instantiate()
		entity_deserializer._ready()

	func test_entity_without_type_returns_null():
		var serialized_entity_without_type = {
			"attributes": {
				"object_id": 123,
				"direction": {
					"x": 0,
					"y":-1
				}
			}
		}
		var deserialized_entity = entity_deserializer.deserialize(serialized_entity_without_type)
		assert_null(deserialized_entity)
		
	func test_entity_without_attributes_returns_null():
		var serialized_entity_without_attributes = {
			"type": "Move"
		}
		var deserialized_entity = entity_deserializer.deserialize(serialized_entity_without_attributes)
		assert_null(deserialized_entity)

class TestTileDeserialization:
	extends GutTest
	
	var entity_deserializer

	func before_all():
		var EntityDeserializer = preload("res://scene/world_updater/entity_deserializer.tscn")
		entity_deserializer = EntityDeserializer.instantiate()
		entity_deserializer._ready()
		
	func test_tile_without_name_returns_null():
		var serialized_tile = {
			"type": "Object",
			"attributes": {
				"position": {
					"x":1,
					"y":2
				},
				"tags": [
					"walkable"
				]
			}
		}
		var deserialized_tile = entity_deserializer.deserialize(serialized_tile)
		assert_null(deserialized_tile)
		
	func test_tile_without_position_returns_null():
		var serialized_tile = {
			"type": "Object",
			"attributes": {
				"name": "Grass",
				"tags": [
					"walkable"
				]
			}
		}
		var deserialized_tile = entity_deserializer.deserialize(serialized_tile)
		assert_null(deserialized_tile)

class TestObjectDeserialization:
	extends GutTest
	
	var entity_deserializer

	func before_all():
		var EntityDeserializer = preload("res://scene/world_updater/entity_deserializer.tscn")
		entity_deserializer = EntityDeserializer.instantiate()
		entity_deserializer._ready()
	
	func test_valid_object_properly_deserializes():
		var serialized_object = {
			"type": "Object",
			"attributes": {
				"id": 123,
				"name": "Agent",
				"position": {
					"x":1,
					"y":2
				},
				"additional_positions": [],
				"state": "",
				"tick": "dummy-code",
				"on_death": "dummy-on-death",
				"owner":"dummy-owner",
				"tags":[]
			}
		}
		var Agent = preload("res://entity/object/agent.tscn")
		var deserialized_object = entity_deserializer.deserialize(serialized_object)
		assert_eq(deserialized_object.get_name(), "Agent")
		assert_eq(deserialized_object._position, Vector2(1, 2))
		assert_eq(deserialized_object._id, 123)
		assert_eq(deserialized_object._owner, "dummy-owner")
	
	func test_object_without_name_returns_null():
		var serialized_object = {
			"type": "Object",
			"attributes": {
				"id": 123,
				"position": {
					"x":1,
					"y":2
				},
				"additional_positions": [],
				"state": "",
				"tick": "dummy-code",
				"on_death": "dummy-on-death",
				"owner":"dummy-owner",
				"tags":[]
			}
		}
		var deserialized_object = entity_deserializer.deserialize(serialized_object)
		assert_null(deserialized_object)
	
	func test_unknown_object_returns_null():
		var serialized_object = {
			"type": "Object",
			"attributes": {
				"id": 123,
				"name": "ThisObjectIsUnknown",
				"position": {
					"x":1,
					"y":2
				},
				"additional_positions": [],
				"state": "",
				"tick": "dummy-code",
				"on_death": "dummy-on-death",
				"owner":"dummy-owner",
				"tags":[]
			}
		}
		var deserialized_object = entity_deserializer.deserialize(serialized_object)
		assert_null(deserialized_object)
	
class TestActionDeserialization:
	extends GutTest
	
	var entity_deserializer

	func before_all():
		var EntityDeserializer = preload("res://scene/world_updater/entity_deserializer.tscn")
		entity_deserializer = EntityDeserializer.instantiate()
		entity_deserializer._ready()
	
	func test_valid_action_properly_deserializes():
		var serialized_action = {
			"type": "Move",
			"attributes": {
				"object_id": 123,
				"direction": {
					"x": 1,
					"y": 2
				}
			}
		}
		var deserialized_action = entity_deserializer.deserialize(serialized_action)
		assert_eq(deserialized_action.get_name(), "Move")
		assert_eq(deserialized_action._object_id, 123)
		assert_eq(deserialized_action._direction, Vector2(1, 2))
	
	func test_unknown_action_returns_null():
		var serialized_action = {
			"type": "ThisActionIsUnknown",
			"attributes": {
				"object_id": 123,
				"position": {
					"x": 1,
					"y": 2
				}
			}
		}
		var deserialized_action = entity_deserializer.deserialize(serialized_action)
		assert_null(deserialized_action)
