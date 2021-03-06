//allows right clicking mobs to send an admin PM to their client, forwards the selected mob's client to cmd_admin_pm
/client/proc/cmd_admin_pm_context(mob/M as mob in mob_list)
	set category = null
	set name = "Admin PM Mob"
	if(!holder)
		to_chat(src, "<font color='red'>Error: Admin-PM-Context: Only administrators may use this command.</font>")
		return
	if( !ismob(M) || !M.client )	return
	cmd_admin_pm(M.client,null)
	feedback_add_details("admin_verb","APMM") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

//shows a list of clients we could send PMs to, then forwards our choice to cmd_admin_pm
/client/proc/cmd_admin_pm_panel()
	set category = "Admin"
	set name = "Admin PM"
	if(!holder)
		to_chat(src, "<font color='red'>Error: Admin-PM-Panel: Only administrators may use this command.</font>")
		return
	var/list/client/targets[0]
	for(var/client/T)
		if(T.mob)
			if(istype(T.mob, /mob/new_player))
				targets["(New Player) - [T]"] = T
			else if(istype(T.mob, /mob/dead/observer))
				targets["[T.mob.name](Ghost) - [T]"] = T
			else
				targets["[T.mob.real_name](as [T.mob.name]) - [T]"] = T
		else
			targets["(No Mob) - [T]"] = T
	var/list/sorted = sortList(targets)
	var/target = input(src,"To whom shall we send a message?","Admin PM",null) in sorted|null
	cmd_admin_pm(targets[target],null)
	feedback_add_details("admin_verb","APM") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


//takes input from cmd_admin_pm_context, cmd_admin_pm_panel or /client/Topic and sends them a PM.
//Fetching a message if needed. src is the sender and C is the target client

/client/proc/cmd_admin_pm(var/client/C, var/msg = null)
	if(prefs.muted & MUTE_ADMINHELP)
		to_chat(src, "<font color='red'>Error: Private-Message: You are unable to use PMs (muted).</font>")
		return

	if(!istype(C,/client))
		if(holder)	to_chat(src, "<font color='red'>Error: Private-Message: Client not found.</font>")
		else		to_chat(src, "<font color='red'>Error: Private-Message: Client not found. They may have lost connection, so try using an adminhelp!</font>")
		return

	//get message text, limit it's length.and clean/escape html
	if(!msg)
		msg = input(src,"Message:", "Private message to [key_name(C, 0, holder ? 1 : 0)]") as message|null

		if(!msg)	return
		if(!C)
			if(holder)	to_chat(src, "<font color='red'>Error: Admin-PM: Client not found.</font>")
			else		to_chat(src, "<font color='red'>Error: Private-Message: Client not found. They may have lost connection, so try using an adminhelp!</font>")
			return

	if (src.handle_spam_prevention(msg,MUTE_ADMINHELP))
		return

	//clean the message if it's not sent by a high-rank admin
	if(!check_rights(R_SERVER|R_DEBUG,0))
		msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
		if(!msg)	return

	var/recieve_color = "purple"
	var/send_pm_type = " "
	var/recieve_pm_type = "Player"


	if(holder)
		//PMs sent from admins and mods display their rank
		if(holder)
			recieve_color = "#009900"
			send_pm_type = holder.rank + " "
			if(!C.holder && holder && holder.fakekey)
				recieve_pm_type = "Admin"
			else
				recieve_pm_type = holder.rank

	else if(!C.holder)
		to_chat(src, "<font color='red'>Error: Admin-PM: Non-admin to non-admin PM communication is forbidden.</font>")
		return

	var/recieve_message = ""

	if(holder && !C.holder)
		recieve_message = "<font color='[recieve_color]'><b>-- Click the [recieve_pm_type]'s name to reply --</b></font>\n"
		if(C.adminhelped)
			to_chat(C, recieve_message)
			C.adminhelped = 0

		//AdminPM popup for ApocStation and anybody else who wants to use it. Set it with POPUP_ADMIN_PM in config.txt ~Carn
		if(config.popup_admin_pm)
			spawn(0)	//so we don't hold the caller proc up
				var/sender = src
				var/sendername = key
				var/reply = input(C, msg,"[recieve_pm_type] PM from-[sendername]", "") as text|null		//show message and await a reply
				if(C && reply)
					if(sender)
						C.cmd_admin_pm(sender,reply)										//sender is still about, let's reply to them
					else
						adminhelp(reply)													//sender has left, adminhelp instead
				return

	recieve_message = "<br><br><font color='[recieve_color]'><b>[recieve_pm_type] PM from [get_options_bar(src, C.holder ? 1 : 0, C.holder ? 1 : 0, 1)]: <font color='#DA6200'>[msg]</b></font><br>"
	to_chat(C, recieve_message)
	to_chat(src, "<br><br><font color='#009900'><b>[send_pm_type]PM to [get_options_bar(C, holder ? 1 : 0, holder ? 1 : 0, 1)]: <font color='#DA6200'>[msg]</b></font><br>")

	//play the recieving admin the adminhelp sound (if they have them enabled)
	//non-admins shouldn't be able to disable this
	if(C.prefs && C.prefs.toggles_sound & SOUND_ADMINHELP)
		C << 'sound/effects/adminhelp-reply.ogg'

	log_admin("PM: [key_name(src)]->[key_name(C)]: [msg]")

	//we don't use message_admins here because the sender/receiver might get it too
	for(var/client/X in admins)
		//check client/X is an admin and isn't the sender or recipient
		if(X == C || X == src)
			continue
		if(X.key!=key && X.key!=C.key && (X.holder.rights & R_ADMIN) || (X.holder.rights & (R_MOD|R_MENTOR)) )
			to_chat(X, "<B><font color='blue'>PM: [key_name(src, X, 0)]-&gt;[key_name(C, X, 0)]:</B> <span class='notice'> [msg]</font></span>")
