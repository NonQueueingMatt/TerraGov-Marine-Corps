//-----USS Almayer Machinery file -----//
// Put any new machines in here before map is released and everything moved to their proper positions.

/obj/machinery/vending/marine/uniform_supply
	name = "\improper ColMarTech surplus uniform vender"
	desc = "A automated weapon rack hooked up to a colossal storage of uniforms"
	icon_state = "armory"
	icon_vend = "armory-vend"
	icon_deny = "armory"
	req_access = null
	req_access_txt = "0"
	req_one_access = null
	req_one_access_txt = "9;2;21"
	var/squad_tag = ""

	product_ads = "If it moves, it's hostile!;How many enemies have you killed today?;Shoot first, perform autopsy later!;Your ammo is right here.;Guns!;Die, scumbag!;Don't shoot me bro!;Shoot them, bro.;Why not have a donut?"
	products = list(
					/obj/item/weapon/storage/backpack/marine = 10,
					/obj/item/device/radio/headset/msulaco = 10,
					/obj/item/weapon/storage/belt/marine = 10,
					/obj/item/clothing/shoes/marine = 10,
					/obj/item/clothing/under/marine = 10
					)

	prices = list()

	New()

		..()
		if(squad_tag != null) //probably some better way to slide this in but no sleep is no sleep.
			var/products2[]
			switch(squad_tag)
				if("Alpha")
					products2 = list(/obj/item/device/radio/headset/malpha = 20)
				if("Bravo")
					products2 = list(/obj/item/device/radio/headset/mbravo = 20)
				if("Charlie")
					products2 = list(/obj/item/device/radio/headset/mcharlie = 20)
				if("Delta")
					products2 = list(/obj/item/device/radio/headset/mdelta = 20)
			build_inventory(products2)
		marine_vendors.Add(src)



//-----USS Almayer Props -----//
//Put any props that don't function properly, they could function in the future but for now are for looks. This system could be expanded for other maps too. ~Art

/obj/item/prop/almayer
	name = "GENERIC USS ALMAYER PROP"
	desc = "THIS SHOULDN'T BE VISIBLE, AHELP 'ART-P03' IF SEEN IN ROUND WITH LOCATION"
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "hangarbox"

/obj/item/prop/almayer/box
	name = "metal crate"
	desc = "A metal crate used often for storing small electronics that go into dropships"
	icon_state = "hangarbox"
	w_class = 4

/obj/item/prop/almayer/flight_recorder
	name = "\improper FR-112 flight recorder"
	desc = "A small red box that contains flight data from a dropship while its on mission. Usually refered to the black box, although this one comes in bloody red."
	icon_state = "flight_recorder"
	w_class = 4

/obj/item/prop/almayer/lantern_pod
	name = "\improper LANTERN pod"
	desc = "A long green box mounted into a dropship to provide various optical support for its ground targeting systems."
	icon_state = "lantern_pod"
	w_class = 4

/obj/item/prop/almayer/flare_launcher
	name = "\improper MJU-77/C case"
	desc = "A flare launcher that usually gets mounted onto dropships to help survivability against infrared tracking missiles."
	icon_state = "flare_launcher"
	w_class = 2

/obj/item/prop/almayer/chaff_launcher
	name = "\improper RR-247 Chaff case"
	desc = "A chaff launcher that usually gets mounted onto dropships to help survivability against radar tracking missiles."
	icon_state = "chaff_launcher"
	w_class = 3

/obj/item/prop/almayer/handheld1
	name = "small handheld"
	desc = "A small piece of electronic doodads"
	icon_state = "handheld1"
	w_class = 2

/obj/item/prop/almayer/comp_closed
	name = "dropship maintenance computer"
	desc = "A closed dropship maintenance computer that technicans and pilots use to find out whats wrong with a dropship. It has various outlets for different systems."
	icon_state = "hangar_comp"
	w_class = 4

/obj/item/prop/almayer/comp_open
	name = "dropship maintenance computer"
	desc = "A opened dropship maintenance computer, it seems to be off however. Its used by technicans and pilots to find damaged or broken systems on a dropship. It has various outlets for different systems."
	icon_state = "hangar_comp_open"
	w_class = 4

