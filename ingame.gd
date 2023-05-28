extends Node2D

var mapSize = 25
var tileSize = 16
var mapArray = []
@export var wallProbability = 0.3
@export var buffProbability = 0.005

func _ready():
	generateMap()
	generateBlocks()

# Called when the node enters the scene tree for the first time.
func generateMap():
	for x in range(mapSize):
		var row = []
		for y in range(mapSize):
			row.append(0)
		mapArray.append(row)
		#print(mapArray)

func generateBlocks():
	for x in range(mapSize):
		for y in range(mapSize):
			if (x==0 and y==0) or  (x == mapSize - 1 and y ==mapSize - 1):
				continue
			var randVal = randf();
			if randVal < buffProbability:
				mapArray[x][y] = 1
				createBlock("buff", x, y)
			elif randVal < wallProbability:  # Adjust the probability based on your needs
				mapArray[x][y] = 1
				createBlock("wall", x, y)

func createBlock(type, x, y):
	var blockInstance = preload("res://Wall/static_body_2d.tscn").instantiate()
	if type == "buff":
		blockInstance = preload("res://Buff/buff.tscn").instantiate()
	var block = blockInstance as Node2D
	block.position = Vector2(x * tileSize, y * tileSize)
	add_child(block) 
