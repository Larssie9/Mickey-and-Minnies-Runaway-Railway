extends Node2D

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
var _throttle = true
var _kanvrijgeven = false
var _kanadvancen = true
var _scoretimer = false
var laadtrein = 6
var uitlaadtrein = 1
var t = 0
var score = 1000
var totalscore = 0
var time = 0
var seconde = 0
var minuut = 0
var uur = 0
var timenow = 0
var timestart = 0
var omgerekenduur = 0
var pph = 0
var vrijgegeventreinen = 0

signal stationvrijgeven
signal uitstationvrijgeven

func _ready():
	timestart = OS.get_unix_time()

func _process(delta):
	if _scoretimer && (score > 0):
		t += delta
		score -= (t / 5)
	if (_scoretimer == false):
		t = 0
		score = 1000
	$Map/Score.text = str(totalscore)
	$Eindscherm/Eindscore.text = str(totalscore)
	timenow = OS.get_unix_time()
	seconde = timenow - timestart - (60 * minuut) - (3600 * uur)
	if (seconde == 60):
		seconde = 0
		minuut += 1
	if (minuut == 60):
		minuut = 0
		uur += 1

func laadknoppen():
	while (((_loadbeugels == false) && (_poortjes == true)) && _station):
		$Map/LoadBeugels.texture_normal = blauwl
		$DelayTimer2.start(0.5)
		yield($DelayTimer2,"timeout")
		$Map/LoadBeugels.texture_normal = blauw
		$DelayTimer2.start(0.5)
		yield($DelayTimer2,"timeout")
		pass
	while (((_loadbeugels == true) && (_poortjes == true)) && _kanvrijgeven):
		$Map/LoadVrijgeven1.texture_normal = groenl
		$Map/LoadVrijgeven2.texture_normal = groenl
		$DelayTimer3.start(0.5)
		yield($DelayTimer3,"timeout")
		$Map/LoadVrijgeven1.texture_normal = groen
		$Map/LoadVrijgeven2.texture_normal = groen
		$DelayTimer3.start(0.5)
		yield($DelayTimer3,"timeout")
		pass
	while (_station && (_kanvrijgeven == false)):
		yield($DelayTimer7, "timeout")
		laadknoppen()
		_kanvrijgeven = true

func uitlaadknoppen():
	while ((_unloadbeugels == false) && _uitstation):
		$Map/UnloadBeugels.texture_normal = blauwl
		$DelayTimer8.start(0.5)
		yield($DelayTimer2, "timeout")
		$Map/UnloadBeugels.texture_normal = blauw
		$DelayTimer8.start(0.5)
		yield($DelayTimer2, "timeout")
		pass
	while ((_unloadbeugels == true) && (_station == false)) && _kanadvancen:
		$Map/UnloadVrijgeven1.texture_normal = groenl
		$Map/UnloadVrijgeven2.texture_normal = groenl
		$DelayTimer3.start(0.5)
		yield($DelayTimer3,"timeout")
		$Map/UnloadVrijgeven1.texture_normal = groen
		$Map/UnloadVrijgeven2.texture_normal = groen
		$DelayTimer3.start(0.5)
		yield($DelayTimer3,"timeout")
		pass
	while (_uitstation && (_kanadvancen == false)):
		yield($DelayTimer9, "timeout")
		uitlaadknoppen()
		_kanadvancen = true

func _on_aankomstlaad():
	_station = true
	$Map/LoadBeugels.disabled = false
	$Map/LoadVrijgeven1.disabled = false
	$Map/LoadVrijgeven2.disabled = false
	_kanvrijgeven = false
	$DelayTimer7.start(10)
	laadknoppen()

func _on_vertreklaad():
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
	$DelayTimer9.start(10)
	_kanadvancen = false
	uitlaadknoppen()

func _on_vertrekuitlaad():
	$Map/UnloadBeugels.disabled = true
	$Map/UnloadVrijgeven1.disabled = true
	$Map/UnloadVrijgeven2.disabled = true
	$Map/UnloadVrijgeven1.texture_normal = groenl
	$Map/UnloadVrijgeven2.texture_normal = groenl
	$DelayTimer6.start(4)
	yield($DelayTimer6, "timeout")
	$Map/UnloadVrijgeven1.texture_normal = groen
	$Map/UnloadVrijgeven2.texture_normal = groen

func _on_LoadVrijgeven1_button_down():
	$Map/LoadVrijgeven2.texture_normal = groenl
	_vrijgeven()

func _on_LoadVrijgeven2_button_down():
	$Map/LoadVrijgeven1.texture_normal = groenl
	_vrijgeven()

func _on_LoadVrijgeven1_button_up():
	$Map/LoadVrijgeven2.texture_normal = groen

func _on_LoadVrijgeven2_button_up():
	$Map/LoadVrijgeven1.texture_normal = groen


func _on_LoadBeugels_pressed():
	if (_station && _poortjes):
		laadknoppen()
		_loadbeugels = true
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
		if (laadtrein == 6):
			$Path2D/T6V1/Voertuig.frame = 1
			$Path2D/T6V2/Voertuig.frame = 1
			$Path2D/T6V3/Voertuig.frame = 1
			$Path2D/T6V4/Voertuig.frame = 1
