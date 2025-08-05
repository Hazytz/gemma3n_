if (!(instance_exists(oPlayer) && distance_to_object(oPlayer) < interaction_radius)) {
    can_talk     = false;
    input_active = false;
    exit;  
}

can_talk = true;

if (keyboard_check_pressed(input_key)
 && !instance_exists(oDialog)
 && npc_request_id == -1)
{
    // spawn dialog
    instance_create_depth(0, 0, -100, oDialog);

    // now start typing
    input_active    = true;
    input_buffer    = "";
    keyboard_string = "";   
}

if (input_active) {
    input_buffer = keyboard_string;
	var history_text = "";

    if (keyboard_check_pressed(vk_enter)) {
		
		for (var i = 0; i < array_length(dialog_history); i++) {
		    var entry = dialog_history[i];
		    history_text += entry.who + ": " + entry.msg + "\n";
		}
		
		
        var url    = "http://127.0.0.1:5000/chat";
        var prompt = input_buffer;
        var context =  "Your name is Kael, the Ember-Sage, a passionate and fiery master of flame and destruction. You are known for your boldness, your commanding presence, and your burning desire to protect the innocent. Legends say you once turned an entire battlefield to ash with a single word. You admire strength, courage, and decisive action. Though quick-tempered, your heart burns for justice. Your knowledge of volcano spirits, cursed flames, and fire-wrought relics is unmatched. Do not describe your actions. Do not use blank lines, keep the text all togheter. Be brief"+
					    "Here are the last exchanges you had with this person:\n" +
					    history_text +
					    "\nAnswer as Kael:"; 
	    var json_data  = json_stringify({
	        "context": context,  
	        "prompt":  input_buffer
	    });
		
		
		array_push(dialog_history, { who: "Player", msg: input_buffer });
		
	    npc_request_id = http_post_string(url, json_data);

	    input_active    = false;
	    input_buffer    = "";
	    keyboard_string = "";
    }
}