extends Control

var resourceCounter = 0
var resourceMultiplier = 1
var resourcePrice = 10
export var resourceLabel : String
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func initialization():
	$ResourceCounter/Resource.text = resourceLabel
	
# Called when the node enters the scene tree for the first time.
func _ready():
	initialization()
	updateCounters()

func updateCounters():
	$ResourceCounter/ResourceAmount.text = str(resourceCounter)

func counterUp():
	resourceCounter += 1 * resourceMultiplier

func updatePrices(price):
	$ResourceUpgradeBox/ResourcePrice.text = str(price)

func updateBonus(bonus):
	$ResourceBonusBox/ResourceBonus.text = str(bonus)

func _on_ResourceButton_button_up():
	if(resourceCounter >= resourcePrice):
		resourceCounter -= resourcePrice
		resourceMultiplier += 0.2 
		resourcePrice = stepify((resourcePrice * 1.15),0.001)
		updateCounters()
		updatePrices(resourcePrice)
		updateBonus(resourceMultiplier)
