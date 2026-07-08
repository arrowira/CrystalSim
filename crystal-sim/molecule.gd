extends Node2D

var nearbyMolecules = []
var underInfluence = false

func distance(vecA, vecB):
	return sqrt(pow(vecB.x-vecA.x,2)+pow(vecB.y-vecA.y,2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if len(nearbyMolecules)!=0:
		underInfluence = true
		
		var rotAdd = 0
		for molecule in nearbyMolecules:
			var negToPos = distance(getNegative(),molecule.getPositive())
			var posToNeg = distance(getPositive(),molecule.getNegative())
			var amt = 1/(100*(negToPos-posToNeg)+0.0001)
			amt *= 1/((negToPos+posToNeg)+0.0001)
			rotAdd += amt
		print(rotAdd)
		rotate(rotAdd/100.0)
	else:
		underInfluence = false
	
func getNegative():
	return $negative.global_position
func getPositive():
	return $positive.global_position

func _on_mol_area_area_entered(area: Area2D) -> void:
	if area.name == "molArea":
		nearbyMolecules.append(area.get_parent())



func _on_mol_area_area_exited(area: Area2D) -> void:
	if area.name == "molArea":
		for i in range(len(nearbyMolecules)-1):
			if area.get_parent() == nearbyMolecules[i]:
				nearbyMolecules.remove_at(i)
				break
				
