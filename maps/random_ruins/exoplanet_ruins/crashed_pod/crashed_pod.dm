GLOBAL_LIST_INIT(crashed_pod_areas, new)

/datum/map_template/ruin/exoplanet/crashed_pod
	name = "crashed survival pod"
	id = "crashed_pod"
	description = "A crashed survival pod from a destroyed ship."
	suffixes = list("crashed_pod/crashed_pod.dmm")
	spawn_cost = 1
	player_cost = 0
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS | TEMPLATE_FLAG_NO_RADS
	ruin_tags = RUIN_HUMAN|RUIN_WRECK
	spawn_weight = 0.25

/area/map_template/crashed_pod
	name = "\improper Crashed Survival Pod"
	icon_state = "blue"

/singleton/submap_archetype/crashed_pod
	descriptor = "crashed survival pod"
	crew_jobs = list(/datum/job/submap/pod, /datum/job/submap/podnoble)

/datum/submap/crashed_pod/sync_cell(obj/overmap/visitable/cell)
	return

/datum/job/submap/podnoble
	title = "Kasrkin"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /singleton/hierarchy/outfit/job/survivor/kasrkin
	total_positions = 2
	alt_titles = list(
		"Catachan Devil" = /singleton/hierarchy/outfit/job/survivor/devil,
		"Interrogator" = /singleton/hierarchy/outfit/job/survivor/interrogator,
		"Sister - Sacred Rose" = /singleton/hierarchy/outfit/job/survivor/sister,
		"Sister - Martyred Lady" = /singleton/hierarchy/outfit/job/survivor/sister/martyr,
		"Sister - Repentia" = /singleton/hierarchy/outfit/job/survivor/sister/repentia,
		"Sister - Bloody Rose" = /singleton/hierarchy/outfit/job/survivor/sister/bloody,
		"Krieg Commissar" = /singleton/hierarchy/outfit/job/survivor/kriegcommi,
		"Commissar" = /singleton/hierarchy/outfit/job/survivor/commi,
	//	"Skitarii Alpha", add skit boy later
	)
	skill_points = 16
	min_skill = list(
		SKILL_COMBAT = SKILL_EXPERIENCED,
		SKILL_GUNS = SKILL_EXPERIENCED,
		SKILL_VIGOR = SKILL_EXPERIENCED,
	)

	max_skill = list(	SKILL_PILOT = SKILL_MASTER,
						SKILL_COMBAT = SKILL_PRIMARIS,
						SKILL_GUNS = SKILL_PRIMARIS,
						SKILL_VIGOR = SKILL_MASTER)

