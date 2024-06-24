extends Node2D

@onready var main = get_node("/root/Main")

signal hit_p

var zombie_scene := preload("res://Scenes/zombie.tscn")
var spawn_points := []


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout():
	# Check How Many Enemies Have Already Been Created
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < get_parent().max_enemies:
		# Pick Randon Spawn Point
		var spawn = spawn_points[randi() % spawn_points.size()]
		
		# Spawn Enemy
		var zombie = zombie_scene.instantiate()
		zombie.position = spawn.position
		zombie.hit_player.connect(hit)
		main.add_child(zombie)
		zombie.add_to_group("enemies")


func hit():
	hit_p.emit()
