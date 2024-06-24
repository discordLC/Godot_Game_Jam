extends CanvasLayer

@onready var start_button = $PlayButton as Button
@onready var start_level = preload("res://Scenes/main.tscn") as PackedScene


func _ready():
	start_button.button_down.connect(_on_play_button_pressed)


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(start_level)