/datum/job/submap/podnoble/equip(mob/living/carbon/human/H)
	var/current_name = H.real_name
	var/current_title = trimtext(H.mind.role_alt_title)
	H.voice_in_head(pick(GLOB.lone_thoughts))
	H.fully_replace_character_name("[current_name]")
	if(current_title && (H.mind.role_alt_title in alt_titles))
		current_title = trimtext(H.mind.role_alt_title) // Use alt_title if selected
	else
		current_title = title // use default title
	if(current_title == "Catachan Devil" || current_title == "Interrogator" || current_title == "Sister - Sacred Rose" || current_title == "Sister - Martyred Lady" || current_title == "Sister - Repentia" || current_title == "Sister - Bloody Rose" || current_title == "Krieg Commissar" || current_title == "Commissar")
		if(current_title == "Kasrkin")
			to_chat(H,"<span class='danger'><b><font size=4>THE KASRKIN</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>The Astra Militarum, also known as the Imperial Guard in colloquial Low Gothic, is the largest coherent fighting force in the galaxy. They serve as the Imperium of Man's primary combat force and first line of defence from the myriad threats which endanger the existence of the Human race in the 41st Millennium. </font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>Elite stormtroopers of Cadia, expertly trained to confront the most formidable threats. They operate with precision and discipline, using superior tactics and advanced equipment. As the vanguard against Chaos, they exemplify bravery and unwavering commitment to the Emperor’s cause.</font></b></span>")
			if(prob(2))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(2))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.fully_replace_character_name("Lieutenant [current_name]")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.weaken_mod = 0.61
			H.species.stun_mod = 0.61
			H.species.slowdown = -0.5 // Kasrkin are renowned for incredible speed and the ability to scale any terrain, even mountains.
			H.species.silent_steps = TRUE
		if(current_title == "Catachan Devil")
			to_chat(H,"<span class='danger'><b><font size=4>THE CATACHAN DEVIL</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>The Astra Militarum, also known as the Imperial Guard in colloquial Low Gothic, is the largest coherent fighting force in the galaxy. They serve as the Imperium of Man's primary combat force and first line of defence from the myriad threats which endanger the existence of the Human race in the 41st Millennium. </font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>The deadliest jungle fighters of Catachan, trained to use the wild as a weapon. They thrive in brutal, close-quarters combat, excelling in ambushes, traps, and sabotage. Unflinching and resourceful, they embody the spirit of survival against overwhelming odds.</font></b></span>")
			if(prob(2))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(2))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.fully_replace_character_name("Major [current_name]")
			H.species.brute_mod = 0.6
			H.species.weaken_mod = 0.67
			H.species.stun_mod = 0.67 // Elite catachan. Borderline sly marbo.
			H.species.burn_mod = 0.6
			H.species.toxins_mod = 0.6
			H.species.slowdown = -0.2
			H.species.hunger_factor = DEFAULT_HUNGER_FACTOR * 1.25
			H.species.species_flags = SPECIES_FLAG_LOW_GRAV_ADAPTED
			H.species.silent_steps = TRUE
		if(current_title == "Sister - Sacred Rose")
			to_chat(H,"<span class='danger'><b><font size=4>THE SISTER OF BATTLE</font></b></span>") // add order variants
			to_chat(H, "<span class='notice'><b><font size=2>As a Sister of the Sacred Rose, your devotion to the God-Emperor shines with unshakable discipline. Known for composure under fire, you advance with the certainty of one held in faith’s embrace. You carry His light into the blackest of battles, bringing swift retribution in service to humanity’s salvation. You are the shield against the dark.</font></b></span>")
			if(prob(1))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(1))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.fully_replace_character_name("Palatine [current_name]")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.weaken_mod = 0.61
			H.species.stun_mod = 0.61
			H.species.slowdown = -0.2
		if(current_title == "Sister - Bloody Rose")
			to_chat(H,"<span class='danger'><b><font size=4>THE SISTER OF BATTLE</font></b></span>") // add order variants
			to_chat(H, "<span class='notice'><b><font size=2>You are a Sister of the Bloody Rose, renowned for ferocity in the Emperor's name. With unyielding wrath and blistering faith, you fight on the edge of reason, driving terror into the hearts of the heretic and unclean. Your chapter thrives in close combat, where your fervor is sharpened to a blade's edge. Only death will stay your righteous hand.</font></b></span>")
			if(prob(1))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(1))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.fully_replace_character_name("Seraphim [current_name]")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.weaken_mod = 0.61
			H.species.stun_mod = 0.61
			H.species.slowdown = -0.2
		if(current_title == "Sister - Martyred Lady")
			to_chat(H,"<span class='danger'><b><font size=4>THE SISTER OF BATTLE</font></b></span>") // add order variants
			to_chat(H, "<span class='notice'><b><font size=2>A Sister of Our Martyred Lady, you follow in the footsteps of saints fallen in service, wielding their memory as a weapon. Your order finds strength in sacrifice, growing fierce where others would falter. In battle, you honor their memory through merciless fury, defending the Imperium's faithful with relentless resolve, no matter the cost.</font></b></span>")
			if(prob(1))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(1))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.fully_replace_character_name("Palatine [current_name]")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.weaken_mod = 0.61
			H.species.stun_mod = 0.61
			H.species.slowdown = -0.2
		if(current_title == "Sister - Repentia")
			to_chat(H,"<span class='danger'><b><font size=4>THE SISTER OF BATTLE</font></b></span>") // add order variants
			to_chat(H, "<span class='notice'><b><font size=2>Fallen from grace, you walk the path of the Repentia, seeking redemption through suffering and unyielding faith. Cast out from the rank of your sisters, you’ve taken a sacred vow, bearing pain as penance and fighting without armor, relying on zeal alone to carry you through. Only in death might you be absolved, driven by the Emperor’s will to purge heresy and earn redemption through sacrifice.</font></b></span>")
			if(prob(8))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.species.brute_mod = 0.6
			H.species.burn_mod = 0.6
			H.species.weaken_mod = 0.51
			H.species.stun_mod = 0.51 // Warp touched. Supernaturally resistant to all damage.
			H.species.slowdown = -0.3
			H.species.toxins_mod = 0.6
			H.species.radiation_mod = 0.55
		if(current_title == "Interrogator")
			to_chat(H,"<span class='danger'><b><font size=4>THE INTERROGATOR</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>As the Interrogator you represent the Ordos... (Xenos/Malleus/Hereticus), you are part of a small remnant of operatives from a dying retinue, operating without the guidance of your Inquisitor after the vessel you were aboard was tragically destroyed.</font></b></span>")
			if(prob(8))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.slowdown = -0.3
			if(prob(60))
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/energy/lasgun/laspistol/hellpistol, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/sword/cutro/adamantine, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/flat/interrogator2, slot_l_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/cell/device/high/xenos, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/bountyhunter, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/bountyhead, slot_head)
			else if(prob(10))
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/slugrifle/scipio, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/pistol/slug/old, slot_r_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/flat/interrogator2, slot_l_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/armoredtrench, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/flak/ranger, slot_head)
			else if(prob(20))
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/boltrifle/lockebolter/drusian, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/pistol/bolt_pistol/drusian, slot_r_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/flat/interrogator1, slot_l_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/feudal/heavyplate, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/flak/doomguy, slot_head)
			else
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/energy/lasgun/hotshot/volkite, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/energy/lasgun/laspistol/militarum, slot_r_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/flat/interrogator2, slot_l_hand)
				H.equip_to_slot_or_store_or_drop(new /obj/item/cell/device/high/xenos, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/dustercarapace, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/flak/ranger/alt, slot_head)

		if(current_title == "Commissar")
			to_chat(H,"<span class='danger'><b><font size=4>THE DESERTER</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>Fearless enforcers of Imperial will, Commissars lead troops with unwavering authority. They ensure discipline and morale through inspirational speeches and, when necessary, harsh consequences. Their presence bolsters resolve, reminding soldiers that victory is the only option.</font></b></span>")
			if(prob(1))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(1))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.slowdown = -0.3
		if(current_title == "Krieg Commissar")
			to_chat(H,"<span class='danger'><b><font size=4>THE DESERTER</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>You are an apprentice of the Inquisition, skilled in the brutal arts of persuasion and intimidation. Operating independently, you extract vital information from heretics, mutants, and xenos without mercy. In the shadows, you rely on cunning and resourcefulness, knowing that no cost is too great and no sacrifice too severe in the service of the Emperor.</font></b></span>")
			if(prob(5))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			H.species.brute_mod = 0.7
			H.species.burn_mod = 0.7
			H.species.toxins_mod = 0.65
			H.species.radiation_mod = 0.45
			H.species.darksight_range = 4
			H.species.hunger_factor = DEFAULT_HUNGER_FACTOR * 0.75
			H.species.species_flags = SPECIES_FLAG_NO_PAIN
	return ..()

