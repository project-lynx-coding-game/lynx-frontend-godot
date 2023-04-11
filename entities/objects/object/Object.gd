extends "res://entities/entity/Entity.gd"

var _position = Vector2()
var _id = int()
var _owner = str()

func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func post_populate():
	self.position = self._position
