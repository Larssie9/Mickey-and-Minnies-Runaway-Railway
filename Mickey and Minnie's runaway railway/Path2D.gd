extends Path2D
var _go = true
var t = 0
var offset1 = 0
var _station = true
var _uitstation = true

signal vertreklaad
signal vertrekuitlaad

func _process(delta):
	if _go:
		t += delta
		offset1 = t * 50 + 2000
		if offset1 >= 3731.89:
			t = 0
	$T1V1.offset = offset1
	$T1V2.offset = offset1 + 45
	$T1V3.offset = offset1 + 90
	$T1V4.offset = offset1 + 135
	$T1VL.offset = offset1 + 180
	if (((offset1 >= 72)&&(offset1 <= 82))&&_station):
		_station = false
		_go = false
	if ((offset1 >= 92)&&(offset1 <= 102)):
		_station = true
		emit_signal("vertreklaad")
	if (((offset1 >= 3350)&&(offset1 <= 3360))&&_uitstation):
		_uitstation = false
		_go = false
		emit_signal("vertrekuitlaad")
	if ((offset1 >= 3370)&&(offset1 <= 3380)):
		_uitstation = true