/datum/job/submap/pod
	title = "Mercenary"
	info = "Your ship has been destroyed by a terrible disaster."
	outfit_type = /singleton/hierarchy/outfit/job/survivor
	total_positions = 2
	alt_titles = list(
		"Bounty Hunter",
		"Deserter",
		"Heretek",
	)
	skill_points = 22
	min_skill = list(
		SKILL_PILOT = SKILL_BASIC,
		SKILL_MEDICAL = SKILL_BASIC,
		SKILL_ELECTRICAL = SKILL_BASIC,
	)

	max_skill = list(	SKILL_CONSTRUCTION = SKILL_MASTER,
						SKILL_DEVICES = SKILL_MASTER,
						SKILL_COMPUTER = SKILL_MASTER,
						SKIL_ELECTRICAL = SKILL_MASTER,
						SKILL_ENGINES = SKILL_MASTER,
						SKILL_ATMOS = SKILL_MASTER,
						SKILL_PILOT = SKILL_MASTER,
						SKILL_COMBAT = SKILL_MASTER,
						SKILL_GUNS = SKILL_MASTER,
						SKILL_VIGOR = SKILL_MASTER)

/datum/job/submap/pod/equip(mob/living/carbon/human/H)
	var/current_name = H.real_name
	var/current_title = trimtext(H.mind.role_alt_title)
	H.voice_in_head(pick(GLOB.lone_thoughts))
	H.fully_replace_character_name("[current_name]")
	if(current_title && (H.mind.role_alt_title in alt_titles))
		current_title = trimtext(H.mind.role_alt_title) // Use alt_title if selected
	else
		current_title = title // use default title
	if(current_title == "Mercenary" || current_title == "Bounty Hunter" || current_title == "Deserter" || current_title == "Heretek")
		if(current_title == "Mercenary")
			to_chat(H,"<span class='danger'><b><font size=4>THE MERCENARY</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>As the Mercenary aboard the Demeter, you’re a passenger seeking new contracts in the Ghoul Stars. Once a soldier, you now sell your skills to the highest bidder, always on the lookout for lucrative opportunities that finally lead to an early retirement.</font></b></span>")
			if(prob(8))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(8))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.species.brute_mod = 0.7
			H.species.hunger_factor = DEFAULT_HUNGER_FACTOR * 1.15
			H.equip_to_slot_or_store_or_drop(new /obj/item/pen/fancy/quill, slot_in_backpack)
			H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/knife/bowie, slot_belt)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/under/tactical, slot_w_uniform)
			H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/flat, slot_back)
			if(prob(20))
				if(prob(50))
					H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/flakcuirass, slot_wear_suit)
				else
					H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/heavyflak, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/flak/ranger, slot_head)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/autogun/krieg, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/autogun/ap, slot_in_backpack)
			else if(prob(25))
				if(prob(50))
					H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/carapacecuirass, slot_wear_suit)
				else
					H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/carapace, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/autogun/stubber, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/autogunheavy, slot_in_backpack)
			else if(prob(20))
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/flak/ranger/alt, slot_head)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/carapace3, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/slugrifle, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/heavy/ap, slot_in_backpack)
			else
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/scrapforged/carapace2, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/heavysniper/boltaction/imperial/crucible, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/speedloader/clip/stub/ap, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/speedloader/clip/stub/ms, slot_in_backpack)
		if(current_title == "Tribal")
			to_chat(H,"<span class='danger'><b><font size=4>THE TRIBAL</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>As the Tribal, you’re tasked with leading the way on deadly planets and through uncharted terrain, scouring every grim corner for threats and relics.</font></b></span>")
			H.equip_to_slot_or_store_or_drop(new /obj/item/pen/fancy/quill, slot_in_backpack)
			H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/knife/glaive, slot_belt)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/under/abaya, slot_w_uniform)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/hevhelm/bone, slot_head)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/tribal/plate, slot_wear_suit)
			if(prob(4))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(40))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			if(prob(40))
				H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/axe/spear/adamantine, slot_belt)
			else
				if(prob(30))
					H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/axe/saintie/adamantine, slot_belt)
				else
					H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/sword/chopper/heavy/adamantine, slot_belt)
		if(current_title == "Bounty Hunter")
			to_chat(H,"<span class='danger'><b><font size=4>THE BOUNTY HUNTER</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>As the Bounty Hunter aboard the Demeter, you are adrift after your last client met an untimely demise on the ship. With your skills underutilized, you now navigate the dangerous Ghoul Stars, seeking new contracts and opportunities to reclaim your place in the hunt.</font></b></span>")
			H.species.brute_mod = 0.7
			H.species.weaken_mod = 0.71
			H.species.stun_mod = 0.71
			H.species.hunger_factor = DEFAULT_HUNGER_FACTOR * 0.75
			H.equip_to_slot_or_store_or_drop(new /obj/item/pen/fancy/quill, slot_in_backpack)
			H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/knife, slot_belt)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/bountyhunter, slot_wear_suit)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/pilgrimhelm/bountyhead, slot_head)
			H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/leather, slot_back)
			if(prob(50))
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/under/rank/victorian, slot_w_uniform)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/revolver/imperial, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/revolver/imperial/heavy, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/speedloader/revolver, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/speedloader, slot_in_backpack)
			else
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/under/rank/victorian/redbl, slot_w_uniform)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/revolver/imperial/heavy/mateba, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/speedloader/revolver/ms, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/ammo_magazine/speedloader/revolver/ms, slot_in_backpack)
		if(current_title == "Deserter")
			to_chat(H,"<span class='danger'><b><font size=4>THE DESERTER</font></b></span>")
			to_chat(H, "<span class='notice'><b><font size=2>As the Deserter aboard the Demeter, you've abandoned the PDF in search of fortune as a mercenary. Once loyal to the captain, your knowledge of Militarum codes and procedures now serves you as you navigate the dangerous life of a hired gun.</font></b></span>")
			if(prob(12))
				H.make_genestealer()
				to_chat(H, "<span class='notice'><b><font size=2>You are a genestealer bioform, a unique strain of tyranid genestealer capable of rapid transformation. The swarm considers you to be an abomination, but under the guidance of what you believe to be the true hivemind, you will surely succeed where the others have failed. Everything is connected.</font></b></span>")
			else if(prob(12))
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				to_chat(H,"<span class='danger'><b><font size=4>YOUR CULT ITEMS ARE BEING SUMMONED. FIND SOMEWHERE PRIVATE TO HIDE. SUMMONING IN SIXTY SECONDS</font></b></span>")
				spawn(65 SECONDS)
				GLOB.cult.add_antagonist(H.mind, ignore_role = 1, do_not_equip = 0)
				to_chat(H, "<span class='notice'><b><font size=2>You are a heretical cultist loyal to one or more of the Chaos Gods -- unlike the many pretenders you are truly blessed by the warp and can survive encounters that would boil the brains of most mortal men.</font></b></span>")
			H.species.brute_mod = 0.7
			H.equip_to_slot_or_store_or_drop(new /obj/item/pen/fancy/quill, slot_in_backpack)
			H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/knife, slot_belt)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/under/guard/uniform, slot_w_uniform)
			H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/warfare/heavy, slot_back)
			H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/flat/deserter, slot_l_hand) // has gloves, mask, shoes and detpack
			if(prob(5))
				H.equip_to_slot_or_store_or_drop(new /obj/item/card/emag, slot_in_backpack)
			else if(prob(10))
				H.equip_to_slot_or_store_or_drop(new /obj/item/device/radio_jammer, slot_in_backpack)
			if(prob(40))
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/flak/conscript/pdf, slot_head)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/cadian/conscript/pdf, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/energy/lasgun/kantrael, slot_belt)
			else if(prob(25))
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/flak/conscript/pdf/medic, slot_head)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/cadian/conscript/medic, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/assault_rifle, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/storage/firstaid/adv, slot_in_backpack)
			else if(prob(35))
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/flak/conscript/pdf/heavy, slot_head)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/cadian/conscript/heavy, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/projectile/automatic/autogun/stubber, slot_belt)
			else
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/helmet/flak/conscript/pdf/capt, slot_head)
				H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/cadian/conscript/captain, slot_wear_suit)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/energy/lasgun/laspistol/hellpistol, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/gun/energy/lasgun/laspistol/lucius, slot_belt)
				H.equip_to_slot_or_store_or_drop(new /obj/item/cell/device/high/laspack, slot_in_backpack)
		if(current_title == "Heretek")
			to_chat(H,"<span class='danger'><b><font size=4>THE HERETEK</font></b></span>")
			H.species.cold_level_1 = SYNTH_COLD_LEVEL_1
			H.species.cold_level_2 = SYNTH_COLD_LEVEL_2
			H.species.cold_level_3 = SYNTH_COLD_LEVEL_3
			H.species.heat_level_1 = 600
			H.species.heat_level_2 = 700
			H.species.heat_level_3 = 2000
			H.species.hazard_high_pressure = HAZARD_HIGH_PRESSURE * 0.4
			H.species.hazard_low_pressure = -1
			H.species.brute_mod = 0.8 // This particular tech priest is weaker then most humans.
			H.species.burn_mod = 0.8
			H.species.toxins_mod = 0.8
			H.species.radiation_mod = 0.6
			H.species.hunger_factor = DEFAULT_HUNGER_FACTOR * 0.5
			H.species.species_flags = SPECIES_FLAG_LOW_GRAV_ADAPTED | SPECIES_FLAG_NO_EMBED
			H.equip_to_slot_or_store_or_drop(new /obj/item/pen/fancy/quill, slot_in_backpack)
			H.equip_to_slot_or_store_or_drop(new /obj/item/material/twohanded/ravenor/knife, slot_belt)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/suit/armor/grim/mechanicus, slot_wear_suit)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/head/hardhat/techpriest, slot_head)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/mask/gas/techpriest, slot_wear_mask)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/shoes/jackboots/skitshoes/techpriest, slot_shoes)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/under/rank/engineer, slot_w_uniform)
			H.equip_to_slot_or_store_or_drop(new /obj/item/clothing/gloves/thick/swat/techpriest, slot_gloves)
			H.equip_to_slot_or_store_or_drop(new /obj/item/storage/backpack/satchel/warfare/techpriest, slot_back)
			if(prob(50))
				H.equip_to_slot_or_store_or_drop(new /obj/item/device/augment_implanter/wrist_blade, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/organ/internal/augment/active/iatric_monitor, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/organ/internal/augment/active/internal_air_system, slot_in_backpack)
			else
				H.equip_to_slot_or_store_or_drop(new /obj/item/device/augment_implanter/popout_shotgun, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/organ/internal/augment/active/polytool/engineer, slot_in_backpack)
				H.equip_to_slot_or_store_or_drop(new /obj/item/implant/translator, slot_in_backpack)
	return ..()



