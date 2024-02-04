//start_unprocessed_text
/*/|/setvars
integer loopit;
integer ext_volume = 0;

float volume = 1.00;

integer song_index;
list loaded_song;
string song_name;
float song_int;

float song_time;
float last_interval;

integer playing; /|/ 1 = playing, 2 = paused, 0 = stopped
integer rationing;

stopsound()
{
    llStopSound();
    llMessageLinked(LINK_SET, 1029, "", NULL_KEY);
}
playsound(key soundkey, float svolume)
{
    if(ext_volume > 0) llMessageLinked(LINK_SET, 1000+ext_volume, (string)svolume, soundkey);
    llPlaySound(llList2String(loaded_song, song_index), 1.0);
}

string flt_cut(string input)
{
    return llGetSubString(input, 0, llSubStringIndex(input, ".")+1);
}

string time_format(float input)
{
    string seconds = (string)(llCeil(input) % 60);
    string minutes = (string)(llCeil(input) / 60);
    seconds = llInsertString(seconds,-1,"00");
    seconds = llGetSubString(seconds, llStringLength(seconds)-2, -1);
    return minutes + ":" + seconds;
}

string song_time_str()
{
    if(playing == 2)
        return time_format(song_time - (song_int * song_index) ) + "/" + time_format(song_time);
    else
        return time_format(song_time - ( (song_int * song_index)+(llGetTime()-last_interval) ) ) + "/" + time_format(song_time);
}

playrsong()
{
    song_index = 0;
    llPreloadSound(llList2String(loaded_song, song_index));
    playsound(llList2Key(loaded_song, song_index), volume);
    llSetTimerEvent(song_int);
    last_interval = llGetTime();
    if(playing < 2)
        llSay(0, "Playing: " + song_name);
    playing = 1;
}
continuesong()
{
    playing = 1;
    llPreloadSound(llList2String(loaded_song, song_index));
    playsound(llList2Key(loaded_song, song_index), volume);
    llSetTimerEvent(song_int);
    last_interval = llGetTime();
}

pausesong()
{
    playing = 2;
    stopsound();
    llSetTimerEvent(0);
}

stopsong()
{
    playing = 0;
    song_index = 0;
    stopsound();
    llSetTimerEvent(0);
}

updt_song_info()
{
    if(playing == 1)
    {
        if(rationing)
            llSetText("Song: " + song_name, <0,1,0>, 1);
        else
        {
            llSetText("Song: "
            + song_name
            + "\nTime: "
            + song_time_str()
            , <0,1,0>, 1);
        }
    }
    else if(playing == 2)
    {
        if(rationing)
            llSetText("[PAUSED]\nSong: " + song_name, <0,1,0>, 1);
        else
        {
            llSetText("[PAUSED]\nSong: "
            + song_name
            + "\nTime: "
            + song_time_str()
            , <0,1,0>, 1);
        }
    }
    else
        llSetText("", ZERO_VECTOR, 0);
}

default
{
    timer()
    {
        last_interval = llGetTime();
        if(++song_index < llGetListLength(loaded_song))
        {
            playsound(llList2Key(loaded_song, song_index), volume);
            if(song_index+1 < llGetListLength(loaded_song))
            {
                llMessageLinked(LINK_THIS, 0, "preload " + llList2String(loaded_song, song_index+1), NULL_KEY);
            }
        }
        else /|/ song is done!
        {
            if(loopit)
            {
                pausesong();
                song_index = 0;
                continuesong();
            }
            else
                stopsong();
        }
    }
    state_entry()
    {
        
    }
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if(num == 0)
        {
            list params = llParseString2List(msg, [" "], []);
            string cmd = llList2String(params, 0);
            string param1 = llList2String(params, 1);
            
            if(cmd == "updt_song_info")
            {
                updt_song_info();
            }
            else if(cmd == "note_fetched_rationed")
            {
                if(rationing == 1)
                {
                    song_int = (float)param1;
                    loaded_song = [];
                }
                else if(rationing > 1)
                {
                    loaded_song += param1;
                    if(rationing == 2)
                    {
                        playrsong();
                    }
                }
                ++rationing;
            }
            else if(cmd == "fn_ration_start")
            {
                rationing = 1;
            }
            else if(cmd == "fn_ration_finish")
            {
                rationing = 0;
                song_time = (float)llGetListLength(loaded_song) * song_int;
            }
            else if(cmd == "note_not_found")
            {
                llOwnerSay("404: Note not found");
            }
            else if(cmd == "start_song")
            {
                song_name = llDumpList2String(llList2ListStrided(params, 1, -1, 1), " ");
                llMessageLinked(LINK_THIS, 0, "fetch_note_rationed " + song_name, NULL_KEY);
            }
            else if(cmd == "stop_song")
            {
                stopsong();
            }
            else if(cmd == "pause_song")
            {
                pausesong();
            }
            else if(cmd == "play_song")
            {
                if(loaded_song != [])
                {
                    if(playing == 2)
                        continuesong();
                    else
                        playrsong();
                }
            }
            else if(cmd == "loop_on")
                loopit = 1;
            else if(cmd == "loop_off")
                loopit = 0;
            else if(cmd == "set_ext_volume")
            {
                ext_volume = (integer)param1;
            }
        }
    }
}
*/
//end_unprocessed_text
//nfo_preprocessor_version 0
//program_version Firestorm-Releasex64 5.0.11.53634 - Monkibones
//last_compiled 06/04/2018 05:00:20
//mono





