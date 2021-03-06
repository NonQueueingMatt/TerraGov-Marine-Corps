//Solar tracker

//Machine that tracks the sun and reports it's direction to the solar controllers
//As long as this is working, solar panels on same powernet will track automatically

/obj/machinery/power/tracker
	name = "solar tracker"
	desc = "A solar directional tracker."
	icon = 'icons/obj/power.dmi'
	icon_state = "tracker"
	anchored = 1
	density = 1
	directwired = 1
	use_power = 0 // doesn't use APC power
	var/power_usage = 500	//W

	var/sun_angle = 0		// sun angle as set by sun datum

/obj/machinery/power/tracker/New(var/turf/loc, var/obj/item/frame/solar_assembly/S)
	..(loc)
	if(!S)
		S = new /obj/item/frame/solar_assembly(src)
		S.glass_type = /obj/item/stack/sheet/glass
		S.tracker = 1
		S.anchored = 1
	S.loc = src
	connect_to_network()

/obj/machinery/power/tracker/disconnect_from_network()
	..()
	solars_list.Remove(src)

/obj/machinery/power/tracker/connect_to_network()
	..()
	solars_list.Add(src)

// called by datum/sun/calc_position() as sun's angle changes
/obj/machinery/power/tracker/proc/set_angle(var/angle)
	sun_angle = angle

	//set icon dir to show sun illumination
	dir = turn(NORTH, -angle - 22.5)	// 22.5 deg bias ensures, e.g. 67.5-112.5 is EAST

	// check we can draw power
	if(stat & NOPOWER)
		return

	// find all solar controls and update them
	// currently, just update all controllers in the world
	// ***TODO: better communication system using network
	if(powernet)
		for(var/obj/machinery/power/solar_control/C in get_solars_powernet())
			if(powernet.nodes[C])
				if(get_dist(C, src) < SOLAR_MAX_DIST)
					C.tracker_update(angle)


/obj/machinery/power/tracker/attackby(var/obj/item/W, var/mob/user)

	if(iscrowbar(W))
		playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
		if(do_after(user, 50, TRUE, 5, BUSY_ICON_BUILD))
			var/obj/item/frame/solar_assembly/S = locate() in src
			if(S)
				S.loc = src.loc
				S.give_glass()
			playsound(src.loc, 'sound/items/Deconstruct.ogg', 25, 1)
			user.visible_message("<span class='notice'>[user] takes the glass off the tracker.</span>")
			qdel(src)
		return
	..()

// timed process
// make sure we can draw power from the powernet
/obj/machinery/power/tracker/process()

	if(surplus() >= power_usage && add_load(power_usage) >= power_usage)
		stat &= ~NOPOWER
	else
		stat |= NOPOWER


