/datum/species/human/cult
	name = "Cult"
	spawn_flags = SPECIES_IS_RESTRICTED
	brute_mod = 1
	burn_mod = 1
	species_flags = SPECIES_FLAG_NO_SCAN
	force_cultural_info = list(
		TAG_CULTURE =   CULTURE_CULTIST,
		TAG_HOMEWORLD = HOME_SYSTEM_STATELESS,
		TAG_FACTION =   FACTION_OTHER
	)

/datum/species/human/cult/handle_death(mob/living/carbon/human/H)
	spawn(1)
		if(H)
			H.dust()
