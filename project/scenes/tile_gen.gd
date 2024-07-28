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

var brush_radius := 1

func set_bg_tile(x: int, y: int, tile_type: BGTile):
	tile_map.set_cell(0, Vector2i(x, y), 0, tile_coords[tile_type])

func set_fg_tile(x: int, y: int, tile_type: FGTile):
	tile_map.set_cell(1, Vector2i(x, y), 0, tile_coords[tile_type])

func generate_tiles():
	for x in range(-100, 100):
		for y in range(0, 100):
			set_bg_tile(x, y, BGTile.dirt)
		for y in range(-100, 0):
			set_bg_tile(x, y, BGTile.grass)

func _ready():
	generate_tiles()

func _process(_delta):
	# Set tile to cracked dirt where clicked
	if Input.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var tile_pos = tile_map.local_to_map(to_local(mouse_pos))
		for x in range(-brush_radius, brush_radius):
			for y in range(-brush_radius, brush_radius):
				if Vector2i(x, y).length() <= brush_radius - 2:
					set_fg_tile(tile_pos.x + x, tile_pos.y + y, FGTile.flowers)
				if Vector2i(x, y).length() <= brush_radius - 1:
					set_bg_tile(tile_pos.x + x, tile_pos.y + y, BGTile.grass)

func set_brush_radius(radius: float):
	brush_radius = clamp(int(radius), 1, 100)