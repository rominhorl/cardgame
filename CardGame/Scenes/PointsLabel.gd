extends Label

var PointAmazonia = 0
var PointCaatinga = 0
var PointAtlantica = 0
var PointPantanal = 0
var Points = 0

func _process(delta):
	Points = PointAmazonia + PointCaatinga + PointAtlantica + PointPantanal
	text = str(Points)


func _ready():
	pass # Replace with function body.



func getPointsAmazonia(points):
	 PointAmazonia = points

func getPointsCaatinga(points):
	 PointCaatinga = points
	
func getPointsAtlantica(points):
	 PointAtlantica = points
	
func getPointsPantanal(points):
	 PointPantanal = points
