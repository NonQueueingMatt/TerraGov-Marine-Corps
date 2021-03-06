/*
/mob/verb/test_shuttle()
	set name = "DEBUG EVAC SHUTTLE"
	set category = "DEBUG"

	to_chat(world, "Location is [emergency_shuttle.shuttle.location]")
	to_chat(world, "Moving status is [emergency_shuttle.shuttle.moving_status]")
	to_chat(world, "Departed is [emergency_shuttle.departed]")

*/
#define QUEEN_DEATH_COUNTDOWN 			 12000 //20 minutes. Can be changed into a variable if it needs to be manipulated later.

#define MODE_INFESTATION_X_MAJOR		"Xenomorph Major Victory"
#define MODE_INFESTATION_M_MAJOR		"Marine Major Victory"
#define MODE_INFESTATION_X_MINOR		"Xenomorph Minor Victory"
#define MODE_INFESTATION_M_MINOR		"Marine Minor Victory"
#define MODE_INFESTATION_DRAW_DEATH		"DRAW: Mutual Annihilation"

#define MODE_INFECTION_ZOMBIE_WIN		"Major Zombie Victory"

#define MODE_BATTLEFIELD_W_MAJOR		"W-Y PMC Major Success"
#define MODE_BATTLEFIELD_M_MAJOR		"Marine Major Success"
#define MODE_BATTLEFIELD_W_MINOR		"W-Y PMC Minor Success"
#define MODE_BATTLEFIELD_M_MINOR		"Marine Minor Success"
#define MODE_BATTLEFIELD_DRAW_STALEMATE "DRAW: Stalemate"
#define MODE_BATTLEFIELD_DRAW_DEATH		"DRAW: My Friends Are Dead"

#define MODE_GENERIC_DRAW_NUKE			"DRAW: Nuclear Explosion"

/*
Like with cm_initialize.dm, these procs exist to quickly populate classic CM game modes.
Specifically for processing, announcing completion, and so on. Simply plug in these procs
in to the appropriate slots, like the in the example game modes, and you're good to go.
This is meant for infestation type game modes for right now (marines vs. aliens, with a chance
of predators), but can be added to include variant game modes (like humans vs. humans).
*/

//If the queen is dead after a period of time, this will end the game.
/datum/game_mode/proc/check_queen_status(queen_time)
	return

//===================================================\\

				//ANNOUNCE COMPLETION\\

//===================================================\\

/datum/game_mode/proc/declare_completion_announce_individual()
	set waitfor = 0
	sleep(45)
