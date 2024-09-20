extends Node2D

func generate_noise_texture(size: Vector2i, scale: float) -> ImageTexture:
	var img = Image.create(256,256,false,Image.FORMAT_RGBA8) # Grayscale format for noise
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
var shader_material : ShaderMaterial
var screen


func _ready() -> void:
	image = $P
	var v = Vector2i(2,2)
	screen = get_viewport_rect().size
	var noise_texture =generate_noise_texture(v, 10)
	#image.texture = noise_texture
	shader_material = $P.material as ShaderMaterial
	#shader_material.set_shader_parameter("noise_texture", noise_texture)
	#99shader_material.set_shader_parameter("planet_center", Vector2(screen.x/2,screen.y/2))
	shader_material.set_shader_parameter("planet_radius", 71)
	
	print("Noise Texture: ", shader_material.get_shader_parameter("noise_texture"), "  ", image.texture)
