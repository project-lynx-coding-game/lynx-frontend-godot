extends TileMap

var HIGHLIGHT_TILE = Vector2i(0, 0)
var HIGHLIGHT_NO_TILE = Vector2i(-1, -1)

func _process(delta):
	highlight_cell_under_mouse_cursor(self.local_to_map(get_global_mouse_position()))

func highlight_cell_under_mouse_cursor(mouse_position_on_tilemap):
	for cell in self.get_used_cells(0):
		self.set_cell(0, cell, 0, HIGHLIGHT_NO_TILE, 0)
	self.set_cell(0, mouse_position_on_tilemap, 0, HIGHLIGHT_TILE, 0)
