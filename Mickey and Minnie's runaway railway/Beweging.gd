extends Node2D
var t = 0
var offset = 0
var _station = true
var _uitstation = true
var _go = true

signal vertreklaad
signal vertrekuitlaad

func _process(delta):
	if _go:
		t += delta
		offset = t * 50 + 2000
		if offset >= 3731.89:
			t = 0
	$V1.offset = offset
	$V2.offset = offset + 45
	$V3.offset = offset + 90
	$V4.offset = offset + 135
	$VL.offset = offset + 180
	if (((offset >= 72)&&(offset <= 82))&&_station):
		_station = false
	if ((offset >= 92)&&(offset <= 102)):
		_station = true
		emit_signal("vertreklaad")
	if (((offset >= 3350)&&(offset <= 3360))&&_uitstation):
		_uitstation = false
		emit_signal("vertrekuitlaad")
	if ((offset >= 3370)&&(offset <= 3380)):
		_uitstation = true
