extends Node2D

var poortjes = "dicht"
var icon1 =	preload("res://Media/Draaischakelaar.png")
var icon2 = preload("res://Media/Draaischakelaar2.png")
var groenl = preload("res://Media/GroenVerlicht.png")
var groen = preload("res://Media/Groen.png")
var t1 = 0
var _golaad1 = true
var _gouitlaad1 = true
var _loadbeugels = false
var _poortjes = true
var _station = true
var _uitstation = true
var _unloadbeugels = false
var laadtrein = 5
var uitlaadtrein = 1

signal stationvrijgeven
signal uitstationvrijgeven

func _on_SetupTimer_timeout():
	pass

func _on_LoadVrijgeven1_button_down():
	print("LoadVrijgeven1")
	$Map/LoadVrijgeven2.texture_normal = groenl
	_vrijgeven()

func _on_LoadVrijgeven2_button_down():
	print("LoadVrijgeven2")
	$Map/LoadVrijgeven1.texture_normal = groenl
	_vrijgeven()

func _on_LoadVrijgeven1_button_up():
	print("LoadVrijgeven1")
	$Map/LoadVrijgeven2.texture_normal = groen

func _on_LoadVrijgeven2_button_up():
	print("LoadVrijgeven2")
	$Map/LoadVrijgeven1.texture_normal = groen


func _on_LoadBeugels_pressed():
	_loadbeugels = true
	print("beugels")
	if (laadtrein == 1):
		$Path2D/T1V1/Voertuig.frame = 1
		$Path2D/T1V2/Voertuig.frame = 1
		$Path2D/T1V3/Voertuig.frame = 1
		$Path2D/T1V4/Voertuig.frame = 1
	if (laadtrein == 2):
		$Path2D/T2V1/Voertuig.frame = 1
		$Path2D/T2V2/Voertuig.frame = 1
		$Path2D/T2V3/Voertuig.frame = 1
		$Path2D/T2V4/Voertuig.frame = 1
	if (laadtrein == 3):
		$Path2D/T3V1/Voertuig.frame = 1
		$Path2D/T3V2/Voertuig.frame = 1
		$Path2D/T3V3/Voertuig.frame = 1
		$Path2D/T3V4/Voertuig.frame = 1
	if (laadtrein == 4):
		$Path2D/T4V1/Voertuig.frame = 1
		$Path2D/T4V2/Voertuig.frame = 1
		$Path2D/T4V3/Voertuig.frame = 1
		$Path2D/T4V4/Voertuig.frame = 1
	if (laadtrein == 5):
		$Path2D/T5V1/Voertuig.frame = 1
		$Path2D/T5V2/Voertuig.frame = 1
		$Path2D/T5V3/Voertuig.frame = 1
		$Path2D/T5V4/Voertuig.frame = 1

func _on_LoadPoortjes_pressed():
	if poortjes == "dicht":
		print("LoadPoortjesOpen")
		$Map/LoadPoortjes.texture_normal = icon2
		poortjes = "open"
		yield($DelayTimer, "timeout")
		_poortjes = false
		
	if poortjes == "open":
		print("LoadPoortjesDicht")
		poortjes = "dicht"
		$Map/LoadPoortjes.texture_normal = icon1
		yield($DelayTimer, "timeout")
		_poortjes = true


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
	_unloadbeugels = true
	if (uitlaadtrein == 1):
		$Path2D/T1V1/Voertuig.frame = 0
		$Path2D/T1V2/Voertuig.frame = 0
		$Path2D/T1V3/Voertuig.frame = 0
		$Path2D/T1V4/Voertuig.frame = 0
	if (uitlaadtrein == 2):
		$Path2D/T2V1/Voertuig.frame = 0
		$Path2D/T2V2/Voertuig.frame = 0
		$Path2D/T2V3/Voertuig.frame = 0
		$Path2D/T2V4/Voertuig.frame = 0
	if (uitlaadtrein == 3):
		$Path2D/T3V1/Voertuig.frame = 0
		$Path2D/T3V2/Voertuig.frame = 0
		$Path2D/T3V3/Voertuig.frame = 0
		$Path2D/T3V4/Voertuig.frame = 0
	if (uitlaadtrein == 4):
		$Path2D/T4V1/Voertuig.frame = 0
		$Path2D/T4V2/Voertuig.frame = 0
		$Path2D/T4V3/Voertuig.frame = 0
		$Path2D/T4V4/Voertuig.frame = 0
	if (uitlaadtrein == 5):
		$Path2D/T5V1/Voertuig.frame = 0
		$Path2D/T5V2/Voertuig.frame = 0
		$Path2D/T5V3/Voertuig.frame = 0
		$Path2D/T5V4/Voertuig.frame = 0

func _on_UnloadVrijgeven1_button_down():
	print("LoadVrijgeven1")
	$Map/UnloadVrijgeven2.texture_normal = groenl
	_unloadvrijgeven()

func _on_UnloadVrijgeven2_button_down():
	print("LoadVrijgeven2")
	$Map/UnloadVrijgeven1.texture_normal = groenl
	_unloadvrijgeven()

func _on_UnloadVrijgeven1_button_up():
	print("LoadVrijgeven1")
	$Map/UnloadVrijgeven2.texture_normal = groen

func _on_UnloadVrijgeven2_button_up():
	print("LoadVrijgeven2")
	$Map/UnloadVrijgeven1.texture_normal = groen

func _vrijgeven():
	if ((_loadbeugels == true) && (_poortjes == true)):
		emit_signal("stationvrijgeven")
		_loadbeugels = false
		laadtrein =+ 1
		if (laadtrein == 6):
			laadtrein = 1
func _unloadvrijgeven():
	if _unloadbeugels:
		emit_signal("uitstationvrijgeven")
		_unloadbeugels = false
		uitlaadtrein =+ 1
		if (uitlaadtrein == 6):
			uitlaadtrein = 1
