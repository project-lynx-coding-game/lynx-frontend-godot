extends LynxAction

var _user_name = String()
var _points_updated = Dictionary()
@onready var _resources_panel = get_node("/root/Scene/CanvasLayer/UI/ResourcesPanel")

func _init():
	self.accepted_attributes = ["user_name", "points_updated"]

func _execute():
	_resources_panel.update_points( self._points_updated)

