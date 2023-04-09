extends Node2D

@export var attributes = {
	"position": {"x": int(), "y": int()},
	"id": randi(),
	"owner": str()
}

func construct():
	self.position = Vector2(attributes["position"]["x"] * 100, attributes["position"]["y"] * 100)