/obj/machinery/prop/almayer
	name = "GENERIC USS ALMAYER PROP"
	desc = "THIS SHOULDN'T BE VISIBLE, AHELP 'ART-P01' IF SEEN IN ROUND WITH LOCATION"

/obj/machinery/prop/almayer/hangar/dropship_part_fabricator
	name = "dropship part fabricator"
	desc = "A large automated 3D printer for producing new dropship parts."

	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 20

	icon = 'icons/obj/machines/drone_fab.dmi'
	icon_state = "drone_fab_idle"


/obj/machinery/prop/almayer/computer/PC
	name = "personal desktop"
	desc = "A small computer hooked up into the ship's computer network."
	icon_state = "terminal1"

/obj/machinery/prop/almayer/computer
	name = "systems computer"
	desc = "A small computer hooked up into the ships systems."

	density = 0
	anchored = 1
	use_power = 1
	idle_power_usage = 20

	icon = 'icons/obj/almayer.dmi'
	icon_state = "terminal"

/obj/machinery/prop/almayer/CICmap
	name = "map table"
	desc = "A table that displays a map of the current target location"

	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 20

	icon = 'icons/obj/almayer.dmi'
	icon_state = "maptable"

//Nonpower using props

/obj/structure/prop/almayer
	name = "GENERIC USS ALMAYER PROP"
	desc = "THIS SHOULDN'T BE VISIBLE, AHELP 'ART-P02' IF SEEN IN ROUND WITH LOCATION"
	density = 1
	anchored = 1

/obj/structure/prop/almayer/minigun_crate
	name = "30mm ammo crate"
	desc = "A crate full of 30mm bullets used on one of the weapon pod types for the dropship. Moving this will require some sort of lifer"
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "30mm_crate"


/obj/structure/prop/almayer/mission_planning_system
	name = "\improper MPS IV computer"
	desc = "The Mission Planning System IV (MPS IV), a enhancement in mission planning and charting for dropship pilots across the USCM. Fully capable of customizing their flight paths and loadouts to suit their combat needs."
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "mps"

/obj/structure/prop/almayer/mapping_computer
	name = "\improper CMPS II computer"
	desc = "The Common Mapping Production System version II allows for sensory imput from satellites and ship systems to derive planetary maps in a standardized fashion for all USCM pilots."
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "mapping_comp"

/obj/structure/prop/almayer/sensor_computer1
	name = "sensor computer"
	desc = "The IBM series 10 computer retrofitted to work as a sensor computer for the ship. While somewhat dated it still serves its purpose."
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "sensor_comp1"

/obj/structure/prop/almayer/sensor_computer2
	name = "sensor computer"
	desc = "The IBM series 10 computer retrofitted to work as a sensor computer for the ship. While somewhat dated it still serves its purpose."
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "sensor_comp2"

/obj/structure/prop/almayer/sensor_computer3
	name = "sensor computer"
	desc = "The IBM series 10 computer retrofitted to work as a sensor computer for the ship. While somewhat dated it still serves its purpose."
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "sensor_comp3"

/obj/structure/prop/almayer/missile_rack
	name = "\improper AIM-224"
	desc = "The AIM-224 is the latest in air to air missile technology."
	icon = 'icons/Marine/almayer_props64.dmi'
	icon_state = "double"
	bound_x = 64
	bound_y = 32

/obj/structure/prop/almayer/paveway_bomb
	name = "\improper GBU-67 Bomb"
	desc = "The GBU-67 is the latest in a generation of laser guided weaponry that spans all the way back to the 20th century."
	icon = 'icons/Marine/almayer_props64.dmi'
	icon_state = "paveway"
	bound_x = 64
	bound_y = 32

/obj/structure/prop/almayer/banshee_missile
	name = "\improper AGM-227 'Banshee'"
	desc = "The AGM-227 missile is a mainstay of the overhauled dropship fleet against any mobile or armored ground targets. It's earned the nickname of banshee after the wailing noise it makes right before it hits its target"
	icon = 'icons/Marine/almayer_props64.dmi'
	icon_state = "banshee"
	bound_x = 64
	bound_y = 32

