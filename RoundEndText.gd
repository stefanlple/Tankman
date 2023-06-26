extends Label

#@onready var RoundText = get_node("RoundText")
@onready var p1Text = get_node("Player1/Player1Label");
@onready var p2Text = get_node("Player2/Player2Label");

@onready var endtextback =get_node("BackGroundText")

@onready var aniIn = get_node("AnimationPlayer")

@onready var LastM = get_node("ToNext")


func _ready():
	#ShowText("r1","1","0")
	pass


func ShowText(textT,l,r,winp1):
	self.visible = true;
	#VisbleText(true)
	aniIn.play("transition")
	get_node("RoundTexting").set_text(textT)
	p1Text.set_text(l)
	
	if(winp1 == "1"):
		p1Text.self_modulate = Color(255,255,0,255);
		p2Text.self_modulate = Color(255,255,255,255);
	else:
		p2Text.self_modulate = Color(255,255,0,255);
		p1Text.self_modulate = Color(255,255,255,255);
	
	p2Text.set_text(r)
	

func VisbleText(on):
	self.visible = on;
	endtextback.visible = on

func ShowToNext():
	LastM.visible = true;



