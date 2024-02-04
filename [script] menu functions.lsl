//start_unprocessed_text
/*/|/option vars
integer ichannel = 10909;

integer ext_volume;
integer loopit;
integer perm_mode; /|/ 0 = owner only, 1 = public

integer showsonginfo = 1;

/|/script vars
key cur_user;
integer cur_page = 1;

integer slist_size;
list songlist;

integer chanhandlr;

list numerizelist(list tlist, integer start, string apnd)
{
    list newlist;
    integer lsize = llGetListLength(tlist);
    integer i;
    for(; i < lsize; i++)
    {
        newlist += [(string)(start + i) + apnd + llList2String(tlist, i)];
    }
    return newlist;
}

lmsg(string msg)
{
    llMessageLinked(LINK_THIS, 0, msg, NULL_KEY);
}

ext_volume_change(integer vchange)
{
    ext_volume += vchange;
    if(ext_volume < 0) ext_volume = 0;
    lmsg("set_ext_volume " + (string)ext_volume);
}

list order_buttons(list buttons)
{
    return llList2List(buttons, -3, -1) + llList2List(buttons, -6, -4) +
        llList2List(buttons, -9, -7) + llList2List(buttons, -12, -10);
}

dialog_optionmenu()
{
    string loopstr = "Off";
    if(loopit) loopstr = "On";
    string permstr = "Owner Only";
    if(perm_mode) permstr = "Anyone";

    llDialog(cur_user,
            "[Options]:\nUsage: " + permstr + "\nLoop: " + loopstr + "\nVolume: " + (string)(ext_volume + 1),
            ["[O:Loop]", "[O:Usage]", "[Main]",
            "[Volume -1]", "[Volume +1]", "[]",
            "[Volume -5]", "[Volume +5]", "[]"],
            ichannel);
}

dialog_topmenu()
{
    llDialog(cur_user,
            "Choose an option",
            ["[Options]", "[Songs]", "[Search]",
            "[F: Stop]", "[F: Pause]", "[F: Play]",
            "[-]","[-]","[-]"],
            ichannel);
}

dialog_songmenu(integer page)
{
    integer pag_amt = llCeil((float)slist_size / 9.0);
    if(page > pag_amt) page = 1;
    else if(page < 1) page = pag_amt;
    cur_page = page;

    /|/insuring proper amount is shown if on last page
    integer songsonpage;
    if(page == pag_amt)
        songsonpage = slist_size % 9;
    if(songsonpage == 0)
        songsonpage = 9;

    integer fspnum = (page*9)-9;

    /|/making buttons for song nums
    list dbuf;
    integer i;
    for(; i < songsonpage; ++i)
    {
        dbuf += ["Play #" + (string)(fspnum+i)];
    }

    list snlist = numerizelist(llList2List(songlist, fspnum, (page*9)-1), fspnum, ". ");

    llDialog(cur_user,
            "Choose an song:\n" + llDumpList2String(snlist, "\n"),
            order_buttons(dbuf + ["<<<", "[Main]", ">>>"]),
            ichannel);
}

startup()
{
    songlist = list_inv(INVENTORY_NOTECARD);
    slist_size = llGetInventoryNumber(INVENTORY_NOTECARD);
}

list list_inv(integer itype)
{
    list    InventoryList;
    integer count = llGetInventoryNumber(itype);  /|/ Count of all items in prim's contents
    string  ItemName;
    while (count--)
    {
        ItemName = llGetInventoryName(itype, count);
        if (ItemName != llGetScriptName() )  
            InventoryList += ItemName;   /|/ add all contents except this script, to a list
    }
    return InventoryList;
}

default
{
    timer()
    {
        if(showsonginfo)
        {
            lmsg("updt_song_info");
        }
    }
    changed(integer change)
    {
        if (change & CHANGED_INVENTORY)         
        {
            startup();
        }
    }
    state_entry()
    {
        startup();
        llSetTimerEvent(1);
    }
    touch_start(integer total_number)
    {
        if(llDetectedKey(0) == llGetOwner() || perm_mode)
        {
            ichannel = llFloor(llFrand(1000000) - 100000);
            cur_user = llDetectedKey(0);
            llListenRemove(chanhandlr);
            chanhandlr = llListen(ichannel, "", NULL_KEY, "");
            dialog_topmenu();
        }
    }
    listen(integer chan, string sname, key skey, string text)
    {
        if(skey == llGetOwner() || perm_mode)
        {
            if(chan == ichannel)
            {
                if(text == "[Main]")
                    dialog_topmenu();
                else if(text == "[Songs]")
                    dialog_songmenu(cur_page);
                else if(text == "[Options]")
                    dialog_optionmenu();
                else if(text == "[Volume -1]")
                {
                    ext_volume_change(-1);
                    dialog_optionmenu();
                }
                else if(text == "[Volume -5]")
                {
                    ext_volume_change(-5);
                    dialog_optionmenu();
                }
                else if(text == "[Volume +1]")
                {
                    ext_volume_change(1);
                    dialog_optionmenu();
                }
                else if(text == "[Volume +5]")
                {
                    ext_volume_change(5);
                    dialog_optionmenu();
                }
                else if(text == "[O:Loop]")
                {
                    loopit = !loopit;
                    if(loopit) lmsg("loop_on");
                    else lmsg("loop_off");
                    dialog_optionmenu();
                }
                else if(text == "[O:Usage]")
                {
                    perm_mode = !perm_mode;
                    dialog_optionmenu();
                }
                else if(text == "[F: Stop]")
                {
                    lmsg("stop_song");
                    dialog_topmenu();
                }
                else if(text == "[F: Play]")
                {
                    lmsg("play_song");
                    dialog_topmenu();
                }
                else if(text == "[F: Pause]")
                {
                    lmsg("pause_song");
                    dialog_topmenu();
                }
                else if(text == ">>>")
                    dialog_songmenu(cur_page+1);
                else if(text == "<<<")
                    dialog_songmenu(cur_page-1);
                else if(llToLower(llGetSubString(text,0,5)) == "play #")
                {
                    integer pnum = (integer)llGetSubString(text, 6, -1);
                    lmsg("start_song " + llList2String(songlist, pnum));
                    dialog_topmenu();
                }
            }
        }
    }
}
*/
//end_unprocessed_text
//nfo_preprocessor_version 0
//program_version Firestorm-Releasex64 5.0.11.53634 - Monkibones
//last_compiled 06/04/2018 05:12:05
//mono





