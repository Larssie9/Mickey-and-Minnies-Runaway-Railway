extends Node2D

var poortjes = "dicht"
var icon1 =	preload("res://Media/Draaischakelaar.png")
var icon2 = preload("res://Media/Draaischakelaar2.png")
var groenl = preload("res://Media/GroenVerlicht.png")
var groen = preload("res://Media/Groen.png")
var t1 = 0
var _go1 = true
var offset1 = 0
var _loadbeugels = false
var _poortjes = true
var _station = true

func _on_SetupTimer_timeout():
	pass

func _on_LoadVrijgeven1_button_down():
	print("LoadVrijgeven1")
	$Map/LoadVrijgeven2.texture_normal = groenl

func _on_LoadVrijgeven2_button_down():
	print("LoadVrijgeven2")
	$Map/LoadVrijgeven1.texture_normal = groenl
	if (_loadbeugels && _poortjes):
		_go1 = true

func _on_LoadVrijgeven1_button_up():
	print("LoadVrijgeven1")
	$Map/LoadVrijgeven2.texture_normal = groen

func _on_LoadVrijgeven2_button_up():
	print("LoadVrijgeven2")
	$Map/LoadVrijgeven1.texture_normal = groen


func _on_LoadBeugels_pressed():
	print("LoadBeugels")
	_loadbeugels = true
	$Path2D/T1V1/V1.frame = 1
	$Path2D/T1V2/V2.frame = 1
	$Path2D/T1V3/V3.frame = 1
	$Path2D/T1V4/V4.frame = 1


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


func _on_TextureButton_toggled(button_pressed):
	if button_pressed==true:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()


func _on_InstellingenSpel_pressed():
	$Instellingen.visible=false
	$Path2D.visible=true

func _on_InstellingenShort_pressed():
	$Instellingen/Shortcuts.visible=true


func _on_ShortcutsSluiten_pressed():
	$Instellingen/Shortcuts.visible=false


func _on_Button_pressed():
	$Instellingen.visible=true
	$Path2D.visible=false

func _on_UnloadBeugels_pressed():
	print("LoadBeugels")

func _on_UnloadVrijgeven1_button_down():
	print("LoadVrijgeven1")
	$Map/UnloadVrijgeven2.texture_normal = groenl

func _on_UnloadVrijgeven2_button_down():
	print("LoadVrijgeven2")
	$Map/UnloadVrijgeven1.texture_normal = groenl

func _on_UnloadVrijgeven1_button_up():
	print("LoadVrijgeven1")
	$Map/UnloadVrijgeven2.texture_normal = groen

func _on_UnloadVrijgeven2_button_up():
	print("LoadVrijgeven2")
	$Map/UnloadVrijgeven1.texture_normal = groen

func _process(delta):
	if _go1:
		t1 += delta
		offset1 = t1 * 25
	$Path2D/T1V1.offset = offset1
	$Path2D/T1V2.offset = offset1 + 45
	$Path2D/T1V3.offset = offset1 + 90
	$Path2D/T1V4.offset = offset1 + 135
	$Path2D/T1VL.offset = offset1 + 180
	if (((offset1 >= 15)&&(offset1 <= 35))&&_station):
		_loadbeugels = false
		_station = false
		_go1 = false
	if ((offset1 >= 45)&&(offset1 <= 55)):
		_station = true