/obj/structure/prop/almayer/gau_21
	name = "\improper GAU-21 30mm cannon"
	desc = "A dismounted GAU-21 'Rattler' 30mm rotary cannon. It seems to be missing its feed links and has exposed connection wires. Capable of firing 5200 rounds a minute, feared by many for its power. Earned the nickname 'Rattler' from the vibrations it would cause on dropships in its inital production run."
	icon = 'icons/Marine/almayer_props64.dmi'
	icon_state = "30mm_cannon"
	bound_x = 64
	bound_y = 32

/obj/structure/prop/almayer/missile_tube
	name = "missile tube"
	desc = "A cold launch missile tube."
	icon = 'icons/Marine/almayer_props96.dmi'
	icon_state = "missiletubenorth"
	bound_x = 32
	bound_y = 96

/obj/structure/prop/almayer/ship_memorial
	name = "slab of victory"
	desc = "A ship memorial dedicated to the victories of the USCM and the fallen marines of this ship. On the left there are grand tales of victory etched into the slab. On the right theres a list of famous marines who have fallen in combat servinmg the USCM."
	icon = 'icons/Marine/almayer_props64.dmi'
	icon_state = "ship_memorial"
	bound_x = 32
	bound_y = 96

/obj/structure/prop/almayer/particle_cannon
	name = "phased pulse particle cannon"
	desc = "The main guns of a ship. Who would have known?"
	icon = 'icons/obj/machines/artillery.dmi'

/obj/structure/prop/almayer/name_stencil
	desc = "The name of the ship stenciled on the hull."
	icon = 'icons/Marine/almayer_props64.dmi'
	icon_state = "almayer0"
	density = 0 //dunno who would walk on it, but you know.

	New()
		..()
		name = MAIN_SHIP_NAME

//---USS Almayer Computers ---//

/obj/machinery/computer/overwatch/almayer
	density = 0
	icon = 'icons/obj/almayer.dmi'
	icon_state = "overwatch"

/obj/machinery/computer/security/almayer
	density = 0
	icon = 'icons/obj/almayer.dmi'
	icon_state = "security"

/obj/machinery/computer/shuttle_control/dropship1
	name = "dropship console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	shuttle_tag = "Almayer Dropship 1"
	unacidable = 1
	exproof = 1
	req_one_access_txt = "22;200"

/obj/machinery/computer/shuttle_control/dropship1/onboard
	name = "flight controls"
	icon = 'icons/Marine/shuttle-parts.dmi'
	icon_state = "console"
	onboard = 1

/obj/machinery/computer/shuttle_control/dropship2
	name = "dropship console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	shuttle_tag = "Almayer Dropship 2"
	unacidable = 1
	exproof = 1
	req_one_access_txt = "12;22;200"

/obj/machinery/computer/shuttle_control/dropship2/onboard
	name = "flight controls"
	icon = 'icons/Marine/shuttle-parts.dmi'
	icon_state = "console"
	onboard = 1

//---USS Almayer Lights -----//

/obj/machinery/light/almayer/New()
	..()
	switch(dir)
		if(1)	pixel_y = 23
		if(4)	pixel_x = 10
		if(8)	pixel_x = -10

// the smaller bulb light fixture

/obj/machinery/light/small/almayer/New()
	..()
	switch(dir)
		if(1)	pixel_y = 23
		if(4)	pixel_x = 10
		if(8)	pixel_x = -10

/obj/machinery/camera/autoname/almayer
	icon = 'icons/obj/almayer.dmi'

	New()
		..()
		switch(dir)
			if(1)	pixel_y = 40
			if(2)	pixel_y = -18
			if(4)	pixel_x = -27
			if(8)	pixel_x = 27

//------APCs ------//

/obj/machinery/power/apc/almayer
	icon = 'icons/obj/almayer.dmi'
	cell_type = /obj/item/weapon/cell/high
//------ Air Alarms -----//