/singleton/hierarchy/outfit/job/survivor
	name = OUTFIT_JOB_NAME("Survivor")
	l_ear = null
	r_ear = null
	uniform = null
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/thick
	belt = null
	hierarchy_type = /singleton/hierarchy/outfit/job/survivor
	id_types = null
	pda_type = /obj/item/modular_computer/pda
	backpack_contents = list(/obj/item/spacecash/bundle/c1000 = 1)

/singleton/hierarchy/outfit/job/survivor/devil
	name = OUTFIT_JOB_NAME("Catachan Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/rank/catachan
	suit = /obj/item/clothing/suit/armor/grim/catachan/sergeant
	suit_store = /obj/item/gun/projectile/automatic/slugrifle
	head = /obj/item/clothing/head/helmet/guardcap/catachan
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/thick
	belt = /obj/item/gun/projectile/revolver/imperial/heavy/mateba
	back = /obj/item/storage/backpack/satchel/warfare
	id_types = /obj/item/card/id/torch/crew/security
	pda_type = /obj/item/modular_computer/pda
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/trench = 1, /obj/item/ammo_magazine/speedloader/revolver/ms = 2, /obj/item/ammo_magazine/heavy/kp = 1)

/singleton/hierarchy/outfit/job/survivor/kasrkin
	name = OUTFIT_JOB_NAME("Kasrkin Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/cadian_uniform
	suit = /obj/item/clothing/suit/armor/kasrkin
	suit_store = /obj/item/gun/energy/lasgun/hotshot/masterwork
	head = /obj/item/clothing/head/helmet/flak/kasrkin
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/thick/combat
	belt = /obj/item/gun/energy/lasgun/laspistol/militarum
	back = /obj/item/storage/backpack/satchel/warfare
	id_types = /obj/item/card/id/torch/crew/security
	pda_type = /obj/item/modular_computer/pda
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/trench = 1, /obj/item/cell/device/high/laspack = 1, /obj/item/cell/device/high/laspack/hotshot = 1)

