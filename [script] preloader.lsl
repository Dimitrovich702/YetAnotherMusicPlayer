//start_unprocessed_text
/*default
{
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if(num == 0)
        {
            list params = llParseString2List(msg, [" "], []);
            string cmd = llList2String(params, 0);
            string param1 = llList2String(params, 1);
            if(cmd == "preload")
            {
                llPreloadSound(param1);
            }
        }
    }
}
*/
//end_unprocessed_text
//nfo_preprocessor_version 0
//program_version Firestorm-Releasex64 5.0.11.53634 - Monkibones
//last_compiled 06/04/2018 04:31:49
//mono




default
{
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if(num == 0)
        {
            list params = llParseString2List(msg, [" "], []);
            string cmd = llList2String(params, 0);
            string param1 = llList2String(params, 1);
            if(cmd == "preload")
            {
                llPreloadSound(param1);
            }
        }
    }
}