/obj/machinery/alarm/almayer
	icon = 'icons/obj/almayer.dmi' // I made these really quickly because idk where they have their new air alarm ~Art

	New()
		..()
		switch(dir)
			if(1) pixel_y = 25
			if(2) pixel_y = 25

//------USS Almayer Tables ------//
/obj/structure/table/almayer
	icon = 'icons/obj/almayer.dmi'
	icon_state = "table"

//------Dropship Cargo Doors -----//
/obj/machinery/door/airlock/multi_tile/almayer
	name = "dropship cargo door"
	opacity = 1
	width = 3

/obj/machinery/door/airlock/multi_tile/almayer/handle_multidoor()
	if(!(width > 1)) return //Bubblewrap

	for(var/i = 1, i < width, i++)
		if(dir in list(NORTH, SOUTH))
			var/turf/T = locate(x, y + i, z)
			T.SetOpacity(opacity)
		else if(dir in list(EAST, WEST))
			var/turf/T = locate(x + i, y, z)
			T.SetOpacity(opacity)

	if(dir in list(NORTH, SOUTH))
		bound_height = world.icon_size * width
	else if(dir in list(EAST, WEST))
		bound_width = world.icon_size * width

//We have to find these again since these doors are used on shuttles a lot so the turfs changes
/obj/machinery/door/airlock/multi_tile/almayer/proc/update_filler_turfs()

	for(var/i = 1, i < width, i++)
		if(dir in list(NORTH, SOUTH))
			var/turf/T = locate(x, y + i, z)
			T.SetOpacity(opacity)
		else if(dir in list(EAST, WEST))
			var/turf/T = locate(x + i, y, z)
			T.SetOpacity(opacity)

/obj/machinery/door/airlock/multi_tile/almayer/open()
	. = ..()
	update_filler_turfs()

/obj/machinery/door/airlock/multi_tile/almayer/close()
	. = ..()
	update_filler_turfs()

/obj/machinery/door/airlock/multi_tile/almayer/dropship1
	icon = 'icons/obj/doors/almayer/dropship1_cargo.dmi'

/obj/machinery/door/airlock/multi_tile/almayer/dropship2
	icon = 'icons/obj/doors/almayer/dropship2_cargo.dmi'

//------USS Almayer Door Section-----//
// This is going to be fucken huge. This is where all babeh perspective doors go to grow up.

/obj/machinery/door/airlock/almayer
	name = "airlock"
	icon = 'icons/obj/doors/almayer/comdoor.dmi' //Tiles with is here FOR SAFETY PURPOSES
	openspeed = 4 //shorter open animation.
	tiles_with = list(
		/turf/simulated/wall,
		/obj/structure/falsewall,
		/obj/structure/falserwall,
		/obj/structure/window/reinforced/almayer,
		/obj/machinery/door/airlock)

	New()
		spawn(10) // No fucken idea but this somehow makes it work. What the actual fuck.
			relativewall_neighbours()
		..()

/obj/machinery/door/poddoor/almayer
	icon = 'icons/obj/doors/almayer/blastdoors_shutters.dmi'
	openspeed = 4 //shorter open animation.
	tiles_with = list(
		/turf/simulated/wall,
		/obj/structure/falsewall,
		/obj/structure/falserwall,
		/obj/structure/window/reinforced/almayer,
		/obj/machinery/door/airlock)

	New()
		spawn(10) // No fucken idea but this somehow makes it work. What the actual fuck.
			relativewall_neighbours()
		..()

/obj/machinery/door/poddoor/shutters/almayer
	icon = 'icons/obj/doors/almayer/blastdoors_shutters.dmi'
	openspeed = 4 //shorter open animation.
	tiles_with = list(
		/turf/simulated/wall,
		/obj/structure/falsewall,
		/obj/structure/falserwall,
		/obj/structure/window/reinforced/almayer,
		/obj/machinery/door/airlock)

	New()
		spawn(10) // No fucken idea but this somehow makes it work. What the actual fuck.
			relativewall_neighbours()
		..()

/obj/machinery/door/airlock/almayer/security
	name = "airlock"
	icon = 'icons/obj/doors/almayer/secdoor.dmi'
	req_access_txt = "3"

