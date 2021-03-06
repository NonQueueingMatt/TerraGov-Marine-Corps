/obj/machinery/mining
	icon = 'icons/obj/mining_drill.dmi'
	anchored = 0
	use_power = 0 //The drill takes power directly from a cell.
	density = 1
	layer = ABOVE_MOB_LAYER //So it draws over mobs in the tile north of it.

/obj/machinery/mining/drill
	name = "mining drill head"
	desc = "An enormous drill."
	icon_state = "mining_drill"

/*
	var/braces_needed = 2
	var/list/supports = list()
	var/supported = 0
	var/active = 0
	var/list/resource_field = list()
	var/open = 0

	var/ore_types = list(
		"iron" = /obj/item/ore/iron,
		"uranium" = /obj/item/ore/uranium,
		"gold" = /obj/item/ore/gold,
		"silver" = /obj/item/ore/silver,
		"diamond" = /obj/item/ore/diamond,
		"phoron" = /obj/item/ore/phoron,
		"osmium" = /obj/item/ore/osmium,
		"hydrogen" = /obj/item/ore/hydrogen,
		"silicates" = /obj/item/ore/glass,
		"carbonaceous rock" = /obj/item/ore/coal
		)

	//Upgrades
	var/obj/item/stock_parts/matter_bin/storage
	var/obj/item/stock_parts/micro_laser/cutter
	var/obj/item/stock_parts/capacitor/cellmount
	var/obj/item/cell/cell

	//Flags
	var/need_update_field = 0
	var/need_player_check = 0

/obj/machinery/mining/drill/New()

	..()

	storage = new(src)
	cutter = new(src)
	cellmount = new(src)

	cell = new(src)
	cell.maxcharge = 10000
	cell.charge = cell.maxcharge

/obj/machinery/mining/drill/process()

	if(need_player_check)
		return

	check_supports()

	if(!active) return

	if(!anchored || !use_cell_power())
		system_error("system configuration or charge error")
		return

	if(need_update_field)
		get_resource_field()

	if(world.time % 10 == 0)
		update_icon()

	if(!active)
		return

	//Dig out the tasty ores.
	if(resource_field.len)
		var/turf/harvesting = pick(resource_field)

		while(resource_field.len && !harvesting.resources)
			harvesting.has_resources = 0
			harvesting.resources = null
			resource_field -= harvesting
			harvesting = pick(resource_field)

		if(!harvesting) return

		var/total_harvest = get_harvest_capacity() //Ore harvest-per-tick.
		var/found_resource = 0 //If this doesn't get set, the area is depleted and the drill errors out.

		for(var/metal in ore_types)

			if(contents.len >= get_storage_capacity())
				system_error("insufficient storage space")
				active = 0
				need_player_check = 1
				update_icon()
				return

			if(contents.len + total_harvest >= get_storage_capacity())
				total_harvest = get_storage_capacity() - contents.len

			if(total_harvest <= 0) break
			if(harvesting.resources[metal])

				found_resource  = 1

				var/create_ore = 0
				if(harvesting.resources[metal] >= total_harvest)
					harvesting.resources[metal] -= total_harvest
					create_ore = total_harvest
					total_harvest = 0
				else
					total_harvest -= harvesting.resources[metal]
					create_ore = harvesting.resources[metal]
					harvesting.resources[metal] = 0

				for(var/i=1,i<=create_ore,i++)
					var/oretype = ore_types[metal]
					new oretype(src)

		if(!found_resource)
			harvesting.has_resources = 0
			harvesting.resources = null
			resource_field -= harvesting
	else
		active = 0
		need_player_check = 1
		update_icon()

/obj/machinery/mining/drill/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/mining/drill/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/tool/screwdriver))
		if(active) return
		open = !open
		to_chat(user, "<span class='notice'>You [open ? "open" : "close"] the maintenance panel.</span>")
		return
	else
		if(!open || active) return ..()
		if(istype(W,/obj/item/tool/crowbar))
			if(cell)
				to_chat(user, "You pry out \the [cell].")
				cell.loc = get_turf(src)
				cell = null
			else if(storage)
				to_chat(user, "You slip the bolt and pry out \the [storage].")
				storage.loc = get_turf(src)
				storage = null
			else if(cutter)
				to_chat(user, "You carefully detatch and pry out \the [cutter].")
				cutter.loc = get_turf(src)
				cutter = null
			else if(cellmount)
				to_chat(user, "You yank out a few wires and pry out \the [cellmount].")
				cellmount.loc = get_turf(src)
				cellmount = null
			else
				to_chat(user, "There's nothing inside the drilling rig to remove.")
			return
		else if(istype(W,/obj/item/stock_parts/matter_bin))
			if(storage)
				to_chat(user, "The drill already has a matter bin installed.")
			else
				if(user.drop_inv_item_to_loc(W, src))
					storage = W
					to_chat(user, "You install \the [W].")
			return
		else if(istype(W,/obj/item/stock_parts/micro_laser))
			if(cutter)
				to_chat(user, "The drill already has a cutting head installed.")
			else
				if(user.drop_inv_item_to_loc(W, src))
					cutter = W
					to_chat(user, "You install \the [W].")
			return
		else if(istype(W,/obj/item/stock_parts/capacitor))
			if(cellmount)
				to_chat(user, "The drill already has a cell capacitor installed.")
			else
				if(user.drop_inv_item_to_loc(W, src))
					cellmount = W
					to_chat(user, "You install \the [W].")
			return
		else if(istype(W,/obj/item/cell))
			if(cell)
				to_chat(user, "The drill already has a cell installed.")
			else
				if(user.drop_inv_item_to_loc(W, src))
					cell = W
					to_chat(user, "You install \the [W].")
			return
	..()
/obj/machinery/mining/drill/attack_hand(mob/user as mob)
	check_supports()

	if(need_player_check)
		to_chat(user, "You hit the manual override and reset the drill's error checking.")
		need_player_check = 0
		if(anchored) get_resource_field()
		update_icon()
		return

	else if(supported)
		if(use_cell_power())
			active = !active
			if(active)
				to_chat(user, "<span class='notice'>You engage \the [src] and it lurches downwards, grinding noisily.</span>")
				need_update_field = 1
			else
				to_chat(user, "<span class='notice'>You disengage \the [src] and it shudders to a grinding halt.</span>")
		else
			to_chat(user, "<span class='notice'>The drill is unpowered.</span>")
	else
		to_chat(user, "<span class='notice'>Turning on a piece of industrial machinery without sufficient bracing is a bad idea.</span>")

	update_icon()

/obj/machinery/mining/drill/update_icon()
	if(need_player_check)
		icon_state = "mining_drill_error"
	else if(active)
		icon_state = "mining_drill_active"
	else if(supported)
		icon_state = "mining_drill_braced"
	else
		icon_state = "mining_drill"
	return

/obj/machinery/mining/drill/proc/check_supports()

	supported = 0

	if((!supports || !supports.len) && initial(anchored) == 0)
		icon_state = "mining_drill"
		anchored = 0
		active = 0
	else
		anchored = 1

	if(supports && supports.len >= braces_needed)
		supported = 1

	update_icon()

/obj/machinery/mining/drill/proc/system_error(var/error)

	if(error) src.visible_message("<span class='warning'> \The [src] flashes a '[error]' warning.</span>")
	need_player_check = 1
	active = 0
	update_icon()

/obj/machinery/mining/drill/proc/get_harvest_capacity()
	return (cutter ? cutter.rating : 0)

/obj/machinery/mining/drill/proc/get_storage_capacity()
	return 200 * (storage ? storage.rating : 0)

/obj/machinery/mining/drill/proc/get_charge_use()
	return 50 - (10 * (cellmount ? cellmount.rating : 0))

/obj/machinery/mining/drill/proc/get_resource_field()

	resource_field = list()
	need_update_field = 0

	var/turf/T = get_turf(src)
	if(!istype(T)) return

	var/tx = T.x-2
	var/ty = T.y-2
	var/turf/mine_turf
	for(var/iy=0,iy<5,iy++)
		for(var/ix=0,ix<5,ix++)
			mine_turf = locate(tx+ix,ty+iy,T.z)
			if(mine_turf && istype(mine_turf) && mine_turf.has_resources)
				resource_field += mine_turf

	if(!resource_field.len)
		system_error("resources depleted")

/obj/machinery/mining/drill/proc/use_cell_power()
	if(!cell) return 0
	var/req = get_charge_use()
	if(cell.charge >= req)
		cell.use(req)
		return 1
	return 0

/obj/machinery/mining/drill/verb/unload()
	set name = "Unload Drill"
	set category = "Object"
	set src in oview(1)

	if(usr.stat) return

	var/obj/structure/ore_box/B = locate() in orange(1)
	if(B)
		for(var/obj/item/ore/O in contents)
			O.loc = B
		to_chat(usr, "<span class='warning'>You unload the drill's storage cache into the ore box.</span>")
	else
		to_chat(usr, "<span class='warning'>You must move an ore box up to the drill before you can unload it.</span>")
*/