integer ichannel = 10909;

integer ext_volume;
integer loopit;
integer perm_mode; 

integer showsonginfo = 1;


key cur_user;
integer cur_page = 1;

integer slist_size;
list songlist;

integer chanhandlr;

list list_inv(integer itype)
{
    list    InventoryList;
    integer count = llGetInventoryNumber(itype);  
    string  ItemName;
    while (count--)
    {
        ItemName = llGetInventoryName(itype, count);
        if (ItemName != llGetScriptName() )  
            InventoryList += ItemName;   
    }
    return InventoryList;
}

startup()
{
    songlist = list_inv(INVENTORY_NOTECARD);
    slist_size = llGetInventoryNumber(INVENTORY_NOTECARD);
}

list order_buttons(list buttons)
{
    return llList2List(buttons, -3, -1) + llList2List(buttons, -6, -4) +
        llList2List(buttons, -9, -7) + llList2List(buttons, -12, -10);
}

list numerizelist(list tlist, integer start, string apnd)
{
    list newlist;
    integer lsize = llGetListLength(tlist);
    integer i;
    for(; i < lsize; i++)
    {
        newlist += [(string)(start + i) + apnd + llList2String(tlist, i)];
    }
    return newlist;
}

lmsg(string msg)
{
    llMessageLinked(LINK_THIS, 0, msg, NULL_KEY);
}

ext_volume_change(integer vchange)
{
    ext_volume += vchange;
    if(ext_volume < 0) ext_volume = 0;
    lmsg("set_ext_volume " + (string)ext_volume);
}

dialog_topmenu()
{
    llDialog(cur_user,
            "Choose an option",
            ["[Options]", "[Songs]", "[Search]",
            "[F: Stop]", "[F: Pause]", "[F: Play]",
            "[-]","[-]","[-]"],
            ichannel);
}