/obj/machinery/door/airlock/almayer/security/glass
	name = "airlock"
	icon = 'icons/obj/doors/almayer/secdoor_glass.dmi'
	opacity = 0

/obj/machinery/door/airlock/almayer/command
	name = "command airlock"
	icon = 'icons/obj/doors/almayer/comdoor.dmi'
	req_access_txt = "19"

/obj/machinery/door/airlock/almayer/secure
	name = "secure airlock"
	icon = 'icons/obj/doors/almayer/securedoor.dmi'
	req_access_txt = "19"

/obj/machinery/door/airlock/almayer/maint
	name = "maintenance hatch"
	icon = 'icons/obj/doors/almayer/maintdoor.dmi'
	req_access_txt = "0"
	req_one_access_txt = "2;7"

/obj/machinery/door/airlock/almayer/engineering
	name = "engineering airlock"
	icon = 'icons/obj/doors/almayer/engidoor.dmi'
	opacity = 0
	req_access_txt = "0"
	req_one_access_txt = "2;7"

/obj/machinery/door/airlock/almayer/medical
	name = "medical airlock"
	icon = 'icons/obj/doors/almayer/medidoor.dmi'
	req_access_txt = "0"
	req_one_access_txt =  "2;8;19"

/obj/machinery/door/airlock/almayer/medical/glass
	name = "medical airlock"
	icon = 'icons/obj/doors/almayer/medidoor_glass.dmi'
	opacity = 0
	req_access_txt = "0"
	req_one_access_txt =  "2;8;19"

/obj/machinery/door/airlock/almayer/generic
	name = "airlock"
	icon = 'icons/obj/doors/almayer/personaldoor.dmi'

/obj/machinery/door/airlock/almayer/generic/corporate
	name = "corporate liason's quarters"
	icon = 'icons/obj/doors/almayer/personaldoor.dmi'
	req_access_txt = "200"

/obj/machinery/door/airlock/almayer/marine
	name = "airlock"
	icon = 'icons/obj/doors/almayer/prepdoor.dmi'
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/requisitions
	name = "requisitions"
	icon = 'icons/obj/doors/almayer/prepdoor.dmi'
	req_access_txt = "0"
	req_one_access_txt =  "2;21"
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/alpha
	name = "alpha squad prep room"
	icon = 'icons/obj/doors/almayer/prepdoor_alpha.dmi'
	req_access_txt = "9"
	req_one_access_txt =  "2;15"
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/alpha/sl
	name = "alpha squad leader prep"
	req_access_txt ="12;15"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/alpha/spec
	name = "alpha specialist prep"
	req_access_txt ="0"
	req_one_access_txt =  "13"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/alpha/engineer
	name = "alpha squad engineer prep"
	req_access_txt ="0"
	req_one_access_txt =  "11"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/alpha/medic
	name = "alpha squad medic prep"
	req_access_txt ="10;15"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/bravo
	name = "bravo squad prep room"
	icon = 'icons/obj/doors/almayer/prepdoor_bravo.dmi'
	req_access_txt = "9"
	req_one_access_txt =  "2;16"
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/bravo/sl
	name = "bravo squad leader prep"
	req_access_txt ="12;16"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/bravo/spec
	name = "bravo specialist prep"
	req_access_txt ="0"
	req_one_access_txt =  "13"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/bravo/engineer
	name = "bravo squad engineer prep"
	req_access_txt ="0"
	req_one_access_txt =  "11"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/bravo/medic
	name = "bravo squad medic prep"
	req_access_txt ="10;16"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/charlie
	name = "charlie squad prep room"
	icon = 'icons/obj/doors/almayer/prepdoor_charlie.dmi'
	req_access_txt = "9"
	req_one_access_txt =  "2;17"
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/charlie/sl
	name = "charlie squad leader prep"
	req_access_txt ="12;17"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/charlie/spec
	name = "charlie specialist prep"
	req_access_txt ="0"
	req_one_access_txt =  "13"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/charlie/engineer
	name = "charlie squad engineer prep"
	req_access_txt ="0"
	req_one_access_txt =  "11"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/charlie/medic
	name = "charlie squad medic prep"
	req_access_txt ="10;17"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/delta
	name = "delta squad prep room"
	icon = 'icons/obj/doors/almayer/prepdoor_delta.dmi'
	req_access_txt = "9"
	req_one_access_txt =  "2;18"
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/delta/sl
	name = "delta squad leader prep"
	req_access_txt ="12;18"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/delta/spec
	name = "delta specialist prep"
	req_access_txt ="0"
	req_one_access_txt =  "13"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/delta/engineer
	name = "delta squad engineer prep"
	req_access_txt ="0"
	req_one_access_txt =  "11"
	dir = 2
	opacity = 0

