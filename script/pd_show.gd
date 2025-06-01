extends Label

func _process(_delta):
	text = "%d" % RefractorState.pd_mm
