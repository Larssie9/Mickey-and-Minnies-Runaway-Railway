extends Node2D

var poortjes = "dicht"
var icon1 =	preload("res://Media/Draaischakelaar.png")
var icon2 = preload("res://Media/Draaischakelaar2.png")
var groenl = preload("res://Media/GroenVerlicht.png")
var groen = preload("res://Media/Groen.png")
var blauw = preload("res://Media/Blauw.png")
var blauwl = preload("res://Media/BlauwVerlicht.png")
var _golaad1 = true
var _gouitlaad1 = true
var _loadbeugels = false
var _poortjes = true
var _station = true
var _uitstation = false
var _unloadbeugels = false
var laadtrein = 5
var uitlaadtrein = 1

signal stationvrijgeven
signal uitstationvrijgeven

func _on_aankomstlaad():
	_station = true
	$Map/LoadBeugels.disabled = false
	$Map/LoadVrijgeven1.disabled = false
	$Map/LoadVrijgeven2.disabled = false
	while (_loadbeugels == false):
		$Map/LoadBeugels.texture_normal = blauwl
		$DelayTimer2.start(0.5)
		yield($DelayTimer2,"timeout")
		$Map/LoadBeugels.texture_normal = blauw
		$DelayTimer2.start(0.5)
		yield($DelayTimer2,"timeout")
	while (_loadbeugels == true):
			$Map/LoadVrijgeven1.texture_normal = groenl
			$Map/LoadVrijgeven2.texture_normal = groenl
			$DelayTimer3.start(0.5)
			yield($DelayTimer3,"timeout")
			$Map/LoadVrijgeven1.texture_normal = groen
			$Map/LoadVrijgeven2.texture_normal = groen
			$DelayTimer3.start(0.5)
			yield($DelayTimer3,"timeout")

func _on_vertreklaad():
	_station = false
	$Map/LoadBeugels.disabled = true
	$Map/LoadVrijgeven1.disabled = true
	$Map/LoadVrijgeven2.disabled = true
	$Map/LoadVrijgeven1.texture_normal = groenl
	$Map/LoadVrijgeven2.texture_normal = groenl
	$DelayTimer4.start(4)
	yield($DelayTimer4, "timeout")
	$Map/LoadVrijgeven1.texture_normal = groen
	$Map/LoadVrijgeven2.texture_normal = groen

func _on_aankomstuitlaad():
	_uitstation = true
	$Map/UnloadBeugels.disabled = false
	$Map/UnloadVrijgeven1.disabled = false
	$Map/UnloadVrijgeven2.disabled = false
	while (_unloadbeugels == false):
		$Map/UnloadBeugels.texture_normal = blauwl
		$DelayTimer2.start(0.5)
		yield($DelayTimer2, "timeout")
		$Map/UnloadBeugels.texture_normal = blauw
		$DelayTimer2.start(0.5)
		yield($DelayTimer2, "timeout")
	while ((_unloadbeugels == true) && (_station == false)):
			$Map/UnloadVrijgeven1.texture_normal = groenl
			$Map/UnloadVrijgeven2.texture_normal = groenl
			$DelayTimer3.start(0.5)
			yield($DelayTimer3,"timeout")
			$Map/UnloadVrijgeven1.texture_normal = groen
			$Map/UnloadVrijgeven2.texture_normal = groen
			$DelayTimer3.start(0.5)
			yield($DelayTimer3,"timeout")

func _on_vertrekuitlaad():
	_uitstation = false
	$Map/UnloadBeugels.disabled = true
	$Map/UnloadVrijgeven1.disabled = true
	$Map/UnloadVrijgeven2.disabled = true
	$Map/UnloadVrijgeven1.texture_normal = groenl
	$Map/UnloadVrijgeven2.texture_normal = groenl
	$DelayTimer4.start(4)
	yield($DelayTimer4, "timeout")
	$Map/UnloadVrijgeven1.texture_normal = groen
	$Map/UnloadVrijgeven2.texture_normal = groen

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
	if (_station):
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
	if (_station):
		if poortjes == "dicht":
			print("LoadPoortjesOpen")
			$Map/LoadPoortjes.texture_normal = icon2
			poortjes = "open"
			_poortjes = false
			yield($DelayTimer, "timeout")
		if poortjes == "open":
			print("LoadPoortjesDicht")
			poortjes = "dicht"
			$Map/LoadPoortjes.texture_normal = icon1
			_poortjes = true
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
	if (_uitstation):
		$Map/UnloadBeugels.texture_normal = blauw
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
		_station = false
		laadtrein =+ 1
		if (laadtrein == 6):
			laadtrein = 1
func _unloadvrijgeven():
	if (_unloadbeugels && (_station == false)):
		emit_signal("uitstationvrijgeven")
		_unloadbeugels = false
		_uitstation = false
		uitlaadtrein =+ 1
		if (uitlaadtrein == 6):
			uitlaadtrein = 1