/obj/machinery/mining/brace
	name = "mining drill brace"
	desc = "A machinery brace for an industrial drill. It looks easily two feet thick."
	icon_state = "mining_brace"

/*
	var/obj/machinery/mining/drill/connected

/obj/machinery/mining/brace/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/tool/wrench))

		if(istype(get_turf(src),/turf/space))
			to_chat(user, "<span class='notice'>You can't anchor something to empty space. Idiot.</span>")
			return

		if(connected && connected.active)
			to_chat(user, "<span class='notice'>You can't unanchor the brace of a running drill!</span>")
			return

		playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
		to_chat(user, "<span class='notice'>You [anchored ? "un" : ""]anchor the brace.</span>")

		anchored = !anchored
		if(anchored)
			connect()
		else
			disconnect()

/obj/machinery/mining/brace/proc/connect()

	var/turf/T = get_step(get_turf(src), src.dir)

	if(!T.has_resources)
		src.visible_message("<span class='warning'> The terrain near the brace is unsuitable!</span>")
		return

	for(var/thing in T.contents)
		if(istype(thing,/obj/machinery/mining/drill))
			connected = thing
			break

	if(!connected) return

	if(!connected.supports) connected.supports = list()

	icon_state = "mining_brace_active"

	connected.supports += src
	connected.check_supports()

/obj/machinery/mining/brace/proc/disconnect()

	if(!connected) return

	if(!connected.supports) connected.supports = list()

	icon_state = "mining_brace"

	connected.supports -= src
	connected.check_supports()
	connected = null

/obj/machinery/mining/brace/verb/rotate()
	set name = "Rotate"
	set category = "Object"
	set src in oview(1)

	if(usr.stat) return

	if (src.anchored)
		to_chat(usr, "It is anchored in place!")
		return 0

	src.dir = turn(src.dir, 90)
	return 1
*/
