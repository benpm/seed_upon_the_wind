extends Node2D

@onready var tile_map = $TileMap

enum BGTile {
	dirt = 000,
	dry_dirt,
	grass,
	cracked_dirt,
	dense_grass
}

enum FGTile {
	log = 100,
	flowers,
	rock
}

var tile_coords := {
	BGTile.dirt: Vector2i(3, 0),
	BGTile.dry_dirt: Vector2i(9, 0),
	BGTile.grass: Vector2i(5, 2),
	BGTile.cracked_dirt: Vector2i(7, 1),
	BGTile.dense_grass: Vector2i(10, 2),
	FGTile.log: Vector2i(6, 4),
	FGTile.flowers: Vector2i(2, 4),
	FGTile.rock: Vector2i(1, 6),
}

func set_bg_tile(x: int, y: int, tile_type: BGTile):
	tile_map.set_cell(0, Vector2i(x, y), 0, tile_coords[tile_type])

func set_fg_tile(x: int, y: int, tile_type: FGTile):
	tile_map.set_cell(1, Vector2i(x, y), 0, tile_coords[tile_type])

func _ready():
	for x in range(-100, 100):
		for y in range(0, 100):
			set_bg_tile(x, y, BGTile.dirt)
		for y in range(-100, 0):
			set_bg_tile(x, y, BGTile.grass)
