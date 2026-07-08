extends Node2D

var nearbyMolecules = []
var underInfluence = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(nearbyMolecules)!=0:
		underInfluence = true
	else:
		underInfluence = false
	


func _on_mol_area_area_entered(area: Area2D) -> void:
	if area.name == "molArea":
		nearbyMolecules.append(area)



func _on_mol_area_area_exited(area: Area2D) -> void:
	if area.name == "molArea":
		for i in range(len(nearbyMolecules)-1):
			if area.get_parent() == nearbyMolecules[i]:
				nearbyMolecules.remove_at(i)
				break
				
