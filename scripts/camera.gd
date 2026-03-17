extends Camera2D

@export var decay := 0.8
@export var max_offset := Vector2(100,75)
@export var max_roll := 0.0
@export var noise : FastNoiseLite

# Zoom settings
@export var zoom_speed := 0.1
@export var min_zoom := 0.5
@export var max_zoom := 3.0

var noise_y = 0
var trauma := 0.0
var trauma_pwr := 3

func _ready():
	randomize()
#	noise.seed = randi()

func add_trauma(amount: float = 0.6):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma > 0:
		trauma = max(trauma - decay * delta, 0)
		shake()
	else:
		# smoothly return camera to normal
		offset.x = lerp(offset.x, 0.0, 0.2)
		offset.y = lerp(offset.y, 0.0, 0.2)
		rotation = lerp(rotation, 0.0, 0.2)

func shake():
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	
	rotation = max_roll * amt * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amt * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(noise.seed*3, noise_y)

func _unhandled_key_input(event):
	if event.is_action("ui_text_backspace"):
		add_trauma(0.6)

func _unhandled_input(event):
	# Scroll up = zoom in
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += Vector2(zoom_speed, zoom_speed)

		# Clamp zoom
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
