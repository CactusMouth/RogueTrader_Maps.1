/obj/item/clothing/head/familiarband
	name = "familiar's headband"
	desc = "It's a simple headband made of leather."
	icon_state = "familiarband"

/obj/item/clothing/under/familiargarb
	name = "familiar's garb"
	desc = "It looks like a cross between Robin Hood's tunic and some patchwork leather armor. Whoever put this together must have been in a hurry."
	icon_state = "familiartunic"
	armor = list(
		melee = ARMOR_MELEE_FLAK,
		laser = ARMOR_LASER_BASIC,
		energy = ARMOR_ENERGY_SMALL
	)

/obj/item/clothing/under/familiargarb/Initialize()
	. = ..()
	slowdown_per_slot[slot_w_uniform] = -2
