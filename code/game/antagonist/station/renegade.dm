GLOBAL_DATUM_INIT(renegades, /datum/antagonist/renegade, new)

/datum/antagonist/renegade
	role_text = "Renegade"
	role_text_plural = "Renegades"
	blacklisted_jobs = list(/datum/job/ai, /datum/job/submap)
	restricted_jobs = list(/datum/job/enforcer, /datum/job/enforcer_sergeant, /datum/job/rogue_trader, /datum/job/seneschal, /datum/job/guard_captain, /datum/job/magos_explorator, /datum/job/rd, /datum/job/magos_biologis)
	welcome_text = "Something's going to go wrong today, you can just feel it. You're paranoid, you've got a gun, and you're going to survive."
	antag_text = {"\
	<p>You are a <b>minor</b> antagonist! Make sure <b>you</b> survive the round at any cost.</p> \
	<p>Betray friends, make deals with enemies, and keep your gun handy. \
	You aren't here to go looking for trouble - but if <i>it</i> finds <i>you</i>, kill it.</p> \
	<p>Remember that the rules still apply to antagonists - Chat with staff before taking extreme actions.</p>
	"}

	id = MODE_RENEGADE
	flags = ANTAG_SUSPICIOUS | ANTAG_IMPLANT_IMMUNE | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	hard_cap = 3
	hard_cap_round = 5

	initial_spawn_req = 1
	initial_spawn_target = 3
	antaghud_indicator = "hud_renegade"
	skill_setter = /datum/antag_skill_setter/station/renegade

	var/list/spawn_guns = list(
		/obj/item/gun/energy/lasgun/accatran,
		/obj/item/gun/energy/lasgun/accatran,
		/obj/item/gun/energy/lasgun/accatran,
		/obj/item/gun/energy/plasma,
		/obj/item/gun/projectile/automatic/autogun,
		/obj/item/gun/projectile/automatic/autogun,
		/obj/item/gun/energy/tau/pulserifle,
		/obj/item/gun/projectile/pistol/slug,
		/obj/item/gun/projectile/pistol/slug,
		/obj/item/gun/projectile/pistol/holdout,
		/obj/item/gun/projectile/revolver/imperial,
		/obj/item/gun/projectile/revolver/imperial,
		/obj/item/gun/projectile/shotgun/doublebarrel/sawn,
		/obj/item/gun/projectile/pistol/slug,
		/obj/item/gun/projectile/revolver/imperial/holdout,
		/obj/item/gun/projectile/pistol/slug/old,
		/obj/item/gun/projectile/automatic/radcarbine/radpistol,
		/obj/item/gun/energy/plasma/pistol/archeotech,
		/obj/item/gun/energy/lasgun/hotshot/volkite,
		/obj/item/gun/projectile/pistol/magnum_pistol
		)

/datum/antagonist/renegade/create_objectives(datum/mind/player)

	if(!..())
		return

	var/datum/objective/survive/survive = new
	survive.owner = player
	player.objectives |= survive

/datum/antagonist/renegade/equip(mob/living/carbon/human/player)

	if(!..())
		return

	var/gun_type = pick(spawn_guns)
	if(islist(gun_type))
		gun_type = pick(gun_type)
	var/obj/item/gun = new gun_type(get_turf(player))

	// Attempt to put into a container.
	if(player.equip_to_storage(gun))
		return

	// If that failed, attempt to put into any valid non-handslot
	if(player.equip_to_appropriate_slot(gun))
		return

	// If that failed, then finally attempt to at least let the player carry the weapon
	player.put_in_hands(gun)


/proc/rightandwrong()
	to_chat(usr, "<B>You summoned guns!</B>")
	message_admins("[key_name_admin(usr, 1)] summoned guns!")
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == 2 || !(H.client)) continue
		if(is_special_character(H)) continue
		GLOB.renegades.add_antagonist(H.mind)
