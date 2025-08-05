function create_dialog(_messages){
	if (!instance_exists(oDialog)) {
	    var _inst = instance_create_depth(0, 0, -100, oDialog);
	}
	else {
	    // grab the first existing one
	    var _inst = instance_find(oDialog, 0);
	}
	_inst.messages = _messages;
	_inst.current_message = 0;

}

waiting_for_reply = false;
chat_input = "";
chat_active = false;
last_ai_reply = "";


test_dialog = [
	{
		name: "Test",
		msg: "Working"
	}
]

function paginate_message(raw_text) {
    var WORDS_PER_PAGE = 60;        
    var words          = string_split(raw_text, " ");
    page_texts         = [];
    
    var total_words = array_length(words);
    var total_pages = ceil(total_words / WORDS_PER_PAGE);
    
    // build each page by slicing out WORDS_PER_PAGE words
    for (var p = 0; p < total_pages; p++) {
        var start = p * WORDS_PER_PAGE;
        var _end   = min(start + WORDS_PER_PAGE - 1, total_words - 1);
        
        // join that slice back into a single string (with a trailing space)
        var chunk = "";
        for (var i = start; i <= _end; i++) {
            chunk += words[i] + " ";
        }
        
        array_push(page_texts, chunk);
        show_debug_message("Page " + string(p+1) + "/" + string(total_pages) + ": " + chunk);
    }
    
    page_index = 0;
}