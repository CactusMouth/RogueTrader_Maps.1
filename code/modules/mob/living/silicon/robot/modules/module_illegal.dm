/obj/item/robot_module/syndicate
	name = "illegal robot module"
	display_name = "Illegal"
	hide_on_manifest = 1
	upgrade_locked = TRUE
	sprites = list(
		"Dread" = "securityrobot"
	)
	equipment = list(
		/obj/item/device/flash,
		/obj/item/melee/energy/sword,
		/obj/item/gun/energy/tau/pulserifle,
		/obj/item/crowbar,
		/obj/item/card/emag,
		/obj/item/tank/jetpack/carbondioxide
	)
	var/id
	access = list(
		access_syndicate
	)
	use_map_synth_access = FALSE

/obj/item/robot_module/syndicate/Initialize()
	for(var/singleton/hierarchy/skill/skill in GLOB.skills)
		skills[skill.type] = SKILL_EXPERIENCED
	. = ..()

/obj/item/robot_module/syndicate/build_equipment(mob/living/silicon/robot/R)
	. = ..()
	id = R.idcard
	equipment += id

/obj/item/robot_module/syndicate/finalize_equipment(mob/living/silicon/robot/R)
	var/obj/item/tank/jetpack/carbondioxide/jetpack = locate() in equipment
	R.internals = jetpack
	. = ..()

/obj/item/robot_module/syndicate/Destroy()
	equipment -= id
	id = null
	. = ..()
