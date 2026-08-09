extends Control

var pageNumber : int = 0
var jounralToAdd : String
var journalText : String
var maxCharacterDisplay : int = 586

@onready var pageNumberLabel : Label = $Label
@onready var soundStream : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var leftPage : Label = $MarginContainer/ColorRect/MarginContainer2/ColorRect/MarginContainer/LeftPageText

func _ready() -> void:
	GlobalSignalBus.connect("updateJounral", jounralUpdated)
	GlobalSignalBus.connect("journalOpened", journalOpened)

func journalOpened():
	pass

func jounralUpdated(journalName):
	soundStream.stream = load("res://resources/sfx/JournalUpdateSFX.wav")
	soundStream.pitch_scale = randf_range(1,1.5)
	soundStream.play()
	match journalName:
		"Hate":
				journalText = journalText + "[Intro]Woah-oh-oh-oh-oh-oh-oh-oh-oh-ohStory of UndertaleI fell from the lightTalk, or should I fight?Monster genocideThis my Undertale[Verse 1]I fell through a cave on Mt. EbottI faced an evil talking flower in a potExplains the plotWants me dead, wants me to rotToriel saves me, takes me to her homeAnd hooks me up with a brand-new monster phoneLeaves me alone, but I escape and meet some bones[Pre-Chorus]Should I be a pacifist?Or should I use my fists?I'm feeling evil, think I'll kill them allChorus]I'm homicidal, and I've got a tasteI want to wipe out the Monster race (Woah-oh-oh-oh-oh-oh-oh-oh-oh-oh)I've got no patience, and got no resolveI will slaughter, screw the dialogueYou might also likeTHE HEART PART 6DrakeJ CHRISTLil Nas X6:16 in LAKendrick Lamar[Bridge]I fell from the lightTalk, or should I fight?Monster genocideThis my Undertale[Verse 2]I'll slaughter Undyne, I'll waste who I choose
With all this XP, there's no way that I'll loseNow watch me move, I won't stop, I'm feelin' rudeAsgore is shaking, he hears my approachI'll slaughter Sans and squash his bro like a roachChara's my coach, all these monsters I will poach[Pre-Chorus]Screw being a pacifistI think I'll use my fistsI'm feeling evil, think I'll kill them all[Chorus]I'm homicidal, and I've got a taste
I want to wipe out the Monster race (Woah-oh-oh-oh-oh-oh-oh-oh-oh-oh)I've got no patience, and got no resolveI will slaughter, screw the dialogue[Bridge]Burnt pan, toy knife, use a stick to take your lifeTough glove, ballet shoes, epic fight like front page newsKing Asgore wants to collect human soulsSeven of them is his ultimate goalOpen the door to humanity's realmStart a new war, humans overwhelm[Chorus]I'm homicidal, and I've got a tasteI want to wipe out the monster race (Woah-oh-oh-oh-oh-oh-oh-oh-oh-oh)I've got no patience, and got no resolveI will slaughter, screw the dialogue"
				updateJorunalPage()
		"LabReview":
				journalText = journalText + "National Face Labs: Meet with Mark for escort, inspect Labs A1, A2, A3, B1, B2, C1, C2, C3. Take blue car behind lab before leaving."
				updateJorunalPage()
		"ChemicalRecipe":
				journalText = journalText + "Chemical Mixture CABDD errupts into flames upon meeting flesh, tests indicate that fire is a valauble counter to EXP-1/2."
				updateJorunalPage()
func updateJorunalPage():
	leftPage.text = journalText.substr(pageNumber * maxCharacterDisplay, maxCharacterDisplay)

func _on_flip_page_left_button_pressed() -> void:
	if(soundStream.playing == false):
		soundStream.stream = load("res://resources/sfx/JournalPageFlip.mp3")
		soundStream.pitch_scale = randf_range(1,1.5)
		soundStream.play()
	if pageNumber != 0:
		pageNumber -= 1
		updateJorunalPage()
		updatePageNumberLabel()

func _on_flip_page_right_button_pressed() -> void:
	if(soundStream.playing == false):
		soundStream.stream = load("res://resources/sfx/JournalPageFlip.mp3")
		soundStream.pitch_scale = randf_range(1,1.5)
		soundStream.play()
	if pageNumber != 100:
		pageNumber += 1
		updateJorunalPage()
		updatePageNumberLabel()


func _on_back_button_button_up() -> void:
	GlobalSignalBus.emit_signal("closeAllMenus")

func updatePageNumberLabel():
	pageNumberLabel.text = "Page: " + str(pageNumber)