/obj/machinery/door/airlock/almayer/marine/delta/medic
	name = "delta squad medic prep"
	req_access_txt ="10;18"
	req_one_access_txt =  "0"
	dir = 2
	opacity = 0


// Double Doors

/obj/machinery/door/airlock/multi_tile/almayer
	name = "airlock"
	icon = 'icons/obj/doors/almayer/comdoor.dmi' //Tiles with is here FOR SAFETY PURPOSES
	openspeed = 4 //shorter open animation.
	tiles_with = list(
		/turf/simulated/wall,
		/obj/structure/falsewall,
		/obj/structure/falserwall,
		/obj/structure/window/reinforced/almayer,
		/obj/machinery/door/airlock)

	New()
		spawn(10) // No fucken idea but this somehow makes it work. What the actual fuck.
			relativewall_neighbours()
		..()

/obj/machinery/door/airlock/multi_tile/almayer/generic
	name = "airlock"
	icon = 'icons/obj/doors/almayer/2x1generic.dmi'
	opacity = 0

/obj/machinery/door/airlock/multi_tile/almayer/medidoor
	name = "airlock"
	icon = 'icons/obj/doors/almayer/2x1medidoor.dmi'
	opacity = 0
	req_access_txt = "0"
	req_one_access_txt =  "2;8;19"

/obj/machinery/door/airlock/multi_tile/almayer/comdoor
	name = "airlock"
	icon = 'icons/obj/doors/almayer/2x1comdoor.dmi'
	opacity = 0
	req_access_txt = "19"

/obj/machinery/door/firedoor/border_only/almayer
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas."
	icon = 'icons/obj/doors/almayer/purinadoor.dmi'
	openspeed = 4


//------- Cryobag Recycler -------//
// Wanted to put this in, but since we still have extra time until tomorrow and this is really simple thing. It just recycles opened cryobags to make it nice-r for medics.
// Also the lack of sleep makes me keep typing cyro instead of cryo. FFS ~Art

/obj/machinery/cryobag_recycler
	name = "cryogenic bag recycler"
	desc = "A small tomb like structure. Capable of taking in used and opened cryobags and refill the liner and attach new sealants."
	icon = 'icons/Marine/almayer_props.dmi'
	icon_state = "recycler"

	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 20

//What is this even doing? Why is it making a new item?
/obj/machinery/cryobag_recycler/attackby(obj/item/W, mob/user) //Hope this works. Don't see why not.
	..()
	if (istype(W, /obj/item))
		if(W.name == "used stasis bag") //possiblity for abuse, but fairly low considering its near impossible to rename something without VV
			var/obj/item/bodybag/cryobag/R = new /obj/item/bodybag/cryobag //lets give them the bag considering having it unfolded would be a pain in the ass.
			R.add_fingerprint(user)
			user.remove_from_mob(W)
			cdel(W)
			user.put_in_hands(R)
			r_TRU
	..()

/obj/structure/closet/basketball
	name = "athletic wardrobe"
	desc = "It's a storage unit for athletic wear."
	icon_state = "mixed"
	icon_closed = "mixed"

/obj/structure/closet/basketball/New()
	..()
	sleep(2)
	new /obj/item/clothing/under/shorts/grey(src)
	new /obj/item/clothing/under/shorts/black(src)
	new /obj/item/clothing/under/shorts/red(src)
	new /obj/item/clothing/under/shorts/blue(src)
	new /obj/item/clothing/under/shorts/green(src)