dialog_songmenu(integer page)
{
    integer pag_amt = llCeil((float)slist_size / 9.0);
    if(page > pag_amt) page = 1;
    else if(page < 1) page = pag_amt;
    cur_page = page;

    
    integer songsonpage;
    if(page == pag_amt)
        songsonpage = slist_size % 9;
    if(songsonpage == 0)
        songsonpage = 9;

    integer fspnum = (page*9)-9;

    
    list dbuf;
    integer i;
    for(; i < songsonpage; ++i)
    {
        dbuf += ["Play #" + (string)(fspnum+i)];
    }

    list snlist = numerizelist(llList2List(songlist, fspnum, (page*9)-1), fspnum, ". ");

    llDialog(cur_user,
            "Choose an song:\n" + llDumpList2String(snlist, "\n"),
            order_buttons(dbuf + ["<<<", "[Main]", ">>>"]),
            ichannel);
}

dialog_optionmenu()
{
    string loopstr = "Off";
    if(loopit) loopstr = "On";
    string permstr = "Owner Only";
    if(perm_mode) permstr = "Anyone";

    llDialog(cur_user,
            "[Options]:\nUsage: " + permstr + "\nLoop: " + loopstr + "\nVolume: " + (string)(ext_volume + 1),
            ["[O:Loop]", "[O:Usage]", "[Main]",
            "[Volume -1]", "[Volume +1]", "[]",
            "[Volume -5]", "[Volume +5]", "[]"],
            ichannel);
}

default
{
    timer()
    {
        if(showsonginfo)
        {
            lmsg("updt_song_info");
        }
    }
    changed(integer change)
    {
        if (change & CHANGED_INVENTORY)         
        {
            startup();
        }
    }
    state_entry()
    {
        startup();
        llSetTimerEvent(1);
    }
    touch_start(integer total_number)
    {
        if(llDetectedKey(0) == llGetOwner() || perm_mode)
        {
            ichannel = llFloor(llFrand(1000000) - 100000);
            cur_user = llDetectedKey(0);
            llListenRemove(chanhandlr);
            chanhandlr = llListen(ichannel, "", NULL_KEY, "");
            dialog_topmenu();
        }
    }
    listen(integer chan, string sname, key skey, string text)
    {
        if(skey == llGetOwner() || perm_mode)
        {
            if(chan == ichannel)
            {
                if(text == "[Main]")
                    dialog_topmenu();
                else if(text == "[Songs]")
                    dialog_songmenu(cur_page);
                else if(text == "[Options]")
                    dialog_optionmenu();
                else if(text == "[Volume -1]")
                {
                    ext_volume_change(-1);
                    dialog_optionmenu();
                }
                else if(text == "[Volume -5]")
                {
                    ext_volume_change(-5);
                    dialog_optionmenu();
                }
                else if(text == "[Volume +1]")
                {
                    ext_volume_change(1);
                    dialog_optionmenu();
                }
                else if(text == "[Volume +5]")
                {
                    ext_volume_change(5);
                    dialog_optionmenu();
                }
                else if(text == "[O:Loop]")
                {
                    loopit = !loopit;
                    if(loopit) lmsg("loop_on");
                    else lmsg("loop_off");
                    dialog_optionmenu();
                }
                else if(text == "[O:Usage]")
                {
                    perm_mode = !perm_mode;
                    dialog_optionmenu();
                }
                else if(text == "[F: Stop]")
                {
                    lmsg("stop_song");
                    dialog_topmenu();
                }
                else if(text == "[F: Play]")
                {
                    lmsg("play_song");
                    dialog_topmenu();
                }
                else if(text == "[F: Pause]")
                {
                    lmsg("pause_song");
                    dialog_topmenu();
                }
                else if(text == ">>>")
                    dialog_songmenu(cur_page+1);
                else if(text == "<<<")
                    dialog_songmenu(cur_page-1);
                else if(llToLower(llGetSubString(text,0,5)) == "play #")
                {
                    integer pnum = (integer)llGetSubString(text, 6, -1);
                    lmsg("start_song " + llList2String(songlist, pnum));
                    dialog_topmenu();
                }
            }
        }
    }
}
// sound in sl wont go over 1 
