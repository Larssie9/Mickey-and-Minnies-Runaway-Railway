extends Node2D

var poortjes = "dicht"
var icon1 =	preload("res://Media/Draaischakelaar.png")
var icon2 = preload("res://Media/Draaischakelaar2.png")
var groenl = preload("res://Media/GroenVerlicht.png")
var groen = preload("res://Media/Groen.png")
var t1 = 0
var _golaad1 = true
var _gouitlaad1 = true
var offset1 = 0
var _loadbeugels = false
var _poortjes = true
var _station = true
var _uitstation = false
var _unloadbeugels = false

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
	_unloadbeugels = true
	$Path2D/T1V1/V1.frame = 0
	$Path2D/T1V2/V2.frame = 0
	$Path2D/T1V3/V3.frame = 0
	$Path2D/T1V4/V4.frame = 0
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

func _process(delta):
	if _golaad1 &&  _gouitlaad1:
		t1 += delta
		offset1 = t1 * 50
		if offset1 >= 3710:
			t1 = 0
	$Path2D/T1V1.offset = offset1
	$Path2D/T1V2.offset = offset1 + 45
	$Path2D/T1V3.offset = offset1 + 90
	$Path2D/T1V4.offset = offset1 + 135
	$Path2D/T1VL.offset = offset1 + 180
	if (((offset1 >= 72)&&(offset1 <= 82))&&_station):
		_loadbeugels = false
		_station = false
		_golaad1 = false
	if ((offset1 >= 92)&&(offset1 <= 102)):
		_station = true
	if (((offset1 >= 3000)&&(offset1 <= 3010))&&_station):
		_unloadbeugels = false
		_uitstation = false
		_gouitlaad1 = false
	if ((offset1 >= 3020)&&(offset1 <= 3030)):
		_uitstation = true

func _vrijgeven():
	if (_loadbeugels && _poortjes):
		_golaad1 = true

func _unloadvrijgeven():
	if _unloadbeugels:
		_gouitlaad1 = true
	
