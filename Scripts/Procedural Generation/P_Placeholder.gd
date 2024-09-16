extends Node2D

func generate_noise_texture(size: Vector2i, scale: float) -> ImageTexture:
	var img = Image.new()
	img.create(128,128,false,Image.FORMAT_RGBA8) # Grayscale format for noise
	await get_tree().create_timer(5.0).timeout
	var noise = FastNoiseLite.new()
	noise.seed = int(randf() * 1000000)

	for y in range(size.y):
		for x in range(size.x):
			var noise_value = noise.get_noise_2d(x / scale, y / scale)
			# Normalize noise from [-1, 1] to [0, 1]
			noise_value = (noise_value + 1.0) * 0.5
			img.set_pixel(x, y, Color(noise_value, noise_value, noise_value))

	img.generate_mipmaps()
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	return texture

var image : Sprite2D

func _ready() -> void:
	image = $P
	var v = Vector2i(2,2)
	image.texture =await generate_noise_texture(v, 1)
