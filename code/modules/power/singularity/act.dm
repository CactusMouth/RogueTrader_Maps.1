#define I_SINGULO "singulo"

/**
 * Called when a singularity interacts with the atom.
 */
/atom/proc/singularity_act()
	return

/**
 * Called when a singularity attempts to pull the atom toward it.
 */
/atom/proc/singularity_pull(S, current_size)
	return

/mob/living/singularity_act()
	investigate_log("has been consumed by a singularity", I_SINGULO)
	gib()
	return 20

/mob/living/singularity_pull(S, current_size)
	step_towards(src, S)
	apply_damage(current_size * 3, DAMAGE_RADIATION, damage_flags = DAMAGE_FLAG_DISPERSED)

/mob/living/carbon/human/singularity_pull(S, current_size)
	if(current_size >= STAGE_THREE)
		for (var/obj/item/item as anything in GetAllHeld())
			if(prob(current_size*5) && item.w_class >= ((11-current_size)/2) && unEquip(item))
				step_towards(item, S)
				to_chat(src, SPAN_WARNING("\The [S] pulls \the [item] from your grip!"))
		if(!lying && (!shoes || !(shoes.item_flags & ITEM_FLAG_NOSLIP)) && (!species || !(species.check_no_slip(src))) && prob(current_size*5))
			to_chat(src, SPAN_DANGER("A strong gravitational force slams you to the ground!"))
			Weaken(current_size)
	..()

/obj/singularity_act()
	if(simulated)
		ex_act(EX_ACT_DEVASTATING)
		if(src)
			qdel(src)
		return 2

/obj/singularity_pull(S, current_size)
	if(simulated && !anchored)
		step_towards(src, S)

/obj/beam/singularity_pull()
	return

/obj/overlay/singularity_pull()
	return

/obj/item/singularity_pull(S, current_size)
	set waitfor = 0
	if(anchored)
		return
	sleep(0) //this is needed or multiple items will be thrown sequentially and not simultaneously
	if(current_size >= STAGE_FOUR)
		//throw_at(S, 14, 3)
		step_towards(src,S)
		sleep(1)
		step_towards(src,S)
	else if(current_size > STAGE_ONE)
		step_towards(src,S)
	else ..()

/obj/machinery/atmospherics/pipe/singularity_pull()
	return

/obj/machinery/power/supermatter/shard/singularity_act()
	qdel(src)
	return 5000

/obj/machinery/power/supermatter/singularity_act()
	qdel(src)
	return 50000

/obj/item/projectile/beam/emitter/singularity_pull()
	return

/obj/item/storage/backpack/holding/singularity_act(S, current_size)
	var/dist = max((current_size - 2), 1)
	explosion(src.loc, dist * 9)
	return 1000

/turf/singularity_act(S, current_size)
	if(!is_plating())
		for(var/obj/O in contents)
			if(O.level != ATOM_LEVEL_UNDER_TILE)
				continue
			if(O.invisibility == INVISIBILITY_ABSTRACT)
				O.singularity_act(src, current_size)
	ChangeTurf(get_base_turf_by_area(src))
	return 2

/turf/space/singularity_act()
	return

/*******************
* the Sovereign Act/Pull *
*******************/
/**
 * Whether or not a singularity can consume the atom.
 *
 *  Returns boolean.
 */
/atom/proc/singuloCanEat()
	return 1

/mob/observer/singuloCanEat()
	return 0

/mob/new_player/singuloCanEat()
	return 0