/singleton/hierarchy/outfit/job/survivor/interrogator
	name = OUTFIT_JOB_NAME("Interrogator Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/rank/victorian
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots/noble
	gloves = /obj/item/clothing/gloves/thick/combat
	back = /obj/item/storage/backpack/satchel/leather/black
	id_types = /obj/item/card/id/syndicate
	pda_type = /obj/item/modular_computer/pda/security
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/implant/translator = 1, /obj/item/material/twohanded/ravenor/knife/trench = 1)

/singleton/hierarchy/outfit/job/survivor/commi
	name = OUTFIT_JOB_NAME("Commissar Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/cadian_uniform
	suit = /obj/item/clothing/suit/armor/grim/commissar
	suit_store = /obj/item/material/twohanded/ravenor/sword/commisword
	head = /obj/item/clothing/head/helmet/guardcap/commissar
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/thick/combat
	belt = /obj/item/gun/energy/plasma/pistol/mechanicus
	back = /obj/item/storage/backpack/satchel/warfare
	id_types = /obj/item/card/id/torch/crew/security
	pda_type = /obj/item/modular_computer/pda
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/trench = 1, /obj/item/cell/device/high/mechanicus = 1)

/singleton/hierarchy/outfit/job/survivor/kriegcommi
	name = OUTFIT_JOB_NAME("Krieg Commissar Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/rank/krieg_uniform
	mask = /obj/item/clothing/mask/gas/krieg
	suit = /obj/item/clothing/suit/armor/grim/commissar/krieg
	suit_store = /obj/item/material/twohanded/ravenor/chainsword/guard
	head = /obj/item/clothing/head/helmet/guardcap/commissar
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots/krieg
	gloves = /obj/item/clothing/gloves/thick/swat/krieg
	belt = /obj/item/gun/energy/lasgun/laspistol/hellpistol
	back = /obj/item/storage/backpack/satchel/krieger
	id_types = /obj/item/card/id/torch/crew/security
	pda_type = /obj/item/modular_computer/pda
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/trench = 1, /obj/item/cell/device/high/mechanicus = 1)

