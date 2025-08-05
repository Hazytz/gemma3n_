if (async_load[? "id"] == npc_request_id)
{
    npc_request_id = -1;

    if (async_load[? "result"] != "")
    {
        var result = async_load[? "result"];
        var json = json_parse(result);

        var npc_reply = json.reply;
		
		array_push(dialog_history, { who: "You", msg: npc_reply });
		if (array_length(dialog_history) > 10) {
		    array_delete(dialog_history, 0, 1);
			array_delete(dialog_history, 0, 1);
		}

        var dialog = [
            { name: "Red Mage", msg: npc_reply }
        ];

        create_dialog(dialog);
    }
    else
    {
        show_debug_message("NPC server returned no result.");
    }
}