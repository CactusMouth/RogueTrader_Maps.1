#ifndef PSI_IMPLANT_AUTOMATIC
#define PSI_IMPLANT_AUTOMATIC "Security Level Derived"
#endif
#ifndef PSI_IMPLANT_SHOCK
#define PSI_IMPLANT_SHOCK     "Issue Neural Shock"
#endif
#ifndef PSI_IMPLANT_WARN
#define PSI_IMPLANT_WARN      "Issue Reprimand"
#endif
#ifndef PSI_IMPLANT_LOG
#define PSI_IMPLANT_LOG       "Log Incident"
#endif
#ifndef PSI_IMPLANT_DISABLED
#define PSI_IMPLANT_DISABLED  "Disabled"
#endif

/datum/map/torch // setting the map to use this list
	security_state = /singleton/security_state/default/torchdept

//Torch map alert levels. Refer to security_state.dm.
/singleton/security_state/default/torchdept
	all_security_levels = list(/singleton/security_level/default/torchdept/code_green, /singleton/security_level/default/torchdept/code_violet, /singleton/security_level/default/torchdept/code_orange, /singleton/security_level/default/torchdept/code_blue, /singleton/security_level/default/torchdept/code_red, /singleton/security_level/default/torchdept/code_delta)

/singleton/security_level/default/torchdept
	icon = 'maps/torch/icons/security_state.dmi'

/singleton/security_level/default/torchdept/code_green
	name = "code green"
	icon = 'icons/misc/security_state.dmi'
	alarm_level = "off"

	light_range = 2
	light_power = 1
	light_color_alarm = COLOR_GREEN
	light_color_status_display = COLOR_GREEN

	overlay_alarm = "alarm_green"
	overlay_status_display = "status_display_green"
	alert_border = "alert_border_green"

	var/static/datum/announcement/priority/security/security_announcement_green = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/misc/redalert1.ogg'))

/singleton/security_level/default/torchdept/code_green/switching_down_to()
	security_announcement_green.Announce("The situation has been resolved, and all crew are to return to their regular duties.", "Attention! Alert level lowered to code green.")
	notify_station()

/singleton/security_level/default/torchdept/code_violet
	name = "code violet"
	alarm_level = "on"

	light_range = 2
	light_power = 1
	light_color_alarm = COLOR_VIOLET
	light_color_status_display = COLOR_VIOLET

	psionic_control_level = PSI_IMPLANT_DISABLED

	overlay_alarm = "alarm_violet"
	overlay_status_display = "status_display_violet"
	alert_border = "alert_border_violet"

	up_description = "A major medical emergency has developed. Medicae personnel are required to report to their supervisor for orders, and non-medical personnel are required to obey all relevant instructions from medical staff."
	down_description = "Code violet procedures are now in effect; Medicae personnel are required to report to their supervisor for orders, and non-medical personnel are required to obey relevant instructions from medical staff."

/singleton/security_level/default/torchdept/code_orange
	name = "code vermillion"
	alarm_level = "on"

	light_range = 2
	light_power = 1
	light_color_alarm = COLOR_ORANGE
	light_color_status_display = COLOR_ORANGE
	overlay_alarm = "alarm_orange"
	overlay_status_display = "status_display_orange"
	alert_border = "alert_border_orange"

	psionic_control_level = PSI_IMPLANT_DISABLED

	up_description = "A major engineering emergency has developed. Enginseer personnel are required to report to their appropriate Magos for orders."
	down_description = "Code orange procedures are now in effect; Enginseer personnel are required to report to their appropriate Magos for orders."


/singleton/security_level/default/torchdept/code_blue
	name = "code magenta"
	icon = 'icons/misc/security_state.dmi'
	alarm_level = "on"

	light_range = 2
	light_power = 1
	light_color_alarm = COLOR_BLUE
	light_color_status_display = COLOR_BLUE
	overlay_alarm = "alarm_blue"
	overlay_status_display = "status_display_blue"
	alert_border = "alert_border_blue"

	psionic_control_level = PSI_IMPLANT_DISABLED

	up_description = "Augery sensorum reports possible hostile presence within proximity to the Dauntless. Non militarum personnel below clearance Omega may be given arms and wargear, capital judgment may be delivered in special cases."
	down_description = "The immediate threat has passed. Theta clearance personnel may continue security and protection details if necessary."

/singleton/security_level/default/torchdept/code_red
	name = "code vermillion"
	icon = 'icons/misc/security_state.dmi'
	alarm_level = "on"

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_RED
	light_color_status_display = COLOR_RED
	overlay_alarm = "alarm_red"
	overlay_status_display = "status_display_red"
	alert_border = "alert_border_red"

	up_description = "Augery sensorum reports major hostile presence within proximity to the Dauntless. Non militarum personnel below clearance Omega may be given arms and wargear, capital judgment may be delivered without hesitation."
	down_description = "The immediate threat is being contained. Theta clearance personnel may continue security and protection details until relieved of duty."
	psionic_control_level = PSI_IMPLANT_DISABLED

	var/static/datum/announcement/priority/security/security_announcement_red = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/misc/redalert1.ogg'))

/singleton/security_level/default/torchdept/code_red/switching_up_to()
	security_announcement_red.Announce(up_description, "Attention! Code red alert procedures now in effect!")
	notify_station()
	GLOB.using_map.unbolt_saferooms()

/singleton/security_level/default/torchdept/code_red/switching_down_to()
	security_announcement_red.Announce("Code Delta has been disengaged. All staff are to report to their supervisor for orders. All crew should obey orders from relevant emergency personnel. Security personnel are permitted to search staff and facilities, and may have weapons unholstered at any time.", "Attention! Code red alert procedures now in effect!")
	notify_station()

/singleton/security_level/default/torchdept/code_delta
	name = "code lambda"
	icon = 'icons/misc/security_state.dmi'
	alarm_level = "on"

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_RED
	light_color_status_display = COLOR_NAVY_BLUE

	overlay_alarm = "alarm_delta"
	overlay_status_display = "status_display_delta"
	alert_border = "alert_border_delta"

	var/static/datum/announcement/priority/security/security_announcement_delta = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/effects/siren.ogg'))

/singleton/security_level/default/torchdept/code_delta/switching_up_to()
	security_announcement_delta.Announce("The self-destruct mechanism has been engaged. All crew are instructed to obey all instructions given by commanding officers. Any violations of these orders will be immediately punished by death.", "Attention! Lambda security level reached!")
	notify_station()

#undef PSI_IMPLANT_AUTOMATIC
#undef PSI_IMPLANT_SHOCK
#undef PSI_IMPLANT_WARN
#undef PSI_IMPLANT_LOG
#undef PSI_IMPLANT_DISABLED