/singleton/hierarchy/outfit/job/survivor/sister
	name = OUTFIT_JOB_NAME("Sister Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/guard/uniform/sisterofbattle
	suit = /obj/item/clothing/suit/armor/sister/sacredrosepower
	suit_store = /obj/item/gun/projectile/automatic/boltrifle/lockebolter/sister
	head = /obj/item/clothing/head/helmet/sisterofbattle
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots/sisterofbattle
	gloves = /obj/item/clothing/gloves/thick/swat/sister
	belt = /obj/item/gun/projectile/pistol/bolt_pistol/sob
	back = /obj/item/storage/backpack/satchel/warfare/sisterofbattle
	id_types = /obj/item/card/id/medical
	pda_type = /obj/item/modular_computer/pda/medical
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/bowie = 1, /obj/item/ammo_magazine/bolt_rifle_magazine/sister = 1, /obj/item/ammo_magazine/bolt_pistol_magazine = 2)

/singleton/hierarchy/outfit/job/survivor/sister/bloody
	name = OUTFIT_JOB_NAME("Bloody Sister Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/guard/uniform/sisterofbattle
	suit = /obj/item/clothing/suit/armor/sister/bloodyrosepower
	suit_store = /obj/item/gun/projectile/automatic/boltrifle/lockebolter/sister
	head = /obj/item/clothing/head/helmet/sisterofbattle/brsister
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots/sisterofbattle/brsister
	gloves = /obj/item/clothing/gloves/thick/swat/sister
	belt = /obj/item/material/twohanded/ravenor/chainsword/relic
	back = /obj/item/storage/backpack/satchel/warfare/sisterofbattle/brsister
	id_types = /obj/item/card/id/medical
	pda_type = /obj/item/modular_computer/pda/medical
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/bowie = 1, /obj/item/ammo_magazine/bolt_rifle_magazine/sister = 2)

