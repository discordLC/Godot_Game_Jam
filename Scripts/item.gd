extends Area2D

@onready var main = get_node("/root/Main")
@onready var life_label = get_node("/root/Main/HUD/Panel/LifeLabel")

var item_type : int # 0: Coffee 1: Health 2: Gun

var speed_box = preload("res://Sprites/Items/Yam.png")
var life_box = preload("res://Sprites/Items/Dog.png")
var gun_box = preload("res://Sprites/Items/Gun.png")
var textures = [speed_box, life_box, gun_box]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = textures[item_type]


func _on_body_entered(body):
	# Speed
	if item_type == 0:
		body.boost()
	# Lives
	elif item_type == 1:
		main.lives += 1
		life_label.text = "X " + str(main.lives)
	# Gun
	elif item_type == 2:
		body.quick_fire()
	# Delete Item
	queue_free()
