extends Control
export var UpgradeName : String
export var UpgradeCost : int

func initialization():
	$UpgradeColor/UpgradeName.text = UpgradeName
	$UpgradeColor/UpgradeCost.text = str(UpgradeCost)
	
func _ready():
	initialization()

func _on_UpgradeButton_button_up():
	print("hello")