/singleton/hierarchy/outfit/job/survivor/sister/martyr
	name = OUTFIT_JOB_NAME("Martyred Sister Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/guard/uniform/sisterofbattle
	suit = /obj/item/clothing/suit/armor/sister/martyredpower
	suit_store = /obj/item/gun/projectile/automatic/boltrifle/lockebolter/sister
	head = /obj/item/clothing/head/helmet/sisterofbattle/mlsister
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots/sisterofbattle/mlsister
	gloves = /obj/item/clothing/gloves/thick/swat/sister
	belt = /obj/item/material/twohanded/ravenor/sword/broadsword/adamantine
	back = /obj/item/storage/backpack/satchel/warfare/sisterofbattle/mlsister
	id_types = /obj/item/card/id/medical
	pda_type = /obj/item/modular_computer/pda/medical
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/bowie = 1, /obj/item/ammo_magazine/bolt_rifle_magazine/sister = 2)

/singleton/hierarchy/outfit/job/survivor/sister/repentia
	name = OUTFIT_JOB_NAME("Repentia Survivor")
	l_ear = /obj/item/device/radio/headset/headset_sec
	r_ear = null
	uniform = /obj/item/clothing/under/guard/uniform/sisterofbattle/repentia
	suit = /obj/item/clothing/suit/armor/sister/repentia
	l_hand = /obj/item/material/twohanded/ravenor/axe/spear/fuscina/adamantine
	head = /obj/item/clothing/head/helmet/sisterofbattle/repentia
	r_pocket = /obj/item/device/radio/map_preset/pod
	l_pocket = /obj/item/device/flashlight/lantern
	shoes = /obj/item/clothing/shoes/jackboots/sisterofbattle/repentia
	gloves = null
	belt = /obj/item/material/twohanded/ravenor/chainsword/relic
	back = /obj/item/storage/backpack/satchel/leather/black
	id_types = /obj/item/card/id/medical
	pda_type = /obj/item/modular_computer/pda/medical
	backpack_contents = list(/obj/item/pen/fancy/quill = 1, /obj/item/material/twohanded/ravenor/knife/bowie = 1)



