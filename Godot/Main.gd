extends Node2D

var poortjes = "dicht"
var icon1 =	preload("res://Media/Draaischakelaar.png")
var icon2 = preload("res://Media/Draaischakelaar2.png")
var groenl = preload("res://Media/GroenVerlicht.png")
var groen = preload("res://Media/Groen.png")

func _on_SetupTimer_timeout():
	pass

func _on_LoadVrijgeven1_button_down():
	print("LoadVrijgeven1")
	$Map/LoadVrijgeven2.texture_normal = groenl

func _on_LoadVrijgeven2_button_down():
	print("LoadVrijgeven2")
	$Map/LoadVrijgeven1.texture_normal = groenl

func _on_LoadVrijgeven1_button_up():
	print("LoadVrijgeven1")
	$Map/LoadVrijgeven2.texture_normal = groen

func _on_LoadVrijgeven2_button_up():
	print("LoadVrijgeven2")
	$Map/LoadVrijgeven1.texture_normal = groen


func _on_LoadBeugels_pressed():
	print("LoadBeugels")


func _on_LoadPoortjes_pressed():
	if poortjes == "dicht":
		print("LoadPoortjesOpen")
		$Map/LoadPoortjes.texture_normal = icon2
		poortjes = "open"
		yield($DelayTimer, "timeout")
		
	if poortjes == "open":
		print("LoadPoortjesDicht")
		poortjes = "dicht"
		$Map/LoadPoortjes.texture_normal = icon1
		yield($DelayTimer, "timeout")
