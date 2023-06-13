extends Node

@onready var endtext = get_node("EndText")
@onready var endtextback =get_node("BackGroundText")
@onready var timer = get_node("Timer")

@onready var UiinScene = get_tree().get_root().get_node("/root/Ingame/RoundText");


@export var gameOver = false

@export var maxround = 3;
var currentRound = 0;
@export var winRat = [0,0];

var round_over = false;

@export var WithBombTimer = true;

signal end_of_Round;


# Called when the node enters the scene tree for the first time.
func _ready():
	print(currentRound)
	gameOver = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if Input.is_action_pressed("ReloadGame"):
		if(gameOver):
			winRat = [0,0];
			gameOver = false
			currentRound = 0;
			round_over = false;
			Reload()
	if Input.is_action_pressed("ToMenu"):
		winRat = [0,0];
		gameOver = false
		currentRound = 0;
		round_over = false;
		get_tree().change_scene_to_file("res://main_Menu.tscn")
	
func RoundEnd(Loser):
	if(!round_over):
		round_over = true;
		var Winner = "0"
		if (Loser == "1"):
			Winner= "2"
		else:
			Winner= "1"
	
		emit_signal("end_of_Round")
		
		
		winRat[int(Winner)-1] = winRat[int(Winner)-1] +1;
		
		if (winRat[int(Winner)-1] == ( maxround / 2 +1)):
			AllRoundPlayed(Winner)
			return
		
		currentRound = currentRound +1;
		if(currentRound < maxround):
			ToNextRound(Winner);
		else:
			AllRoundPlayed(Winner);
		
		

func AllRoundPlayed(Winner):
	var tM = get_tree().get_root().get_node("/root/Ingame/RoundText")
	tM.ShowText("Player " + Winner + " has Won ",str(winRat[0]),str(winRat[1]),Winner)
	tM.ShowToNext()
	gameOver = true;

func Reload():
	get_tree().reload_current_scene()

func SetRound(newcount):
	maxround = newcount;


func _on_timer_timeout():
	VisbleText(false)
	round_over = false;
	timer.stop()
	Reload()
	
func ShowText(text):
	VisbleText(true)
	endtext.set_text(text)

func VisbleText(on):
	endtext.visible = on;
	endtextback.visible = on

func ToNextRound(Winner):
	timer.start()
	print("End")
	get_tree().get_root().get_node("/root/Ingame/RoundText").ShowText("Round " + str(currentRound) ,str(winRat[0]),str(winRat[1]),Winner)
	
func SetBombMode(set):
	WithBombTimer = set;

func GetBombMode():
	return WithBombTimer;
