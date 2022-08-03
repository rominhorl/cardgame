extends ColorRect

var nCards
var contas = 2
#onready var valorAngulo = get_node("../Angulo").valorAngulo
# Called when the node enters the scene tree for the first time.
func _process(delta):
	#print(valorAngulo)
	var nCards = get_child_count()
	var spaces = nCards -1
	var correction = get_children()[0].rect_size.x/2
	var k = (rect_size.x / spaces)
	var s = 0
	print(correction)
	
	for i in (get_children()):
		var relativePosition = (s - rect_size.x/2) / (rect_size.x/2)
		i.rect_rotation = relativePosition * 30
		i.rect_position = Vector2(s - correction,50 + 30 * abs(pow(relativePosition,2)))
		s += k
		
	
	# pegar a posição atual de um filhinho
	print(get_children()[0].get_global_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
