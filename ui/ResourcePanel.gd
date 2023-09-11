extends Control

func update_points(points_updated: Dictionary):
	for resource_name in points_updated:
		var points = points_updated[resource_name]
		var resource_node_path = "ResourcesContainer/%s/ItemCount" % resource_name
		var resource = get_node(resource_node_path)
		var current_resource_points = int(resource.text)
		var updated_points = current_resource_points + points
		resource.text = str(updated_points)
	
