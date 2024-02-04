//start_unprocessed_text
/*default
{
    link_message(integer Sender, integer Number, string String, key Key)
    {
        if(Number >= 1021)
        {
            if(Key == NULL_KEY)
                llStopSound();
            else
                llPlaySound(Key, (float)String);
        }
    }
}
*/
//end_unprocessed_text
//nfo_preprocessor_version 0
//program_version Firestorm-Releasex64 5.0.11.53634 - Monkibones
//last_compiled 06/04/2018 04:51:39
// NOTE THIS GOES OUTSIDE THE MAIN MUSIC BOX AND WORKS AS HANDLER FOR THE MAIN HANDLER 
// so for every list more or less what they did in the past is having 1 box and 1 script to listen and handle per each notecard 
// something i personally dislike why they did this? not sure if lack of developing things? does it makes it smoother? IDK ok  the song plays but you must have a thousand scripts running per music box or insturment per people using it on the same place 
// how much memory consumes having the same code running lets say a million times at once supposing a thousand people is using their music player, supposing also ten people are at some sim and they having each of themn between one or two musical instruments or a phone 
// then these scripts not sleeping are consuming memory right? how much 2112 KB per each rezed around aditional 2 mb of memory OK works but what it is its optimization, how much $ money cost having those 2 mb aditional running forever/ my avatar weights between 4000 and 5000 complexity very little 
// supposing i am a jomo bull and i am only wearing some combat huds - does it has comparison to 350.000 complexity avatars / no but what is the media for avatar on virtual reality around more than 250.000 supposing you have mesh body and it looks decent 
// people who makes or uses things do not care how much something consumes https://wiki.secondlife.com/wiki/How_to_run_SL_faster 
// Deimanovs 2024 january 14 
// Dimitrovich 2024 feb 4 
//mono




default
{
    link_message(integer Sender, integer Number, string String, key Key)
    {
        if(Number >= 1021)
        {
            if(Key == NULL_KEY)
                llStopSound();
            else
                llPlaySound(Key, (float)String);
        }
    }
}

