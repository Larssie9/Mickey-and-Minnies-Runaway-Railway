extends Node2D

var poortjes = "dicht"
var icon1 =	preload("res://Draaischakelaar.png")
var icon2 = preload("res://Draaischakelaar2.png")

func _on_SetupTimer_timeout():
	pass

func _on_LoadVrijgeven1_pressed():
	print("LoadVrijgeven1")

func _on_LoadVrijgeven2_pressed():
	print("LoadVrijgeven2")


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
		
		



