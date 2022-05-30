extends Control

var random = RandomNumberGenerator.new()

var rockCoin = load("res://GUI/assets/coinRock/coinrock.png")
var woodCoin = load("res://GUI/assets/coinwood.png")


func _ready():
	random.randomize()
	$ControlCoin/Coin.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(($WoodControl.resourceCounter >= 30 and $RockControl.resourceCounter >= 30)
	&& $FaithControl.visible == false):
		$FaithControl.visible = true
		$FaithTimer.start()
		
func _on_FlipCoin_button_up():
	var result = random.randi_range(0,1)
	$ControlCoin/Coin.visible = true
	$ControlCoin/FlipCoin.visible = false
	$ControlCoin/Coin/CoinAnimation.play("Coinflip")
	if(result):
		flipConsequence("Wood",woodCoin)
	else:
		flipConsequence("Rock",rockCoin)

func flipConsequence(node : String,newCoin):
	var controlNode = get_node(node+"Control")
	controlNode.counterUp()
	waitForAnim(newCoin)
	controlNode.updateCounters()
	

func waitForAnim(newCoin):
	yield($ControlCoin/Coin/CoinAnimation,"animation_finished")
	$ControlCoin/Coin.visible = false
	$ControlCoin/FlipCoin.visible = true
	$ControlCoin/FlipCoin.texture_normal = newCoin


func _on_FaithTimer_timeout():
	$FaithControl.counterUp()
	$FaithControl.updateCounters()
