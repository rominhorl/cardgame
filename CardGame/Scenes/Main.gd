extends Node

func _ready():
	$SlotAreaCaatinga.connect("CountPointsCaatinga", $UI/PointsLabel, 'getPointsCaatinga')
	$SlotAreaAmazonia.connect("CountPointsAmazonia", $UI/PointsLabel, 'getPointsAmazonia')
	$SlotAreaAtlantica.connect("CountPointsAtlantica", $UI/PointsLabel, 'getPointsAtlantica')
	$SlotAreaPantanal.connect("CountPointsPantanal", $UI/PointsLabel, 'getPointsPantanal')
	$UI.connect("TimeToDraw",$"Deck&Hand",'draw_a_card')