/datum/job/submap/pod/New(datum/submap/_owner, abstract_job = FALSE)
	..()
	if(_owner) // Might be called from admin tools, etc
		info = "Your ship, the [_owner.name], has been destroyed by a terrible disaster, \
		leaving you stranded in your survival pod on a hostile exoplanet. Your pod's distress \
		signal appear to be malfunctioning. All you can do now is survive, and hope for a passing ship..."

/obj/submap_landmark/spawnpoint/crashed_pod_survivor
	name = "Stranded Survivor"

/obj/submap_landmark/spawnpoint/crashed_pod_survivor
	name = "Stranded Survivor"

/obj/submap_landmark/joinable_submap/crashed_pod
	name = "Crashed Survival Pod"
	archetype = /singleton/submap_archetype/crashed_pod
	submap_datum_type = /datum/submap/crashed_pod

/obj/item/device/radio/map_preset/pod
	preset_name = "Pod"

/obj/item/device/radio/intercom/map_preset/pod
	preset_name = "Pod"

/obj/item/device/encryptionkey/map_preset/pod
	preset_name = "Pod"
	icon_state = "cargo_cypherkey"

/obj/item/device/radio/headset/map_preset/pod
	preset_name = "Pod"
	encryption_key = /obj/item/device/encryptionkey/map_preset/pod

/obj/submap_landmark/joinable_submap/crashed_pod/New()
	var/list/possible_ship_names = list(
	"Grimtalon",		"Bloodsting",	"Voidstrider",
	"Deathglaive",		"Hexwraith",	"Corpsefly",
	"Blightwing",		"Rotfang",		"Shadowwasp",
	"Carrionwing",		"Gravemoth",	"Warhawk",
	"Rustmantis",		"Steelhorn",	"Black Sigil",
	"Goreseeker",		"Rotmaw",		"Boneharrier",
	"Archfiend",		"Wraithcall",	"Terrorhawk",
	"Soulripper",		"Vile Seraph",	"Venomhorn")
	name = "[pick(possible_ship_names)]"
	..()
