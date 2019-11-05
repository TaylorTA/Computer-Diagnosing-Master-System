:-include('exshell').

% rule base:

% Top level goal, starts search.
rule((fix_computer(Advice) :-  
	bad_component(Y), fix(Y,Advice)),100).


% rules to infer bad component:

% IF bad-system == no_power AND power_cable_damage, THEN bad_component = power_cable.
rule((bad_component(power_cable) :- bad_system(no_power), power_cable_damage),90).

% IF bad-system == no_power AND NOT(power_cable_damage) AND logic_board_lights_on, THEN bad_component = power_button.
rule((bad_component(power_button) :- bad_system(no_power), not(power_cable_damage), logic_board_lights_on),87).

% IF bad-system == no_power AND NOT(power_cable_damage) AND NOT(logic_board_lights_on) AND known_good_power_supply_works, THEN bad_component = power_supply.
rule((bad_component(power_supply) :- bad_system(no_power), not(power_cable_damage), not(logic_board_lights_on),known_good_power_supply_works),95).

% IF bad-system == no_power AND NOT(power_cable_damage) AND NOT(logic_board_lights_on) AND NOT(known_good_power_supply_works), THEN bad_component = logic_board.
rule((bad_component(logic_board) :- bad_system(no_power), not(power_cable_damage), not(logic_board_lights_on),not(known_good_power_supply_works)),50).

% IF bad-system == os_system AND safe_mode_success AND NOT(troubleshoot_success), THEN bad_component = os.
rule((bad_component(os) :- bad_system(os_system), safe_mode_success,not(troubleshoot_success)),60).

% IF bad-system == os_system AND safe_mode_success AND troubleshoot_success AND NOT(bad_performance), THEN bad_component = program.
rule((bad_component(program) :- bad_system(os_system), safe_mode_success,troubleshoot_success,not(bad_performance)),90).

% IF bad-system == os_system AND safe_mode_success AND troubleshoot_success AND bad_performance, THEN bad_component = pc.
rule((bad_component(pc) :- bad_system(os_system), safe_mode_success,troubleshoot_success,bad_performance),100).

% IF bad-system == os_system AND safe_mode_success, THEN bad_component = os.
rule((bad_component(os) :- bad_system(os_system), not(safe_mode_success)),90).

% IF bad-system == bios_system AND NOT(detect_hard_drive), THEN bad_component = hard_drive.
rule((bad_component(hard_drive) :- bad_system(bios_system), not(detect_hard_drive)),90).

% IF bad-system == bios_system AND detect_hard_drive, THEN bad_component = hard_drive.
rule((bad_component(os) :- bad_system(bios_system), detect_hard_drive),70).

% IF bad-system == no_system AND beep_sound, THEN bad_component = memory.
rule((bad_component(memory) :- bad_system(no_system), beep_sound),95).

% IF bad-system == no_system AND NOT(beep_sound) AND caps_lock_light_blinking, THEN bad_component = bios.
rule((bad_component(bios) :- bad_system(no_system), not(beep_sound), caps_lock_light_blinking),80).

% IF bad-system == no_system AND NOT(beep_sound) AND NOT(caps_lock_light_blinking) AND has_image_no_back_light, THEN bad_component = display.
rule((bad_component(display) :- bad_system(no_system), not(beep_sound), not(caps_lock_light_blinking),has_image_no_back_light),80).

% IF bad-system == no_system AND NOT(beep_sound) AND NOT(caps_lock_light_blinking) AND NOT(has_image_no_back_light) AND external_display_image, THEN bad_component = display.
rule((bad_component(display) :- bad_system(no_system), not(beep_sound), not(caps_lock_light_blinking),not(has_image_no_back_light),external_display_image),80).

% IF bad-system == no_system AND NOT(beep_sound) AND NOT(caps_lock_light_blinking) AND NOT(has_image_no_back_light) AND NOT(external_display_image), THEN bad_component = logic_board.
rule((bad_component(logic_board) :- bad_system(no_system), not(beep_sound), not(caps_lock_light_blinking),not(has_image_no_back_light),not(external_display_image)), 70).


% Rules to infer basic system that failed.

% IF powers_on AND NOT(boots_to_login_page) AND boots_to_BIOS, THEN bad_system = bios_system.
rule((bad_system(bios_system) :- powers_on, not(boots_to_login_page), boots_to_BIOS),90).

% IF powers_on AND boots_to_login_page, THEN bad_system = os_system.
rule((bad_system(os_system) :- powers_on, boots_to_login_page),80).

% IF NOT(powers_on), THEN bad_system = no_power.
rule((bad_system(no_power) :- not(powers_on)),90).

% IF powers_on AND NOT(boots_to_login_page) AND NOT(boots_to_BIOS), THEN bad_system = no_system.
rule((bad_system(no_system) :- powers_on, not(boots_to_login_page), not(boots_to_BIOS)),90).

% Rules to make reccommendation for repairs.

% IF bad_component == power_supply, THEN Advice = replace power supply.
rule(fix(power_supply,'replace power supply'),100).

% IF bad_component == power_cable, THEN Advice = replace power cable.
rule(fix(power_cable,'replace power cable'),100).

% IF bad_component == power_button, THEN Advice = replace power button.
rule(fix(power_button,'replace power button'),100).

% IF bad_component == memory, THEN Advice = replace power memory.
rule(fix(memory,'replace memory'),100).

% IF bad_component == display, THEN Advice = replace power display.
rule(fix(display,'replace display'),100).

% IF bad_component == pc, THEN Advice = replace computer.
rule(fix(pc,'replace computer'),100).

% IF bad_component == os, THEN Advice = reinstall Operate System.
rule(fix(os,'reinstall Operate System'),100).

% IF bad_component == program, THEN Advice = delete problem causing program.
rule(fix(program,'delete problem causing program'),100).

% IF bad_component == bios, THEN Advice = refresh BIOS System.
rule(fix(bios,'refresh BIOS System'),100).

% IF bad_component == hard_drive, THEN Advice = replace hard drive.
rule(fix(hard_drive,'replace hard drive'),100).

% IF bad_component == logic_board, THEN Advice = replace logic board.
rule(fix(logic_board,'replace logic_board'),100).


% askable descriptions

askable(powers_on).
askable(power_cable_damage).
askable(logic_board_lights_on).
askable(boots_to_login_page).
askable(boots_to_BIOS).
askable(beep_sound).
askable(safe_mode_success).
askable(troubleshoot_success).
askable(detect_hard_drive).
askable(no_black_light).
askable(caps_lock_light_blinking).
askable(external_display_image).
askable(has_image_no_back_light).
askable(known_good_power_supply_works).
askable(bad_performance).
