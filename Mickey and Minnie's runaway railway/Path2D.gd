extends Path2D
var _go1 = true
var _go2 = true
var t1 = 0
var t2 = 0
var offset1 = 0
var offset2 = 0
var offset3 = 3731.89
var _station1 = true
var _station2 = true
var _uitstation1 = true
var _uitstation2 = true
var _uitstationvrijgeven = false
var _stationvrijgeven = false

signal vertreklaad
signal vertrekuitlaad

func _on_Main_uitstationvrijgeven():
	_uitstationvrijgeven = true

func _on_Main_stationvrijgeven():
	_stationvrijgeven = true

func _process(delta):
	## Trein 1
	if _go1:
		t1 += delta
		offset1 = t1 * 50 + 1000
		if offset1 >= 3731.89 + 1000:
			t1 = 0
	$T1V1.offset = offset1
	$T1V2.offset = offset1 + 45
	$T1V3.offset = offset1 + 90
	$T1V4.offset = offset1 + 135
	$T1VL.offset = offset1 + 180
	if ((_uitstation1 == true) && (_station1 == true)):
		if (offset1 > (offset3 - 250)):
			_go1 = false
		else:
			_go1 = true
	if (((offset1 >= 72)&&(offset1 <= 82))&&_station1):
		_station1 = false
		_go1 = false
	if ((offset1 >= 92)&&(offset1 <= 102)):
		_station1 = true
		emit_signal("vertreklaad")
	if ((_station1 == false) && (_stationvrijgeven == true)):
		_go1 = true
		_stationvrijgeven = false
	if (((offset1 >= 3350)&&(offset1 <= 3360))&&_uitstation1):
		_uitstation1 = false
		_go1 = false
		emit_signal("vertrekuitlaad")
	if ((_uitstation1 == false) && (_uitstationvrijgeven == true)):
		_go1 = true
		_uitstationvrijgeven = false
	if ((offset1 >= 3370)&&(offset1 <= 3380)):
		_uitstation1 = true
	## Trein 2
	if _go2:
		t2 += delta
		offset2 = t2 * 50
		if offset2 >= 3731.89:
			t2 = 0
	$T2V1.offset = offset2
	$T2V2.offset = offset2 + 45
	$T2V3.offset = offset2 + 90
	$T2V4.offset = offset2 + 135
	$T2VL.offset = offset2 + 180
	if ((_uitstation2 == true) && (_station2 == true)):
		if (offset2 > (offset1 - 250)):
			_go2 = false
		else:
			_go2 = true
	if (((offset2 >= 72)&&(offset2 <= 82))&&_station2):
		_station2 = false
		_go2 = false
	if ((_station2 == false) && (_stationvrijgeven == true)):
		_go2 = true
		_stationvrijgeven = false
	if ((offset2 >= 92)&&(offset2 <= 102)):
		_station2 = true
		emit_signal("vertreklaad")
	if (((offset2 >= 3350)&&(offset2 <= 3360))&&_uitstation2):
		_uitstation2 = false
		_go2 = false
		emit_signal("vertrekuitlaad")
	if ((_uitstation2 == false) && (_uitstationvrijgeven == true)):
		_go2 = true
		_uitstationvrijgeven = false
	if ((offset2 >= 3370)&&(offset2 <= 3380)):
		_uitstation2 = true
