//start_unprocessed_text
/*integer     intLine1;
key         keyConfigQueryhandle;
key         keyConfigUUID;

string  note_name;
list    note_contents;

integer rat_mode;

integer readnote(string notename)
{
    note_name = notename;
    if (llGetInventoryType(note_name) == INVENTORY_NONE)
    {
        return 0; /|/ no notecard
    }
    intLine1 = 0;
    note_contents = []; /|/ flush the contents buffer
    keyConfigQueryhandle = llGetNotecardLine(note_name, intLine1);
    keyConfigUUID = llGetInventoryKey(note_name);
    return 1;
}

sendresults()
{
    llMessageLinked(LINK_THIS, 0, "note_fetched " + llDumpList2String(note_contents, "\n"), NULL_KEY);
}

sendratresults()
{
    llMessageLinked(LINK_THIS, 0, "note_fetched_rationed " + llList2String(note_contents, 0), NULL_KEY);
    note_contents = [];
}

default
{
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
            
            if(cmd == "fetch_note")
            {
                string nname = llDumpList2String(llList2ListStrided(params, 1, -1, 1), " ");
                if(readnote(nname) == 0)
                {
                    llMessageLinked(LINK_THIS, 0, "note_not_found " + nname, NULL_KEY);
                }
                rat_mode = 0;
                /|/else it will return the results in dataserver function
            }
            if(cmd == "fetch_note_rationed")
            {
                string nname = llDumpList2String(llList2ListStrided(params, 1, -1, 1), " ");
                if(readnote(nname) == 0)
                {
                    llMessageLinked(LINK_THIS, 0, "note_not_found " + nname, NULL_KEY);
                }
                llMessageLinked(LINK_THIS, 0, "fn_ration_start " + nname, NULL_KEY);
                rat_mode = 1;
                /|/else it will return the results in dataserver function
            }
        }
    }

    dataserver(key keyQueryId, string strData)
    {
        if (keyQueryId == keyConfigQueryhandle)
        {
            if (strData == EOF)
            {
                if(rat_mode == 1)
                {
                    llMessageLinked(LINK_THIS, 0, "fn_ration_finish " + note_name, NULL_KEY);
                }
                else /|/ non ration mode
                {
                    sendresults();
                }
            }
            else
            {
                keyConfigQueryhandle = llGetNotecardLine(note_name, ++intLine1);
                strData = llStringTrim(strData, STRING_TRIM_HEAD);
    
                if (llGetSubString (strData, 0, 0) != "#")/|/ exclude comments
                {
                    note_contents += strData;
                    if(rat_mode == 1)
                    {
                        sendratresults();
                    }
                }
            }
        }
    }
}*/
//end_unprocessed_text
//nfo_preprocessor_version 0
//program_version Firestorm-Releasex64 5.0.11.53634 - Monkibones
//last_compiled 06/04/2018 04:33:47
//mono




integer     intLine1;
key         keyConfigQueryhandle;
key         keyConfigUUID;

string  note_name;
list    note_contents;

integer rat_mode;

sendresults()
{
    llMessageLinked(LINK_THIS, 0, "note_fetched " + llDumpList2String(note_contents, "\n"), NULL_KEY);
}

sendratresults()
{
    llMessageLinked(LINK_THIS, 0, "note_fetched_rationed " + llList2String(note_contents, 0), NULL_KEY);
    note_contents = [];
}

integer readnote(string notename)
{
    note_name = notename;
    if (llGetInventoryType(note_name) == INVENTORY_NONE)
    {
        return 0; 
    }
    intLine1 = 0;
    note_contents = []; 
    keyConfigQueryhandle = llGetNotecardLine(note_name, intLine1);
    keyConfigUUID = llGetInventoryKey(note_name);
    return 1;
}

default
{
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
            
            if(cmd == "fetch_note")
            {
                string nname = llDumpList2String(llList2ListStrided(params, 1, -1, 1), " ");
                if(readnote(nname) == 0)
                {
                    llMessageLinked(LINK_THIS, 0, "note_not_found " + nname, NULL_KEY);
                }
                rat_mode = 0;
                
            }
            if(cmd == "fetch_note_rationed")
            {
                string nname = llDumpList2String(llList2ListStrided(params, 1, -1, 1), " ");
                if(readnote(nname) == 0)
                {
                    llMessageLinked(LINK_THIS, 0, "note_not_found " + nname, NULL_KEY);
                }
                llMessageLinked(LINK_THIS, 0, "fn_ration_start " + nname, NULL_KEY);
                rat_mode = 1;
                
            }
        }
    }

    dataserver(key keyQueryId, string strData)
    {
        if (keyQueryId == keyConfigQueryhandle)
        {
            if (strData == EOF)
            {
                if(rat_mode == 1)
                {
                    llMessageLinked(LINK_THIS, 0, "fn_ration_finish " + note_name, NULL_KEY);
                }
                else 
                {
                    sendresults();
                }
            }
            else
            {
                keyConfigQueryhandle = llGetNotecardLine(note_name, ++intLine1);
                strData = llStringTrim(strData, STRING_TRIM_HEAD);
    
                if (llGetSubString (strData, 0, 0) != "#")
                {
                    note_contents += strData;
                    if(rat_mode == 1)
                    {
                        sendratresults();
                    }
                }
            }
        }
    }
}
