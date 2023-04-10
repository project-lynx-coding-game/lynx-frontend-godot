extends "res://entities/entity/Entity.gd"

@export var _position = Vector2()
@export var _id = int()
@export var _owner = str()

func _init():
	self.accepted_attributes = ["position", "id", "owner"]

func post_populate():
	self.position = self._position
