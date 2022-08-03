extends ColorRect

var nCards = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var nCards = get_child_count()
	var spaces = nCards -1
	var correction = get_children()[0].rect_size.x/2
	var k = (rect_size.x / spaces)
	var s = 0
	print(correction)
	
	for i in (get_children()):
		i.rect_position = Vector2(s - correction,100)
		var relativePosition = (s - rect_size.x/2) / (rect_size.x/2)
		print("relativo" + str(relativePosition))
		i.rect_rotation = relativePosition * 10
		s += k
		print(s)
		
	
	print(rect_size.x)
	# pegar a posição atual de um filhinho
	print(get_children()[0].get_global_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
