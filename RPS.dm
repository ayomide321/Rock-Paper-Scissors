/*
	These are simple defaults for your project.
 */

world
	fps = 60		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = "12x12"		// show up to 6 tiles outward from center (13x13 view)


// Make objects move 8 pixels per tick when walking

mob
	step_size = 8
	New()
		spawn
			if(client)
				ComboHUD = new(Master = src)
				client.screen += ComboHUD

mob
	step_size = 8
	var
		Rpercent
		Ppercent
		Spercent
obj
	Rock
		icon = 'R.png'
		icon_state = "R"
		Click()
			usr.Rused += 1
			usr.Total += 1
			usr.Rpercent = usr.Rused / usr.Total
			usr.PreviousTurn = "Rock"
			usr.Percentage()
	Paper
		icon = 'p.png'
		icon_state = "P"
		Click()
			usr.Pused += 1
			usr.Total += 1
			usr.Ppercent = usr.Pused / usr.Total
			usr.PreviousTurn = "Paper"
			usr.Percentage()
	Scissors
		icon = 'S.png'
		icon_state = "S"
		Click()
			usr.Sused += 1
			usr.Total += 1
			usr.Spercent = usr.Sused / usr.Total
			usr.PreviousTurn = "Scissors"
			usr.Percentage()
mob/proc
	Percentage()
		var/A = min(Rpercent, Ppercent, Spercent)
		var/B = max(Rpercent, Ppercent, Spercent)
		world<<"Rock: [Rpercent]"
		world<<"Paper: [Ppercent]"
		world<<"Scissors: [Spercent]"
		world<<"Minimum: [A]"
		world<<"Maximum: [B]"
		if(A == Rpercent)
			if(PreviousTurn != "Rock" || Throw != "Paper")
				if(prob(B*100))
					Throw = "Scissors"
				else
					if(prob((A)*100))
						Throw = "Paper"
					else
						Throw = "Rock"
			else
				Throw = "Scissors"
		if(A==Ppercent)
			if(PreviousTurn != "Paper" || Throw != "Scissors")
				if(prob(B*100))
					Throw = "Rock"
				else
					if(prob((A)*100))
						Throw = "Scissors"
					else
						Throw = "Paper"
			else
				Throw = "Rock"
		if(A==Spercent)
			if(PreviousTurn != "Scissors" || Throw != "Rock" )
				if(prob(B*100))
					Throw = "Paper"
				else
					if(prob((A)*100))
						Throw = "Rock"
					else
						Throw = "Scissors"
			else
				Throw = "Paper"
		Results()
		Update_HUD()
	Results()
		world<<"YOU SHOULD THROW: [Throw]"
mob/verb
	Reset()
		Rused = 0
		Pused = 0
		Sused = 0
		Total = 0
		PreviousTurn = ""
		Throw = ""

obj/HUD
	plane = 100
	maptext_width = 368
	maptext_height = 32
	var mob/master
	New(mob/Master)
		master = Master
	proc/Update()
	Combo
		screen_loc = "CENTER:-160,SOUTH+1"
		maptext = "<center>Throw: ???"
		Update()
			maptext = "<center>Throw: [master.Throw]    Rock: [master.Rused] Paper: [master.Pused] Scissors: [master.Sused]"

mob
	proc/Update_HUD()
		ComboHUD.Update()

mob
	var
		Combo = 0
		obj
			HUD
				Combo/ComboHUD