/*
//WIP proc to announce specific outcomes to players. Might require better tracking, but the basics wouldn't hurt.

dat = "You have met your demise during the events of [upper_text(name)][m.mind.current ? " as [m.mind.current.real_name]" : ]. Rest in peace."

dat = "<b>You have survived the events of [upper_text(name)]</b>"

//General disposition.
dat += ", but a sickly feeling in your chest suggests a darker fate awaits you..."
dat += ", but you find yourself in a sticky situation. Best to find a way out..."
//Pain/damage.
dat += " The pain is making it difficult to see straight. You are still reeling from the experience."
dat += " Your severe injuries will no-doubt be a topic for discussion in the future."
//Managed to get to evac safely.
dat += " At least you've made it to evac; it's all over now, right?"
//Failed to catch it.
dat += " You failed to evacuate \the [MAIN_SHIP_NAME]"


"<b>You have survived</b>
"<b>You have survived</b>, and you have managed to evacuate the [MAIN_SHIP_NAME]. Maybe it's finally over..."
"<b>You have survived</b>. That is more than enough, but who knows what the future holds for you now..."

"<span class='round_body'>You lead your hive, and you have survived. Your influence will grow in time.</span>"
"<span class='round_body'>You have served the hive.</span>"

	for(var/mob/m in player_list)
		if(m.mind)
			if(m.stat == DEAD) "<span class='round_body'>You met your demise during the events of [upper_text(name)].</span>"
			else
				if(isYautja(m))

				if(ishuman(m))
					is_mob_immobalized()
				if(isXeno(m))


				var/turf/T = get_turf(m)
				if(ishuman(H))

				var/turf/playerTurf = get_turf(Player)
				if(emergency_shuttle.departed && emergency_shuttle.evac)
					if(playerTurf.z != 2)
						to_chat(Player, "<span class='round_body'>You managed to survive, but were marooned on [station_name()] as [Player.real_name]...</span>")
					else
						to_chat(Player, "<font color='green'><b>You managed to survive the events of [name] as [m.real_name].</b></font>")
				else if(playerTurf.z == 2)
					to_chat(Player, "<font color='green'><b>You successfully underwent crew transfer after events on [station_name()] as [Player.real_name].</b></font>")
				else if(issilicon(Player))
					to_chat(Player, "<font color='green'><b>You remain operational after the events on [station_name()] as [Player.real_name].</b></font>")
				else
					to_chat(Player, "<font color='blue'><b>You missed the crew transfer after the events on [station_name()] as [Player.real_name].</b></font>")
			else

	if(xenomorphs.len)
		var/dat = "<span class='round_body'>The xenomorph Queen(s) were:</span>"
		var/mob/M
		for(var/datum/mind/X in xenomorphs)
			if(istype(X))
				M = X.current
				if(!M || !M.loc) M = X.original
				if(M && M.loc && istype(M,/mob/living/carbon/Xenomorph/Queen)) dat += "<br>[X.key] was [M] <span class='boldnotice'>([M.stat == DEAD? "DIED":"SURVIVED"])</span>"

		to_chat(world, dat)
*/
/datum/game_mode/proc/declare_completion_announce_xenomorphs()
	set waitfor = 0
	sleep(60)
	if(xenomorphs.len)
		var/dat = "<span class='round_body'>The xenomorph Queen(s) were:</span>"
		var/mob/M
		for(var/datum/mind/X in xenomorphs)
			if(istype(X))
				M = X.current
				if(!M || !M.loc) M = X.original
				if(M && M.loc && istype(M,/mob/living/carbon/Xenomorph/Queen)) dat += "<br>[X.key] was [M] <span class='boldnotice'>([M.stat == DEAD? "DIED":"SURVIVED"])</span>"

		to_chat(world, dat)

/datum/game_mode/proc/declare_completion_announce_survivors()
	set waitfor = 0
	sleep(85)
	if(survivors.len)
		var/dat = "<span class='round_body'>The survivors were:</span>"
		var/mob/M
		for(var/datum/mind/S in survivors)
			if(istype(S))
				M = S.current
				if(!M || !M.loc) M = S.original
				if(M && M.loc) 	dat += "<br>[S.key] was [M.real_name] <span class='boldnotice'>([M.stat == DEAD? "DIED":"SURVIVED"])</span>"
				else 			dat += "<br>[S.key]'s body was destroyed... <span class='boldnotice'>(DIED)</span>"

		to_chat(world, dat)

/datum/game_mode/proc/declare_completion_announce_predators()
	set waitfor = 0
	sleep(100)
	if(predators.len)
		var/dat = "<span class='round_body'>The Predators were:</span>"
		var/mob/M
		for(var/datum/mind/P in predators)
			if(istype(P))
				M = P.current
				if(!M || !M.loc) M = P.original
				if(M && M.loc) 	dat += "<br>[P.key] was [M.real_name] <span class='boldnotice'>([M.stat == DEAD? "DIED":"SURVIVED"])</span>"
				else 			dat += "<br>[P.key]'s body was destroyed... <span class='boldnotice'>(DIED)</span>"

		to_chat(world, dat)


/datum/game_mode/proc/declare_completion_announce_medal_awards()
	set waitfor = 0
	sleep(120)
	if(medal_awards.len)
		var/dat =  "<span class='round_body'>Medal Awards:</span>"
		for(var/recipient in medal_awards)
			var/datum/recipient_awards/RA = medal_awards[recipient]
			for(var/i in 1 to RA.medal_names.len)
				dat += "<br><b>[RA.recipient_rank] [recipient]</b> is awarded [RA.posthumous[i] ? "posthumously " : ""]the <span class='boldnotice'>[RA.medal_names[i]]</span>: \'<i>[RA.medal_citations[i]]</i>\'."
		to_chat(world, dat)