integer loopit;
integer ext_volume = 0;

float volume = 1.00;

integer song_index;
list loaded_song;
string song_name;
float song_int;

float song_time;
float last_interval;

integer playing; 
integer rationing;

string time_format(float input)
{
    string seconds = (string)(llCeil(input) % 60);
    string minutes = (string)(llCeil(input) / 60);
    seconds = llInsertString(seconds,-1,"00");
    seconds = llGetSubString(seconds, llStringLength(seconds)-2, -1);
    return minutes + ":" + seconds;
}

string song_time_str()
{
    if(playing == 2)
        return time_format(song_time - (song_int * song_index) ) + "/" + time_format(song_time);
    else
        return time_format(song_time - ( (song_int * song_index)+(llGetTime()-last_interval) ) ) + "/" + time_format(song_time);
}

updt_song_info()
{
    if(playing == 1)
    {
        if(rationing)
            llSetText("Song: " + song_name, <0,1,0>, 1);
        else
        {
            llSetText("Song: "
            + song_name
            + "\nTime: "
            + song_time_str()
            , <0,1,0>, 1);
        }
    }
    else if(playing == 2)
    {
        if(rationing)
            llSetText("[PAUSED]\nSong: " + song_name, <0,1,0>, 1);
        else
        {
            llSetText("[PAUSED]\nSong: "
            + song_name
            + "\nTime: "
            + song_time_str()
            , <0,1,0>, 1);
        }
    }
    else
        llSetText("", ZERO_VECTOR, 0);
}

stopsound()
{
    llStopSound();
    llMessageLinked(LINK_SET, 1029, "", NULL_KEY);
}

stopsong()
{
    playing = 0;
    song_index = 0;
    stopsound();
    llSetTimerEvent(0);
}
playsound(key soundkey, float svolume)
{
    if(ext_volume > 0) llMessageLinked(LINK_SET, 1000+ext_volume, (string)svolume, soundkey);
    llPlaySound(llList2String(loaded_song, song_index), 1.0);
}

playrsong()
{
    song_index = 0;
    llPreloadSound(llList2String(loaded_song, song_index));
    playsound(llList2Key(loaded_song, song_index), volume);
    llSetTimerEvent(song_int);
    last_interval = llGetTime();
    if(playing < 2)
        llSay(0, "Playing: " + song_name);
    playing = 1;
}

pausesong()
{
    playing = 2;
    stopsound();
    llSetTimerEvent(0);
}
continuesong()
{
    playing = 1;
    llPreloadSound(llList2String(loaded_song, song_index));
    playsound(llList2Key(loaded_song, song_index), volume);
    llSetTimerEvent(song_int);
    last_interval = llGetTime();
}

default
{
    timer()
    {
        last_interval = llGetTime();
        if(++song_index < llGetListLength(loaded_song))
        {
            playsound(llList2Key(loaded_song, song_index), volume);
            if(song_index+1 < llGetListLength(loaded_song))
            {
                llMessageLinked(LINK_THIS, 0, "preload " + llList2String(loaded_song, song_index+1), NULL_KEY);
            }
        }
        else 
        {
            if(loopit)
            {
                pausesong();
                song_index = 0;
                continuesong();
            }
            else
                stopsong();
        }
    }
    state_entry()
    {
        
    }
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if(num == 0)
        {
            list params = llParseString2List(msg, [" "], []);
            string cmd = llList2String(params, 0);
            string param1 = llList2String(params, 1);
            
            if(cmd == "updt_song_info")
            {
                updt_song_info();
            }
            else if(cmd == "note_fetched_rationed")
            {
                if(rationing == 1)
                {
                    song_int = (float)param1;
                    loaded_song = [];
                }
                else if(rationing > 1)
                {
                    loaded_song += param1;
                    if(rationing == 2)
                    {
                        playrsong();
                    }
                }
                ++rationing;
            }
            else if(cmd == "fn_ration_start")
            {
                rationing = 1;
            }
            else if(cmd == "fn_ration_finish")
            {
                rationing = 0;
                song_time = (float)llGetListLength(loaded_song) * song_int;
            }
            else if(cmd == "note_not_found")
            {
                llOwnerSay("404: Note not found");
            }
            else if(cmd == "start_song")
            {
                song_name = llDumpList2String(llList2ListStrided(params, 1, -1, 1), " ");
                llMessageLinked(LINK_THIS, 0, "fetch_note_rationed " + song_name, NULL_KEY);
            }
            else if(cmd == "stop_song")
            {
                stopsong();
            }
            else if(cmd == "pause_song")
            {
                pausesong();
            }
            else if(cmd == "play_song")
            {
                if(loaded_song != [])
                {
                    if(playing == 2)
                        continuesong();
                    else
                        playrsong();
                }
            }
            else if(cmd == "loop_on")
                loopit = 1;
            else if(cmd == "loop_off")
                loopit = 0;
            else if(cmd == "set_ext_volume")
            {
                ext_volume = (integer)param1;
            }
        }
    }
}

