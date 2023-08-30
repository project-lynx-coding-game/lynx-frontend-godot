extends Node

var TILE_SIZE: Vector2i
var SERVER_ADDRESS: String = "http://127.0.0.1:8555/" # localhost by default, to be changed later
var WORLD_UPDATER: Node
var ACTION_SPEED_MULTIPLIER: int
var OBJECTS_IN_CREATION: Array[int] = []
var BUSY_HTTP_STATUSES: Array[int] = [HTTPClient.STATUS_CONNECTING, HTTPClient.STATUS_REQUESTING]
var USER_ID: String = str(RandomNumberGenerator.new().randi())