/datum/game_mode/proc/declare_completion_announce_round_stats()
	set waitfor = 0
	sleep(140)
	var/list/dat = list({"<span class='round_body'>The end of round statistics are:</span><br>
		<br>There were [round_statistics.total_bullets_fired] total bullets fired.
		<br>[round_statistics.total_bullet_hits_on_marines] bullets managed to hit marines. For a [(round_statistics.total_bullet_hits_on_marines / max(round_statistics.total_bullets_fired, 1)) * 100]% friendly fire rate!"})
	if(round_statistics.total_bullet_hits_on_xenos)
		dat += "[round_statistics.total_bullet_hits_on_xenos] bullets managed to hit xenomorphs. For a [(round_statistics.total_bullet_hits_on_xenos / max(round_statistics.total_bullets_fired, 1)) * 100]% accuracy total!"
	if(round_statistics.grenades_thrown)
		dat += "[round_statistics.grenades_thrown] total grenades exploding."
	else
		dat += "No grenades exploded."
	if(round_statistics.now_pregnant)
		dat += "[round_statistics.now_pregnant] people infected among which [round_statistics.total_larva_burst] burst. For a [(round_statistics.total_larva_burst / max(round_statistics.now_pregnant, 1)) * 100]% successful delivery rate!"
	if(round_statistics.queen_screech)
		dat += "[round_statistics.queen_screech] Queen screeches."
	if(round_statistics.ravager_ravage_victims)
		dat += "[round_statistics.ravager_ravage_victims] ravaged victims. Damn, Ravagers!"
	if(round_statistics.warrior_limb_rips)
		dat += "[round_statistics.warrior_limb_rips] limbs ripped off by Warriors."
	if(round_statistics.crusher_stomp_victims)
		dat += "[round_statistics.crusher_stomp_victims] people stomped by crushers."
	if(round_statistics.praetorian_spray_direct_hits)
		dat += "[round_statistics.praetorian_spray_direct_hits] people hit directly by Praetorian acid spray."
	if(round_statistics.weeds_planted)
		dat += "[round_statistics.weeds_planted] weed nodes planted."
	if(round_statistics.weeds_destroyed)
		dat += "[round_statistics.weeds_destroyed] weed tiles removed."
	if(round_statistics.carrier_traps)
		dat += "[round_statistics.carrier_traps] hidey holes for huggers were made."
	var/output = jointext(dat, "<br>")
	for(var/mob/player in player_list)
		if(player?.client?.prefs?.toggles_chat & CHAT_STATISTICS)
			to_chat(player, output)

/datum/game_mode/proc/end_of_round_deathmatch()
	var/list/spawns = list()

	for(var/obj/effect/landmark/L in landmarks_list)
		if(L.name == "deathmatch")
			spawns += L.loc

	if(length(spawns) < 1)
		message_admins("DEBUG: Failed to find any End of Round Deathmatch landmarks.")
		log_debug("DEBUG: Failed to find any End of Round Deathmatch landmarks.")
		to_chat(world, "<br><br><h1><span class='warning'>End of Round Deathmatch initialization failed, please do not grief.</span></h1><br><br>")
		return

	for(var/x in mob_list)
		if(!istype(x, /mob/living/carbon/human))
			continue

		var/mob/living/carbon/human/H = x

		if(!(H.client?.prefs?.be_special & BE_DEATHMATCH))
			continue

		var/turf/picked
		if(length(spawns))
			picked = pick(spawns)
			spawns -= picked
		else
			for(var/obj/effect/landmark/L in landmarks_list)
				switch(L.name)
					if("deathmatch")
						spawns += L.loc

			if(length(spawns) < 1)
				message_admins("DEBUG: Failed to regenerate End of Round Deathmatch landmarks.")
				log_debug("DEBUG: Failed to regenerate End of Round Deathmatch landmarks.")

			else
				picked = pick(spawns)
				spawns -= picked

		
		if(picked)
			H.loc = picked
			H.revive()
			to_chat(H, "<br><br><h1><span class='warning'>Fight for your life!</span></h1><br><br>")
		else
			to_chat(H, "<br><br><h1><span class='warning'>Failed to find a valid location for End of Round Deathmatch. Please do not grief.</span></h1><br><br>")





//===================================================\\

					//HELPER PROCS\\

//===================================================\\

//Spawns a larva in an appropriate location
/datum/game_mode/proc/spawn_latejoin_larva()
	var/mob/living/carbon/Xenomorph/Larva/new_xeno = new /mob/living/carbon/Xenomorph/Larva(pick(xeno_spawn))
	new_xeno.visible_message("<span class='xenodanger'>A larva suddenly burrows out of the ground!</span>",
	"<span class='xenodanger'>You burrow out of the ground and awaken from your slumber. For the Hive!</span>")
	new_xeno << sound('sound/effects/xeno_newlarva.ogg')

//Disperses fog, doing so gradually.
/datum/game_mode/proc/disperse_fog()
	set waitfor = 0
	//to_chat(world, "<span class='boldnotice'>The fog north of the colony is starting to recede.</span>")
	flags_round_type &= ~MODE_FOG_ACTIVATED
	var/i
	for(i in round_fog)
		round_fog -= i
		qdel(i)
		sleep(1)
	round_fog = null

//Delta is the randomness interval, in +/-. Might not be the exact mathematical definition
/datum/game_mode/proc/announce_bioscans(var/delta = 2)
	var/list/activeXenos = list() //We'll announce to them later.
	var/list/xenoLocationsP = list()
	var/list/xenoLocationsS = list()
	var/list/hostLocationsP = list()
	var/list/hostLocationsS = list()
	var/list/observers = list()
	var/numHostsPlanet	= 0
	var/numHostsShip	= 0
	var/numXenosPlanet	= 0
	var/numXenosShip	= 0
	var/numLarvaPlanet  = 0
	var/numLarvaShip    = 0

	for(var/mob/M in player_list) //Scan through and detect Xenos and Hosts, but only those with clients.
		if(M.stat != DEAD)
			var/area/A = get_area(M)
			if(isXeno(M))
				switch(A?.z)
					if(PLANET_Z_LEVEL || LOW_ORBIT_Z_LEVEL)
						if(isXenoLarva(M))
							numLarvaPlanet++
						numXenosPlanet++
						xenoLocationsP += A
					if(MAIN_SHIP_Z_LEVEL)
						if(isXenoLarva(M))
							numLarvaShip++
						numXenosShip++ 
						xenoLocationsS += A
					
				activeXenos += M

			if(ishuman(M) && !isYautja(M))
				switch(A?.z)
					if(PLANET_Z_LEVEL || LOW_ORBIT_Z_LEVEL)
						numHostsPlanet++ 
						hostLocationsP += A
					if(MAIN_SHIP_Z_LEVEL)
						numHostsShip++ 
						hostLocationsS += A


					
		else
			observers += M

	//Adjust the randomness there so everyone gets the same thing
	var/numHostsShipr = max(0, numHostsShip + rand(-delta, delta))
	var/numXenosPlanetr = max(0, numXenosPlanet + rand(-delta, delta))
	var/hostLocationP
	var/hostLocationS
	
	if(length(hostLocationsP))
		hostLocationP = pick(hostLocationsP)

	if(length(hostLocationsS))
		hostLocationS = pick(hostLocationsS)

	// The announcement to all Xenos. Slightly off for the human ship, accurate otherwise.
	for(var/mob/M in activeXenos)
		M << sound(get_sfx("queen"), wait = 0, volume = 50)
		to_chat(M, "<span class='xenoannounce'>The Queen Mother reaches into your mind from worlds away.</span>")
		to_chat(M, "<span class='xenoannounce'>To my children and their Queen. I sense [numHostsShipr ? "approximately [numHostsShipr]":"no"] host[numHostsShipr > 1 ? "s":""] in the metal hive[numHostsShipr > 0 && hostLocationS ? ", including one in [hostLocationS]":""] and [numHostsPlanet ? "[numHostsPlanet]":"none"] scattered elsewhere[hostLocationP ? ", including one in [hostLocationP]":""].</span>")

	// The announcement to all Humans. Slightly off for the planet and elsewhere, accurate for the ship.
	var/xenoLocationP
	var/xenoLocationS
	
	if(length(xenoLocationsP))
		xenoLocationP = pick(xenoLocationsP)

	if(length(xenoLocationsS))
		xenoLocationS = pick(xenoLocationsS)

	var/name = "[MAIN_AI_SYSTEM] Bioscan Status"
	var/input = "Bioscan complete.\n\nSensors indicate [numXenosShip ? "[numXenosShip]":"no"] unknown lifeform signature[numXenosShip > 1 ? "s":""] present on the ship[xenoLocationS ? " including one in [xenoLocationS]" : ""] and [numXenosPlanetr ? "approximately [numXenosPlanetr]":"no"] signature[numXenosPlanetr > 1 ? "s":""] located elsewhere[numXenosPlanetr > 0 && xenoLocationP ? ", including one in [xenoLocationP]":""]."
	command_announcement.Announce(input, name, new_sound = 'sound/AI/bioscan.ogg')

	log_admin("Bioscan. Humans: [numHostsPlanet] on the planet[hostLocationP ? " Location:[hostLocationP]":""] and [numHostsShip] on the ship.[hostLocationS ? " Location: [hostLocationS].":""] Xenos: [numXenosPlanetr] on the planet and [numXenosShip] on the ship[xenoLocationP ? " Location:[xenoLocationP]":""].")
	message_admins("Bioscan - Humans: [numHostsPlanet] on the planet[hostLocationP ? ". Location:[hostLocationP]":""]. [numHostsShipr] on the ship.[numHostsShipr && hostLocationS ? " Location: [hostLocationS].":""]", 1)
	message_admins("Bioscan - Xenos: [numXenosPlanetr] on the planet[numXenosPlanetr > 0 && xenoLocationP ? ". Location:[xenoLocationP]":""]. [numXenosShip] on the ship.[xenoLocationS ? " Location: [xenoLocationS].":""]", 1)
		
	for(var/mob/M in observers) // Extra information for all ghosts
		if(istype(M, /mob/new_player))
			continue
		to_chat(M, "<h2 class='alert'>Detailed Information</h2>")
		to_chat(M, {"<span class='alert'>[numXenosPlanet] xenos on the planet, including [numLarvaPlanet] larva.
[numXenosShip] xenos on the ship, including [numLarvaShip] larva.
[numHostsPlanet] human[numHostsPlanet > 1 ? "s" : ""] on the planet.
[numHostsShip] human[numHostsShip > 1 ? "s" : ""] on the ship.</span>"})



/*
Count up surviving humans and aliens.
Can't be in a locker, in space, in the thunderdome, or distress.
Only checks living mobs with a client attached.
*/
/datum/game_mode/proc/count_humans_and_xenos(list/z_levels = GAME_PLAY_Z_LEVELS)
	var/num_humans = 0
	var/num_xenos = 0

	for(var/mob/M in player_list)
		if(M.z && (M.z in z_levels) && M.stat != DEAD && !istype(M.loc, /turf/open/space)) //If they have a z var, they are on a turf.
			if(ishuman(M) && !(M.status_flags & XENO_HOST) && !iszombie(M))
				var/mob/living/carbon/human/H = M
				if(H.species && H.species.count_human) //only real humans count
					num_humans++
			else if(isXeno(M))
				var/mob/living/carbon/Xenomorph/X = M
				if(!X.stealth_router(HANDLE_STEALTH_CHECK)) //We don't count stealthed Beanos due to delay potential
					num_xenos++
			else if(iszombie(M)) num_xenos++

	return list(num_humans,num_xenos)

/datum/game_mode/proc/count_marines_and_pmcs(list/z_levels = GAME_PLAY_Z_LEVELS)
	var/num_marines = 0
	var/num_pmcs = 0

	for(var/mob/M in player_list)
		if(M.z && (M.z in z_levels) && M.stat != DEAD && !istype(M.loc, /turf/open/space))
			if(ishuman(M) && !isYautja(M))
				if(M.mind && M.mind.special_role == "PMC") 	num_pmcs++
				else if(M.mind && !M.mind.special_role)		num_marines++

	return list(num_marines,num_pmcs)

/*
#undef QUEEN_DEATH_COUNTDOWN
#undef MODE_INFESTATION_X_MAJOR
#undef MODE_INFESTATION_M_MAJOR
#undef MODE_INFESTATION_X_MINOR
#undef MODE_INFESTATION_M_MINOR
#undef MODE_INFESTATION_DRAW_DEATH
#undef MODE_BATTLEFIELD_W_MAJOR
#undef MODE_BATTLEFIELD_M_MAJOR
#undef MODE_BATTLEFIELD_W_MINOR
#undef MODE_BATTLEFIELD_M_MINOR
#undef MODE_BATTLEFIELD_DRAW_STALEMATE
#undef MODE_BATTLEFIELD_DRAW_DEATH
#undef MODE_GENERIC_DRAW_NUKE*/
