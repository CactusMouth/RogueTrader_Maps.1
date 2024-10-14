/datum/map/torch
	species_to_job_whitelist = list(
		/datum/species/adherent = list(/datum/job/ai, /datum/job/cyborg, /datum/job/assistant, /datum/job/chamber_assistant, /datum/job/chamber_magister, /datum/job/pilgrim,
										/datum/job/tech_priest, /datum/job/roboticist, /datum/job/pharmacologis, /datum/job/scientist_assistant, /datum/job/scientist, /datum/job/shuttle_pilot,
										/datum/job/unexpected_guest),
		/datum/species/nabber = list(/datum/job/ai, /datum/job/cyborg, /datum/job/chamber_assistant, /datum/job/scientist_assistant, /datum/job/pharmacologis,
									 /datum/job/roboticist, /datum/job/pilgrim, /datum/job/chamber_magister, /datum/job/tech_priest, /datum/job/medicae),
		/datum/species/vox = list(/datum/job/ai, /datum/job/cyborg),
		/datum/species/kroot = list(/datum/job/mercenary), // Whitelist mercs here
		/datum/species/human/mule = list(/datum/job/ai, /datum/job/cyborg, /datum/job/merchant)
	)

#define HUMAN_ONLY_JOBS /datum/job/rogue_trader, /datum/job/seneschal, /datum/job/void_officer, /datum/job/shuttle_pilot, /datum/job/magos_explorator, /datum/job/data_smith, /datum/job/tech_priest, /datum/job/bondsman, /datum/job/guard_captain, /datum/job/enforcer, /datum/job/enforcer_sergeant, /datum/job/guardsman, /datum/job/magos_biologis, /datum/job/sister_hospitaller, /datum/job/pharmacologis, /datum/job/medicae, /datum/job/noble_guest, /datum/job/unexpected_guest, /datum/job/deck_scum, /datum/job/chaplain_militant, /datum/job/chamber_magister, /datum/job/chamber_assistant, /datum/job/merchant
	species_to_job_blacklist = list(
		/datum/species/kroot  = list(HUMAN_ONLY_JOBS),
		/datum/species/kroot/yeosa = list(HUMAN_ONLY_JOBS), // Only kroot can be crew for now.
		/datum/species/tau  = list(HUMAN_ONLY_JOBS, /datum/job/mercenary),
		/datum/species/machine = list(HUMAN_ONLY_JOBS, /datum/job/mercenary),
		/datum/species/diona   = list(HUMAN_ONLY_JOBS, /datum/job/mercenary),
	)
#undef HUMAN_ONLY_JOBS

	allowed_jobs = list(
		/datum/job/rogue_trader, /datum/job/seneschal, /datum/job/void_officer, /datum/job/shuttle_pilot, /datum/job/mercenary,
		/datum/job/magos_explorator, /datum/job/data_smith, /datum/job/tech_priest, /datum/job/bondsman,
		/datum/job/guard_captain, /datum/job/enforcer, /datum/job/enforcer_sergeant, /datum/job/guardsman,
		/datum/job/magos_biologis, /datum/job/sister_hospitaller, /datum/job/pharmacologis, /datum/job/medicae, // Add juniormedicae later
		/datum/job/noble_guest, /datum/job/unexpected_guest, /datum/job/deck_scum,
		/datum/job/chaplain_militant, /datum/job/chamber_magister, /datum/job/chamber_assistant,
		/datum/job/merchant
	)

	access_modify_region = list(
		ACCESS_REGION_SECURITY = list(access_change_ids),
		ACCESS_REGION_MEDBAY = list(access_change_ids),
		ACCESS_REGION_RESEARCH = list(access_change_ids),
		ACCESS_REGION_ENGINEERING = list(access_change_ids),
		ACCESS_REGION_COMMAND = list(access_change_ids),
		ACCESS_REGION_GENERAL = list(access_change_ids),
		ACCESS_REGION_SUPPLY = list(access_change_ids),
		ACCESS_REGION_SERVICE = list(access_change_ids)
	)

/datum/map/torch/setup_job_lists()
	for(var/job_type in allowed_jobs)
		var/datum/job/job = SSjobs.get_by_path(job_type)
		// Most species are restricted from Imperial security and command roles
		if(job && (job.department_flag & COM) && length(job.allowed_branches) && !(/datum/mil_branch/civilian in job.allowed_branches))
			for(var/species_name in list(SPECIES_IPC, SPECIES_TAU, SPECIES_KROOT))
				var/datum/species/S = all_species[species_name]
				var/species_blacklist = species_to_job_blacklist[S.type]
				if(!species_blacklist)
					species_blacklist = list()
					species_to_job_blacklist[S.type] = species_blacklist
				species_blacklist |= job.type

// Some jobs for nabber grades defined here due to map-specific job datums.
/singleton/cultural_info/culture/nabber/New()
	LAZYADD(valid_jobs, /datum/job/scientist_assistant)
	..()

/singleton/cultural_info/culture/nabber/b/New()
	LAZYADD(valid_jobs, /datum/job/pilgrim)
	..()

/singleton/cultural_info/culture/nabber/a/New()
	LAZYADD(valid_jobs, /datum/job/tech_priest)
	..()

/singleton/cultural_info/culture/nabber/a/plus/New()
	LAZYADD(valid_jobs, /datum/job/medicae)
	..()

/datum/job
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ
	)
	required_language = LANGUAGE_HIGH_GOTHIC

/datum/map/torch
	default_assistant_title = "Passenger"
