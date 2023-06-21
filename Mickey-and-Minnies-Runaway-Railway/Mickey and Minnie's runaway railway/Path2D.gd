extends Path2D

var _go1 = true
var _go2 = true
var _go3 = true
var _go4 = true
var _go5 = true
var _go6 = true
var t1 = 130
var t2 = 120
var t3 = 110
var t4 = 100
var t5 = 90
var t6 = 1
var offset1 = 0
var offset2 = 0
var offset3 = 0
var offset4 = 0
var offset5 = 0
var offset6 = 0
var _station1 = true
var _station2 = true
var _station3 = true
var _station4 = true
var _station5 = true
var _station6 = true
var _uitstation1 = true
var _uitstation2 = true
var _uitstation3 = true
var _uitstation4 = true
var _uitstation5 = true
var _uitstation6 = true
var _uitstationvrijgeven = false
var _stationvrijgeven = false

signal vertreklaad
signal vertrekuitlaad
signal aankomstlaad
signal aankomstuitlaad

func _on_Main_uitstationvrijgeven(): ##Verwerkt vrijgave uitlaadstation
	_uitstationvrijgeven = true

func _on_Main_stationvrijgeven(): ##Verwerkt vrijgave laadstation
	_stationvrijgeven = true

func _process(delta):
	## Trein 1
	if _go1: ##Kijkt of hij kan gaan
		t1 += delta
		offset1 = t1 * 25
		if offset1 >= 3731.89: ##Tijd resetten bij einde path
			t1 = 0
	$T1V1.offset = offset1
	$T1V2.offset = offset1 + 45
	$T1V3.offset = offset1 + 90
	$T1V4.offset = offset1 + 135
	$T1VL.offset = offset1 + 180
	if ((_uitstation1 == true) && (_station1 == true)): ##Kijken of hij niet in station zit
		if (offset1 > (offset5 - 250)): ##Kijken of hij een offset van minstens 250 van zijn voorganger af zit
			if (offset1 > (offset5 - 200)): ##Extra check voor bij einde path
				_go1 = true
			else:
				_go1 = false
		else:
			_go1 = true
	#laadstation
	if (((offset1 >= 72)&&(offset1 <= 82)&&_station1)): ##Kijkt of trein in laadstation is
		_station1 = false
		_go1 = false
		emit_signal("aankomstlaad")
	if ((offset1 >= 92)&&(offset1 <= 102)):
		_station1 = true
	if ((_station1 == false) && (_stationvrijgeven == true)): ##Kijkt of trein kan vrijgeven
		_go1 = true
		_stationvrijgeven = false
		emit_signal("vertreklaad")
	#uitlaadstation
	if (((offset1 >= 3350)&&(offset1 <= 3360))&&_uitstation1): ##Kijkt of trein in uitlaadstation is
		_uitstation1 = false
		_go1 = false
		emit_signal("aankomstuitlaad")
	if ((_uitstation1 == false) && (_uitstationvrijgeven == true)): ##Kijkt of trein kan vrijgeven
		_go1 = true
		_uitstationvrijgeven = false
	if ((offset1 >= 3380)&&(offset1 <= 3390)):
		_uitstation1 = true
		emit_signal("vertrekuitlaad")
	## Trein 2
	if _go2:
		t2 += delta
		offset2 = t2 * 25
		if offset2 >= 3731.89:
			t2 = 0
	$T2V1.offset = offset2
	$T2V2.offset = offset2 + 45
	$T2V3.offset = offset2 + 90
	$T2V4.offset = offset2 + 135
	$T2VL.offset = offset2 + 180
	if ((_uitstation2 == true) && (_station2 == true)):
		if (offset2 > (offset1 - 250)):
			if (offset2 > (offset1 - 200)):
				_go2 = true
			else:
				_go2 = false
		else:
			_go2 = true
	#laadstation
	if (((offset2 >= 72)&&(offset2 <= 82))&&_station2):
		_station2 = false
		_go2 = false
		emit_signal("aankomstlaad")
	if ((_station2 == false) && (_stationvrijgeven == true)):
		_go2 = true
		_stationvrijgeven = false
	if ((offset2 >= 92)&&(offset2 <= 102)):
		_station2 = true
		emit_signal("vertreklaad")
	#uitlaadstation
	if (((offset2 >= 3350)&&(offset2 <= 3360))&&_uitstation2):
		_uitstation2 = false
		_go2 = false
		emit_signal("aankomstuitlaad")
	if ((_uitstation2 == false) && (_uitstationvrijgeven == true)):
		_go2 = true
		_uitstationvrijgeven = false
	if ((offset2 >= 3380)&&(offset2 <= 3390)):
		_uitstation2 = true
		emit_signal("vertrekuitlaad")
	##Trein 3
	if _go3:
		t3 += delta
		offset3 = t3 * 25
		if offset3 >= 3731.89:
			t3 = 0
	$T3V1.offset = offset3
	$T3V2.offset = offset3 + 45
	$T3V3.offset = offset3 + 90
	$T3V4.offset = offset3 + 135
	$T3VL.offset = offset3 + 180
	if ((_uitstation3 == true) && (_station3 == true)):
		if (offset3 > (offset2 - 250)):
			if (offset3 > (offset2 - 200)):
				_go3 = true
			else:
				_go3 = false
		else:
			_go3 = true
	#laadstation
	if (((offset3 >= 72)&&(offset3 <= 82))&&_station3):
		_station3 = false
		_go3 = false
		emit_signal("aankomstlaad")
	if ((_station3 == false) && (_stationvrijgeven == true)):
		_go3 = true
		_stationvrijgeven = false
	if ((offset3 >= 92)&&(offset3 <= 102)):
		_station3 = true
		emit_signal("vertreklaad")
	#uitlaadstation
	if (((offset3 >= 3350)&&(offset3 <= 3360))&&_uitstation3):
		_uitstation3 = false
		_go3 = false
		emit_signal("aankomstuitlaad")
	if ((_uitstation3 == false) && (_uitstationvrijgeven == true)):
		_go3 = true
		_uitstationvrijgeven = false
	if ((offset3 >= 3380)&&(offset3 <= 3390)):
		_uitstation3 = true
		emit_signal("vertrekuitlaad")
	##Trein 4
	if _go4:
		t4 += delta
		offset4 = t4 * 25
		if offset4 >= 3731.89:
			t4 = 0
	$T4V1.offset = offset4
	$T4V2.offset = offset4 + 45
	$T4V3.offset = offset4 + 90
	$T4V4.offset = offset4 + 135
	$T4VL.offset = offset4 + 180
	if ((_uitstation4 == true) && (_station4 == true)):
		if (offset4 > (offset3 - 250)):
			if (offset4 > (offset3 - 200)):
				_go4 = true
			else:
				_go4 = false
		else:
			_go4 = true
	#laadstation
	if (((offset4 >= 72)&&(offset4 <= 82))&&_station4):
		_station4 = false
		_go4 = false
		emit_signal("aankomstlaad")
	if ((_station4 == false) && (_stationvrijgeven == true)):
		_go4 = true
		_stationvrijgeven = false
	if ((offset4 >= 92)&&(offset4 <= 102)):
		_station4 = true
		emit_signal("vertreklaad")
	#uitlaadstation
	if (((offset4 >= 3350)&&(offset4 <= 3360))&&_uitstation4):
		_uitstation4 = false
		_go4 = false
		emit_signal("aankomstuitlaad")
	if ((_uitstation4 == false) && (_uitstationvrijgeven == true)):
		_go4 = true
		_uitstationvrijgeven = false
	if ((offset4 >= 3370)&&(offset4 <= 3380)):
		_uitstation4 = true
		emit_signal("vertrekuitlaad")
	##trein 5
	if _go5:
		t5 += delta
		offset5 = t5 * 25
		if offset5 >= 3731.89:
			t5 = 0
	$T5V1.offset = offset5
	$T5V2.offset = offset5 + 45
	$T5V3.offset = offset5 + 90
	$T5V4.offset = offset5 + 135
	$T5VL.offset = offset5 + 180
	if ((_uitstation5 == true) && (_station5 == true)):
		if (offset5 > (offset4 - 250)):
			if (offset5 > (offset4 - 200)):
				_go5 = true
			else:
				_go5 = false
		else:
			_go5 = true
	#laadstation
	if (((offset5 >= 72)&&(offset5 <= 92))&&_station5):
		_station5 = false
		_go5 = false
		emit_signal("aankomstlaad")
	if ((_station5 == false) && (_stationvrijgeven == true)):
		_go5 = true
		_stationvrijgeven = false
	if ((offset5 >= 92)&&(offset5 <= 102)):
		emit_signal("vertreklaad")
		_station5 = true
	#uitlaadstation
	if (((offset5 >= 3350)&&(offset5 <= 3360))&&_uitstation5):
		_uitstation5 = false
		_go5 = false
		emit_signal("aankomstuitlaad")
	if ((_uitstation5 == false) && (_uitstationvrijgeven == true)):
		_go5 = true
		_uitstationvrijgeven = false
	if ((offset5 >= 3370) && (offset5 <= 3380)):
		_uitstation5 = true
		emit_signal("vertrekuitlaad")
	##trein 6
	if _go6:
		t6 += delta
		offset6 = t6 * 25
		if offset6 >= 3731.89:
			t6 = 0
	$T6V1.offset = offset6
	$T6V2.offset = offset6 + 45
	$T6V3.offset = offset6 + 90
	$T6V4.offset = offset6 + 135
	$T6VL.offset = offset6 + 180
	if ((_uitstation6 == true) && (_station6 == true)):
		if (offset6 > (offset5 - 250)):
			if (offset6 > (offset5 - 200)):
				_go6 = true
			else:
				_go6 = false
		else:
			_go6 = true
	#laadstation
	if (((offset6 >= 72)&&(offset6 <= 92))&&_station6):
		_station6 = false
		_go6 = false
		emit_signal("aankomstlaad")
	if ((_station6 == false) && (_stationvrijgeven == true)):
		_go6 = true
		_stationvrijgeven = false
	if ((offset6 >= 92)&&(offset6 <= 102)):
		emit_signal("vertreklaad")
		_station6 = true
	#uitlaadstation
	if (((offset6 >= 3350)&&(offset6 <= 3360))&&_uitstation6):
		_uitstation6 = false
		_go6 = false
		emit_signal("aankomstuitlaad")
	if ((_uitstation6 == false) && (_uitstationvrijgeven == true)):
		_go6 = true
		_uitstationvrijgeven = false
	if ((offset6 >= 3370) && (offset6 <= 3380)):
		_uitstation6 = true
		emit_signal("vertrekuitlaad")
