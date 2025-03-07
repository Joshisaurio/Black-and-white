extends CanvasLayer

var level_time : float = 0
@onready var time_display : Label = $PanelContainer/MarginContainer/Right/time_display

var minutes : int = 0
var seconds : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	level_time += delta
	
	
	minutes = floor(level_time/60)
	seconds = (level_time - (minutes * 60))
	
	var visualminutes : String = "0" + str(minutes) if len(str(minutes)) == 1 else str(minutes)
	var visualseconds : String = "0" + str(seconds) if len(str(seconds)) == 1 else str(seconds)
	
	print("Time:")
	print(level_time)
	print("Seconds:")
	print(level_time - (minutes * 60))
	
	time_display.text = str(visualminutes) + ":" + str(visualseconds)
	
	#time_display.text = str(snapped(level_time, 0.1))