func _on_LoadPoortjes_pressed():
	if (_station && (_loadbeugels == false)):
		if (_poortjes == true) && _throttle:
			$Map/LoadPoortjes.texture_normal = icon2
			_throttle = false
			_poortjes = false
			delay()
			laadknoppen()
			$Poortjes/Links1.rotation_degrees = -90
			$Poortjes/Links2.rotation_degrees = -90
			$Poortjes/Links3.rotation_degrees = -90
			$Poortjes/Links4.rotation_degrees = -90
			$Poortjes/Rechts1.rotation_degrees = 90
			$Poortjes/Rechts2.rotation_degrees = 90
			$Poortjes/Rechts3.rotation_degrees = 90
			$Poortjes/Rechts4.rotation_degrees = 90
		if (_poortjes == false) && _throttle:
			$Map/LoadPoortjes.texture_normal = icon1
			_poortjes = true
			_throttle = false
			delay()
			laadknoppen()
			$Poortjes/Links1.rotation_degrees = 0
			$Poortjes/Links2.rotation_degrees = 0
			$Poortjes/Links3.rotation_degrees = 0
			$Poortjes/Links4.rotation_degrees = 0
			$Poortjes/Rechts1.rotation_degrees = 0
			$Poortjes/Rechts2.rotation_degrees = 0
			$Poortjes/Rechts3.rotation_degrees = 0
			$Poortjes/Rechts4.rotation_degrees = 0


func _on_TextureButton_toggled(button_pressed):
	if button_pressed==true:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()


func _on_InstellingenSpel_pressed():
	_scoretimer = true
	$Instellingen.visible=false
	$Path2D.visible=true

func _on_InstellingenShort_pressed():
	$Instellingen/Shortcuts.visible=true


func _on_ShortcutsSluiten_pressed():
	$Instellingen/Shortcuts.visible=false


func _on_Button_pressed():
	_scoretimer = false
	$Instellingen.visible=true
	$Path2D.visible=false

func _on_UnloadBeugels_pressed():
	if (_uitstation):
		uitlaadknoppen()
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
		if (uitlaadtrein == 6):
			$Path2D/T6V1/Voertuig.frame = 0
			$Path2D/T6V2/Voertuig.frame = 0
			$Path2D/T6V3/Voertuig.frame = 0
			$Path2D/T6V4/Voertuig.frame = 0

func _on_UnloadVrijgeven1_button_down():
	$Map/UnloadVrijgeven2.texture_normal = groenl
	_unloadvrijgeven()

func _on_UnloadVrijgeven2_button_down():
	$Map/UnloadVrijgeven1.texture_normal = groenl
	_unloadvrijgeven()

func _on_UnloadVrijgeven1_button_up():
	$Map/UnloadVrijgeven2.texture_normal = groen

func _on_UnloadVrijgeven2_button_up():
	$Map/UnloadVrijgeven1.texture_normal = groen

func _vrijgeven():
	if (((_loadbeugels == true) && (_poortjes == true)) && _kanvrijgeven):
		laadknoppen()
		emit_signal("stationvrijgeven")
		totalscore += int(score)
		_scoretimer = false
		_loadbeugels = false
		_station = false
		_kanvrijgeven = false
		laadtrein += 1
		vrijgegeventreinen += 1
		if (laadtrein == 7):
			laadtrein = 1
		uitlaadknoppen()

func _unloadvrijgeven():
	if (_unloadbeugels && (_station == false)) && _kanadvancen:
		uitlaadknoppen()
		emit_signal("uitstationvrijgeven")
		_unloadbeugels = false
		_uitstation = false
		uitlaadtrein += 1
		if (uitlaadtrein == 7):
			uitlaadtrein = 1

func delay():
	$DelayTimer5.start(1)

func _on_DelayTimer5_timeout():
	_throttle = true


func _on_DelayTimer7_timeout():
	if (_scoretimer == false) && (_station == true):
		_scoretimer = true


func _on_poortjesopen_pressed():
	if (_station && (_loadbeugels == false)):
		if (_poortjes == true) && _throttle:
			$Map/LoadPoortjes.texture_normal = icon2
			_throttle = false
			_poortjes = false
			delay()
			laadknoppen()
			$Poortjes/Links1.rotation_degrees = -90
			$Poortjes/Links2.rotation_degrees = -90
			$Poortjes/Links3.rotation_degrees = -90
			$Poortjes/Links4.rotation_degrees = -90
			$Poortjes/Rechts1.rotation_degrees = 90
			$Poortjes/Rechts2.rotation_degrees = 90
			$Poortjes/Rechts3.rotation_degrees = 90
			$Poortjes/Rechts4.rotation_degrees = 90


func _on_poortjesdicht_pressed():
	if (_station && (_loadbeugels == false)):
		print("debug")
		if (_poortjes == false) && _throttle:
			$Map/LoadPoortjes.texture_normal = icon1
			_poortjes = true
			_throttle = false
			delay()
			laadknoppen()
			$Poortjes/Links1.rotation_degrees = 0
			$Poortjes/Links2.rotation_degrees = 0
			$Poortjes/Links3.rotation_degrees = 0
			$Poortjes/Links4.rotation_degrees = 0
			$Poortjes/Rechts1.rotation_degrees = 0
			$Poortjes/Rechts2.rotation_degrees = 0
			$Poortjes/Rechts3.rotation_degrees = 0
			$Poortjes/Rechts4.rotation_degrees = 0


func _on_Indienen_pressed():
	$Eindscherm.visible = true
	$Eindscherm/TijdGespeeld.text = str(uur," u ",minuut," m ",seconde," s")
	time = (timenow - timestart)
	pph = ((vrijgegeventreinen * 24) * ((3600 - time)/time))
	$Eindscherm/TreinenVrijgegeven.text = str(vrijgegeventreinen)
	$Eindscherm/PersonenPerUur.text = str(pph)


func _on_Eindsluiten_pressed():
	$Eindscherm.visible = false


func _on_Vragenlijst_pressed():
	OS.shell_open("https://docs.google.com/forms/d/e/1FAIpQLSc5pWGPvL1oYVuu7ttcji2699_HJZAQJI7ZjRj7BpdjyHeaIg/viewform?usp=sf_link")
