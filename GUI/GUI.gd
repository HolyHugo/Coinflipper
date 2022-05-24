extends Control
var wood_counter = 0
var rock_counter = 0

var woodMultiplier = 1
var rockMultiplier = 1

var woodPrice = 10
var rockPrice = 10

var random = RandomNumberGenerator.new()

var rockCoin = load("res://GUI/assets/coinRock/coinrock.png")
var woodCoin = load("res://GUI/assets/coinwood.png")

func _ready():
	updateCounters(wood_counter,"wood")
	updateCounters(rock_counter,"rock")
	random.randomize()
	$ControlCoin/Coin.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateCounters(ressource,type):
	if(type == "wood"):
		$WoodCounter/WoodAmount.text = str(ressource)
		$ControlCoin/FlipCoin.texture_normal = woodCoin
	else:
		$RockCounter/RockAmount.text = str(ressource)
		$ControlCoin/FlipCoin.texture_normal = rockCoin

func _on_FlipCoin_button_up():
	var result = random.randi_range(0,1)
	$ControlCoin/Coin.visible = true
	$ControlCoin/FlipCoin.visible = false
	$ControlCoin/Coin/CoinAnimation.play("Coinflip")
	if(result):
		wood_counter += 1 * woodMultiplier
		waitForAnim()
		updateCounters(wood_counter,"wood")
	else:
		rock_counter += 1 * rockMultiplier
		waitForAnim()
		updateCounters(rock_counter,"rock")

func waitForAnim():
	yield($ControlCoin/Coin/CoinAnimation,"animation_finished")
	$ControlCoin/Coin.visible = false
	$ControlCoin/FlipCoin.visible = true	

func _on_WoodButton_button_up():
	if(wood_counter >= woodPrice):
		wood_counter -= woodPrice
		woodMultiplier += 0.2 
		woodPrice = stepify((woodPrice * 1.15),0.001)
		updateCounters(wood_counter,"wood")
		updatePrices(woodPrice,"wood")
		

func _on_RockButton_button_up():
	if(rock_counter >= rockPrice):
		rock_counter -= rockPrice
		rockMultiplier += 0.2 
		rockPrice = stepify((rockPrice * 1.15),0.001)
		updateCounters(rock_counter,"rock")
		updatePrices(rockPrice,"rock")

func updatePrices(price,type):
	if(type == "wood"):
		$WoodUpgradeBox/WoodPrice.text = str(price)
	else:
		$RockUpgradeBox/RockPrice.text = str(price)
		
